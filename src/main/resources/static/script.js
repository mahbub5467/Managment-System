"use strict";

/* =========================================================================
   GPF CALCULATOR — script.js
   Fiscal year months: July -> June (Bangladesh government fiscal year)
   ========================================================================= */

const MONTHS_BN = ["জুলাই","আগস্ট","সেপ্টেম্বর","অক্টোবর","নভেম্বর","ডিসেম্বর",
    "জানুয়ারি","ফেব্রুয়ারি","মার্চ","এপ্রিল","মে","জুন"];

/* -------------------------------------------------------------------------
   GPFCalculatorService
   All business rules live here. UI code never computes money itself —
   it only collects input and renders whatever this service returns.
   ------------------------------------------------------------------------- */
const GPFCalculatorService = (() => {

    // ---- helpers ----
    function round2(n){ return Math.round((n + Number.EPSILON) * 100) / 100; }

    // Interest months: July earns 11 months' interest, June earns 0.
    function interestMonthsFor(monthIndex){ return 11 - monthIndex; }

    /**
     * CalculateOpeningInterest
     */
    function CalculateOpeningInterest(openingBalance, slabConfig){
        const { tier1Cap, tier1Rate, tier2Cap, tier2Rate, tier3Rate } = slabConfig;
        const breakdown = [];

        let remaining = openingBalance;
        const t1 = Math.min(remaining, tier1Cap);
        remaining -= t1;
        const t2 = Math.min(remaining, tier2Cap);
        remaining -= t2;
        const t3 = Math.max(remaining, 0);

        const i1 = t1 * (tier1Rate/100);
        const i2 = t2 * (tier2Rate/100);
        const i3 = t3 * (tier3Rate/100);
        const interest = i1 + i2 + i3;

        if (t1 > 0) breakdown.push({ label:`১ম ধাপ (১-১৫ লাখ) @ ${tier1Rate}%`, amount:t1, rate:tier1Rate, interest:round2(i1) });
        if (t2 > 0) breakdown.push({ label:`২য় ধাপ (১৫-৩০ লাখ) @ ${tier2Rate}%`, amount:t2, rate:tier2Rate, interest:round2(i2) });
        if (t3 > 0) breakdown.push({ label:`৩০ লাখের বেশি @ ${tier3Rate}%`, amount:t3, rate:tier3Rate, interest:round2(i3) });

        return { interest: round2(interest), breakdown };
    }

    /**
     * rateWeightedAmount
     */
    function rateWeightedAmount(offset, amount, slabConfig){
        const { tier1Cap, tier1Rate, tier2Cap, tier2Rate, tier3Rate } = slabConfig;

        const tier1End = tier1Cap;
        const tier2End = tier1Cap + tier2Cap;
        let pos = offset;
        let remaining = amount;
        let weighted = 0;

        const consume = (boundary, rate) => {
            if (remaining <= 0) return;
            const capacity = boundary - pos;
            if (capacity <= 0) return;
            const take = Math.min(capacity, remaining);
            weighted += take * rate;
            pos += take;
            remaining -= take;
        };

        consume(tier1End, tier1Rate);
        consume(tier2End, tier2Rate);
        if (remaining > 0){
            weighted += remaining * tier3Rate;
            remaining = 0;
        }

        const blendedRate = amount > 0 ? weighted / amount : 0;
        return { weighted, blendedRate };
    }

    /**
     * CalculateSubscriptionInterest
     * (UPDATED: চাঁদা বা কিস্তির টাকা চলতি বছরের স্ল্যাব রেট পরিবর্তন করবে না।
     * শুধুমাত্র লোন নেওয়ার কারণে ব্যালেন্স কমলে স্ল্যাব রেট আপডেট হবে)
     */
    function CalculateSubscriptionInterest(input){
        const { monthlyContribution, monthlyRecovery, openingBalance, slabConfig, loans, fiscalYearStart } = input;
        const rows = [];
        let totalContribution = 0, totalRecovery = 0, totalInterest = 0;

        // শুধুমাত্র লোন বাদ দিয়ে বেস ব্যালেন্স ট্র্যাক করার জন্য
        let runningBaseBalance = openingBalance;

        for (let i = 0; i < 12; i++){
            // চেক করা হচ্ছে এই মাসে কোনো লোন নেওয়া হয়েছে কিনা
            let loanDeductionThisMonth = 0;
            loans.forEach(loan => {
                const calMonth = loan.monthIndex < 6 ? loan.monthIndex + 6 : loan.monthIndex - 6;
                if ((loan.year * 12 + calMonth) === (fiscalYearStart * 12 + 6 + i)) {
                    loanDeductionThisMonth += loan.amount;
                }
            });

            // লোন নিলে রানিং বেস ব্যালেন্স থেকে কাটা যাবে (কিন্তু নতুন জমা যোগ হবে না)
            runningBaseBalance -= loanDeductionThisMonth;
            const balanceForRate = runningBaseBalance > 0 ? runningBaseBalance : 0;

            const contribution = monthlyContribution[i] || 0;
            const recovery = monthlyRecovery[i] || 0;
            const eligible = contribution + recovery;
            const months = interestMonthsFor(i);

            // নতুন রানিং বেস ব্যালেন্সের ওপর ভিত্তি করে চাঁদার সুদের হার (Slab Rate) বের করা হচ্ছে
            const { weighted, blendedRate } = rateWeightedAmount(balanceForRate, eligible, slabConfig);
            const interest = (weighted/100) * (months/12);

            rows.push({
                month: MONTHS_BN[i],
                monthIndex: i,
                contribution: round2(contribution),
                recovery: round2(recovery),
                eligible: round2(eligible),
                rate: round2(blendedRate),
                interestMonths: months,
                interest: round2(interest)
            });

            totalContribution += contribution;
            totalRecovery += recovery;
            totalInterest += interest;
        }

        return {
            rows,
            totalContribution: round2(totalContribution),
            totalRecovery: round2(totalRecovery),
            totalInterest: round2(totalInterest)
        };
    }

    /**
     * CalculateRefundableLoanInterest
     */
    function CalculateRefundableLoanInterest(loans, refundableRatePercent, fiscalYearStart, startNextMonth){
        const rows = [];
        let totalRefundable = 0, totalNonRefundable = 0, totalLoanInterest = 0;

        const currentFyStartAcm = fiscalYearStart * 12 + 6;
        const currentFyEndAcm = (fiscalYearStart + 1) * 12 + 5;

        loans.forEach(loan => {
            const isRefundable = loan.type === 'refundable';
            let interest = 0;
            let eligibleStr = 'No';

            const calMonth = loan.monthIndex < 6 ? loan.monthIndex + 6 : loan.monthIndex - 6;
            const loanTakenAcm = loan.year * 12 + calMonth;

            if (isRefundable){
                totalRefundable += loan.amount;

                // NEW LOGIC: startNextMonth অনুযায়ী কিস্তি শুরুর মাস নির্ধারণ
                const recoveryStartAcm = startNextMonth ? loanTakenAcm + 1 : loanTakenAcm;
                const recoveryEndAcm = recoveryStartAcm + loan.installments - 1;

                if (recoveryEndAcm >= currentFyStartAcm && recoveryEndAcm <= currentFyEndAcm) {
                    interest = loan.amount * (refundableRatePercent / 100);
                    eligibleStr = 'Yes (Completed)';
                } else if (recoveryEndAcm < currentFyStartAcm) {
                    eligibleStr = 'Completed Past FY';
                } else {
                    eligibleStr = 'Pending Future FY';
                }
            } else {
                if (loanTakenAcm >= currentFyStartAcm && loanTakenAcm <= currentFyEndAcm) {
                    totalNonRefundable += loan.amount;
                    eligibleStr = 'Deducted';
                } else {
                    eligibleStr = 'Other FY (Skipped)';
                }
            }

            totalLoanInterest += interest;

            rows.push({
                month: MONTHS_BN[loan.monthIndex] + ` (${loan.year})`,
                type: isRefundable ? 'Refundable' : 'Non Refundable',
                amount: round2(loan.amount),
                interest: round2(interest),
                eligible: eligibleStr
            });
        });

        return {
            rows,
            totalRefundable: round2(totalRefundable),
            totalNonRefundable: round2(totalNonRefundable),
            totalLoanInterest: round2(totalLoanInterest)
        };
    }

    /**
     * CalculateWithdrawalAdjustment
     */
    function CalculateWithdrawalAdjustment(loanResult){
        return round2(loanResult.totalNonRefundable);
    }

    function CalculateOneMonthSlabInterest(balance, slabConfig) {
        if (balance <= 0) return { interest: 0, breakdown: [], blendedRate: 0 };
        const { tier1Cap, tier1Rate, tier2Cap, tier2Rate, tier3Rate } = slabConfig;

        let remaining = balance;
        const t1 = Math.min(remaining, tier1Cap); remaining -= t1;
        const t2 = Math.min(remaining, tier2Cap); remaining -= t2;
        const t3 = Math.max(remaining, 0);

        const totalInterest = (t1 * (tier1Rate/100) / 12) + (t2 * (tier2Rate/100) / 12) + (t3 * (tier3Rate/100) / 12);
        const blendedRate = (totalInterest * 12 / balance) * 100;

        return { interest: round2(totalInterest), blendedRate: round2(blendedRate) };
    }

    function CalculateOpeningBalanceRunningTrack(input) {
        const { openingBalance, loans, fiscalYearStart, slabConfig } = input;
        const rows = [];
        let currentOpeningBalance = openingBalance;
        let totalOpeningInterest = 0, totalLoansTaken = 0;

        for (let i = 0; i < 12; i++) {
            let loanDeductionThisMonth = 0;
            loans.forEach(loan => {
                const calMonth = loan.monthIndex < 6 ? loan.monthIndex + 6 : loan.monthIndex - 6;
                if ((loan.year * 12 + calMonth) === (fiscalYearStart * 12 + 6 + i)) {
                    loanDeductionThisMonth += loan.amount;
                }
            });

            const startBalance = currentOpeningBalance;
            currentOpeningBalance -= loanDeductionThisMonth;
            const balanceForInterest = currentOpeningBalance > 0 ? currentOpeningBalance : 0;

            const slabRes = CalculateOneMonthSlabInterest(balanceForInterest, slabConfig);

            rows.push({
                month: MONTHS_BN[i],
                startBalance,
                loanDeduction: loanDeductionThisMonth,
                interestBase: balanceForInterest,
                rate: slabRes.blendedRate,
                interest: slabRes.interest,
                endBalance: currentOpeningBalance
            });

            totalOpeningInterest += slabRes.interest;
            totalLoansTaken += loanDeductionThisMonth;
        }

        return { rows, totalOpeningInterest: round2(totalOpeningInterest), totalLoansTaken };
    }

    function CalculateClosingBalance(parts){
        const {
            openingBalance, openingInterest,
            totalContribution, contributionInterest,
            refundableLoanInterest, totalLoanRecovery,
            totalLoansTaken
        } = parts;

        const closing = openingBalance + openingInterest
            + totalContribution + contributionInterest
            + refundableLoanInterest + totalLoanRecovery
            - totalLoansTaken;

        return round2(closing);
    }

    function CalculateAutoRecovery(loans, fiscalYearStart, startNextMonth) {
        const monthlyRecovery = new Array(12).fill(0);
        const currentFyStartAcm = fiscalYearStart * 12 + 6;

        loans.forEach(loan => {
            if (loan.type !== 'refundable' || !loan.installments || loan.installments <= 0 || !loan.amount || loan.amount <= 0) return;

            const calMonth = loan.monthIndex < 6 ? loan.monthIndex + 6 : loan.monthIndex - 6;
            const loanTakenAcm = loan.year * 12 + calMonth;

            // NEW LOGIC: startNextMonth অনুযায়ী কিস্তি শুরুর মাস নির্ধারণ
            const recoveryStartAcm = startNextMonth ? loanTakenAcm + 1 : loanTakenAcm;
            const recoveryEndAcm = recoveryStartAcm + loan.installments - 1;
            const monthlyInstallmentAmount = loan.amount / loan.installments;

            for (let i = 0; i < 12; i++) {
                const currentAcm = currentFyStartAcm + i;
                if (currentAcm >= recoveryStartAcm && currentAcm <= recoveryEndAcm) {
                    monthlyRecovery[i] += monthlyInstallmentAmount;
                }
            }
        });

        return monthlyRecovery;
    }

    function Run(input){
        const openingResult = CalculateOpeningInterest(input.openingBalance, input.slabConfig);

        const subResult = CalculateSubscriptionInterest(input);

        // NEW LOGIC: input.startNextMonth পাস করা হচ্ছে
        const loanResult = CalculateRefundableLoanInterest(input.loans, 5, input.fiscalYearStart, input.startNextMonth);

        const withdrawal = CalculateWithdrawalAdjustment(loanResult);

        const opBalTrackResult = CalculateOpeningBalanceRunningTrack(input);

        const closing = CalculateClosingBalance({
            openingBalance: input.openingBalance,
            openingInterest: opBalTrackResult.totalOpeningInterest,
            totalContribution: subResult.totalContribution,
            contributionInterest: subResult.totalInterest,
            refundableLoanInterest: loanResult.totalLoanInterest,
            totalLoanRecovery: subResult.totalRecovery,
            totalLoansTaken: opBalTrackResult.totalLoansTaken
        });

        return {
            openingBalance: round2(input.openingBalance),
            openingResult,
            subResult,
            loanResult,
            withdrawal,
            opBalTrackResult,
            closing
        };
    }

    function CalculateMarginalRate(balance, slabConfig){
        const { tier1Cap, tier2Cap, tier1Rate, tier2Rate, tier3Rate } = slabConfig;
        if (balance < tier1Cap) return tier1Rate;
        if (balance < tier1Cap + tier2Cap) return tier2Rate;
        return tier3Rate;
    }

    return {
        CalculateOpeningInterest,
        CalculateSubscriptionInterest,
        CalculateRefundableLoanInterest,
        CalculateWithdrawalAdjustment,
        CalculateClosingBalance,
        CalculateMarginalRate,
        CalculateAutoRecovery,
        CalculateOneMonthSlabInterest,
        CalculateOpeningBalanceRunningTrack,
        Run
    };
})();

/* =========================================================================
   UI CONTROLLER — collects input, calls the service, renders output.
   ========================================================================= */

function fmt(n){
    return new Intl.NumberFormat('en-BD', { minimumFractionDigits:2, maximumFractionDigits:2 }).format(n);
}

document.addEventListener('DOMContentLoaded', () => {

    const diffContribFields = document.getElementById('diffContribFields');
    const sameContribField = document.getElementById('sameContribField');
    const slabInputs = document.getElementById('slabInputs');
    const fiscalYearSelect = document.getElementById('fiscalYear');

    (function buildFiscalYearOptions(){
        const today = new Date();
        const currentFYStart = today.getMonth() >= 6 ? today.getFullYear() : today.getFullYear() - 1;

        const startRange = currentFYStart - 5;
        const endRange = currentFYStart + 2;

        for (let y = endRange; y >= startRange; y--){
            const label = `${y}-${y + 1}`;
            const opt = document.createElement('option');
            opt.value = label;
            opt.textContent = label;
            if (y === currentFYStart) opt.selected = true;
            fiscalYearSelect.appendChild(opt);
        }
    })();

    MONTHS_BN.forEach((m, i) => {
        const wrap = document.createElement('div');
        wrap.className = 'field';
        wrap.innerHTML = `
      <label>${m}</label>
      <input type="number" class="diffContribInput" data-index="${i}" value="0">
    `;
        diffContribFields.appendChild(wrap);
    });

    const recoveryManualView = document.getElementById('recoveryManualView');
    MONTHS_BN.forEach((m, i) => {
        const wrap = document.createElement('div');
        wrap.className = 'field';
        wrap.innerHTML = `
      <label>${m}</label>
      <input type="number" class="manualRecoveryInput" data-index="${i}" value="0">
    `;
        recoveryManualView.appendChild(wrap);
    });

    document.querySelectorAll('input[name="contribMode"]').forEach(radio => {
        radio.addEventListener('change', (e) => {
            if (e.target.value === 'same'){
                sameContribField.classList.remove('hidden');
                diffContribFields.classList.add('hidden');
            } else {
                sameContribField.classList.add('hidden');
                diffContribFields.classList.remove('hidden');
            }
        });
    });

    const recoveryAutoView = document.getElementById('recoveryAutoView');

    // NEW LOGIC: রেডিও বাটনগুলোর view টগল ঠিক করা হয়েছে
    document.querySelectorAll('input[name="recoveryMode"]').forEach(radio => {
        radio.addEventListener('change', (e) => {
            if (e.target.value === 'auto_next' || e.target.value === 'auto_same'){
                recoveryAutoView.classList.remove('hidden');
                recoveryManualView.classList.add('hidden');
            } else {
                recoveryAutoView.classList.add('hidden');
                recoveryManualView.classList.remove('hidden');
            }
        });
    });

    const loanTableBody = document.getElementById('loanTableBody');

    function monthOptions(){
        return MONTHS_BN.map((m,i) => `<option value="${i}">${m}</option>`).join('');
    }

    function buildYearOptions(selectedYear = '') {
        const currentYear = new Date().getFullYear();
        let html = '<option value="">সাল নির্বাচন করুন</option>';

        for (let y = currentYear + 2; y >= currentYear - 10; y--) {
            html += `<option value="${y}" ${selectedYear == y ? 'selected' : ''}>${y}</option>`;
        }

        return html;
    }

    function addLoanRow(year = '', monthIndex = 0, type = 'refundable', amount = '', installments = ''){
        const tr = document.createElement('tr');
        tr.innerHTML = `
      <td>
  <select class="loan-year">
    ${buildYearOptions(year)}
  </select>
</td>
      <td><select class="loan-month">${monthOptions()}</select></td>
      <td>
        <select class="loan-type">
          <option value="refundable">Refundable</option>
          <option value="nonrefundable">Non Refundable</option>
        </select>
      </td>
      <td><input type="number" class="loan-amount" placeholder="0" value="${amount}"></td>
      <td><input type="number" class="loan-installments" placeholder="কিস্তি (যেমন: ৫০)" value="${installments}"></td>
      <td><button type="button" class="row-remove" title="মুছুন">✕</button></td>
    `;
        tr.querySelector('.loan-month').value = monthIndex;
        tr.querySelector('.loan-type').value = type;
        tr.querySelector('.row-remove').addEventListener('click', () => tr.remove());
        loanTableBody.appendChild(tr);
    }

    document.getElementById('addLoanBtn').addEventListener('click', () => addLoanRow());

    function readSlabConfig(){
        return {
            tier1Cap: parseFloat(document.getElementById('tier1Cap').value) || 0,
            tier1Rate: parseFloat(document.getElementById('tier1Rate').value) || 0,
            tier2Cap: parseFloat(document.getElementById('tier2Cap').value) || 0,
            tier2Rate: parseFloat(document.getElementById('tier2Rate').value) || 0,
            tier3Rate: parseFloat(document.getElementById('tier3Rate').value) || 0
        };
    }

    const openingRateDisplay = document.getElementById('openingRateDisplay');
    const contribRateDisplay = document.getElementById('contribRateDisplay');
    const slabBreakdown = document.getElementById('slabBreakdown');

    function updateLiveRates(){
        const balance = parseFloat(document.getElementById('openingBalance').value) || 0;
        const slabConfig = readSlabConfig();

        if (balance <= 0){
            openingRateDisplay.textContent = 'প্রযোজ্য সুদের হার: —';
            contribRateDisplay.textContent = 'বর্তমান প্রযোজ্য হার (Running Balance অনুযায়ী): —';
            slabBreakdown.innerHTML = '';
            return;
        }

        const marginalRate = GPFCalculatorService.CalculateMarginalRate(balance, slabConfig);
        const openingResult = GPFCalculatorService.CalculateOpeningInterest(balance, slabConfig);
        const blendedRate = balance > 0 ? round2ForUi((openingResult.interest / balance) * 100) : 0;

        openingRateDisplay.textContent = (openingResult.breakdown.length > 1)
            ? `প্রযোজ্য সুদের হার: ${marginalRate}% (এই ধাপের হার) — সম্পূর্ণ Balance-এর গড় (Blended) হার ${blendedRate}%, কারণ একাংশ আগের ধাপেও পড়ে`
            : `প্রযোজ্য সুদের হার: ${marginalRate}%`;

        contribRateDisplay.textContent = `বর্তমান প্রযোজ্য হার (Running Balance অনুযায়ী): ${marginalRate}%`;

        renderSlabBreakdown(openingResult);
    }

    function renderSlabBreakdown(openingResult){
        if (!openingResult.breakdown.length){
            slabBreakdown.innerHTML = '';
            return;
        }
        const slots = openingResult.breakdown.map(b => `
      <div class="slab-slot">
        <div class="slot-label">${b.label}</div>
        <div class="slot-amount">${fmt(b.amount)} টাকার উপর</div>
        <div class="slot-interest">সুদ: ${fmt(b.interest)}</div>
      </div>
    `).join('');
        const total = `
      <div class="slab-slot slot-total">
        <div class="slot-label">মোট Opening Interest</div>
        <div class="slot-amount">&nbsp;</div>
        <div class="slot-interest">${fmt(openingResult.interest)}</div>
      </div>
    `;
        slabBreakdown.innerHTML = slots + total;
    }

    function round2ForUi(n){ return Math.round((n + Number.EPSILON) * 100) / 100; }

    ['openingBalance','tier1Cap','tier1Rate','tier2Cap','tier2Rate','tier3Rate']
        .forEach(id => document.getElementById(id).addEventListener('input', updateLiveRates));

    updateLiveRates();

    function gatherInput(){
        const openingBalance = parseFloat(document.getElementById('openingBalance').value) || 0;

        const fyString = document.getElementById('fiscalYear').value;
        const fiscalYearStart = parseInt(fyString.split('-')[0], 10);

        const slabConfig = readSlabConfig();

        const contribModeEl = document.querySelector('input[name="contribMode"]:checked');
        const contribMode = contribModeEl ? contribModeEl.value : 'same';

        let monthlyContribution = new Array(12).fill(0);
        if (contribMode === 'same'){
            const amt = parseFloat(document.getElementById('sameContribAmount').value) || 0;
            monthlyContribution = monthlyContribution.map(() => amt);
        } else {
            document.querySelectorAll('.diffContribInput').forEach(inp => {
                const idx = parseInt(inp.dataset.index, 10);
                monthlyContribution[idx] = parseFloat(inp.value) || 0;
            });
        }

        const loans = [];
        document.getElementById('loanTableBody').querySelectorAll('tr').forEach(tr => {
            let year = parseInt(tr.querySelector('.loan-year').value, 10);
            const monthIndex = parseInt(tr.querySelector('.loan-month').value, 10);

            if (!year) {
                year = monthIndex < 6 ? fiscalYearStart : fiscalYearStart + 1;
                tr.querySelector('.loan-year').value = year;
            }

            const type = tr.querySelector('.loan-type').value === 'refundable' ? 'refundable' : 'nonrefundable';
            const amount = parseFloat(tr.querySelector('.loan-amount').value) || 0;
            const installments = parseInt(tr.querySelector('.loan-installments').value, 10) || 0;

            if (amount > 0) loans.push({ year, monthIndex, type, amount, installments });
        });

        // NEW LOGIC: recoveryMode থেকে startNextMonth বের করা হচ্ছে
        const recoveryModeEl = document.querySelector('input[name="recoveryMode"]:checked');
        const recoveryMode = recoveryModeEl ? recoveryModeEl.value : 'auto_next';
        const startNextMonth = (recoveryMode !== 'auto_same');

        let monthlyRecovery = new Array(12).fill(0);

        if (recoveryMode === 'auto_next' || recoveryMode === 'auto_same') {
            monthlyRecovery = GPFCalculatorService.CalculateAutoRecovery(loans, fiscalYearStart, startNextMonth) || new Array(12).fill(0);
        } else {
            document.querySelectorAll('.manualRecoveryInput').forEach(inp => {
                const idx = parseInt(inp.dataset.index, 10);
                monthlyRecovery[idx] = parseFloat(inp.value) || 0;
            });
        }

        return { openingBalance, slabConfig, monthlyContribution, monthlyRecovery, loans, fiscalYearStart, startNextMonth };
    }

    function renderSummary(result){
        const grid = document.getElementById('summaryGrid');
        const cards = [
            ['Opening Balance', result.openingBalance],
            ['Opening Interest (Tracking)', result.opBalTrackResult.totalOpeningInterest],
            ['মোট চাঁদা (Contribution)', result.subResult.totalContribution],
            ['চাঁদার সুদ', result.subResult.totalInterest],
            ['ঋণ আদায় (Recovery)', result.subResult.totalRecovery],
            ['Refundable Loan সুদ (৫%)', result.loanResult.totalLoanInterest],
            ['Total Loan/Withdrawal (চলতি বছর)', -result.opBalTrackResult.totalLoansTaken],
        ];
        grid.innerHTML = cards.map(([label, value]) => `
      <div class="summary-card">
        <div class="label">${label}</div>
        <div class="value">${fmt(value)}</div>
      </div>
    `).join('') + `
      <div class="summary-card highlight">
        <div class="label">Closing Balance</div>
        <div class="value">${fmt(result.closing)}</div>
      </div>
    `;
    }

    function renderOpeningBalanceTrackTable(result){
        const body = document.getElementById('openingBalanceTrackTableBody');
        if(!body) return;
        body.innerHTML = result.opBalTrackResult.rows.map(r => `
      <tr>
        <td>${r.month}</td>
        <td>${fmt(r.startBalance)}</td>
        <td style="color:var(--bad);">${r.loanDeduction > 0 ? '-' + fmt(r.loanDeduction) : '0'}</td>
        <td style="font-weight:bold; background:#f7f9f7;">${fmt(r.interestBase)}</td>
        <td style="background:#f7f9f7;">${r.rate}%</td>
        <td style="color:var(--good);font-weight:bold; background:#f7f9f7;">${fmt(r.interest)}</td>
        <td>${fmt(r.endBalance)}</td>
      </tr>
    `).join('') + `
      <tr style="font-weight:700;background:#f2efe4;">
        <td colspan="2">সর্বমোট</td>
        <td style="color:var(--bad);">${fmt(result.opBalTrackResult.totalLoansTaken)}</td>
        <td>—</td>
        <td>—</td>
        <td style="color:var(--good);">${fmt(result.opBalTrackResult.totalOpeningInterest)}</td>
        <td>—</td>
      </tr>
    `;
    }

    function renderMonthlyTable(result){
        const body = document.getElementById('monthlyTableBody');
        body.innerHTML = result.subResult.rows.map(r => `
      <tr>
        <td>${r.month}</td>
        <td>${fmt(r.contribution)}</td>
        <td>${fmt(r.recovery)}</td>
        <td>${fmt(r.eligible)}</td>
        <td>${r.rate}%</td>
        <td>${r.interestMonths}</td>
        <td>${fmt(r.interest)}</td>
      </tr>
    `).join('') + `
      <tr style="font-weight:700;background:#f2efe4;">
        <td>মোট</td>
        <td>${fmt(result.subResult.totalContribution)}</td>
        <td>${fmt(result.subResult.totalRecovery)}</td>
        <td>${fmt(result.subResult.totalContribution + result.subResult.totalRecovery)}</td>
        <td>—</td>
        <td>—</td>
        <td>${fmt(result.subResult.totalInterest)}</td>
      </tr>
    `;
    }

    function renderLoanDetailTable(result){
        const body = document.getElementById('loanDetailTableBody');
        if (result.loanResult.rows.length === 0){
            body.innerHTML = `<tr><td colspan="5" style="text-align:center;color:var(--muted);">কোনো ঋণ যোগ করা হয়নি</td></tr>`;
            return;
        }
        body.innerHTML = result.loanResult.rows.map(r => `
      <tr>
        <td>${r.month}</td>
        <td>${r.type}</td>
        <td>${fmt(r.amount)}</td>
        <td>${fmt(r.interest)}</td>
        <td>${r.eligible}</td>
      </tr>
    `).join('');
    }

    function renderClosingTable(result){
        const body = document.getElementById('closingTableBody');

        const val1 = result.openingBalance;
        const val2 = result.subResult.totalContribution;
        const val3 = val1 + val2;
        const val4 = result.opBalTrackResult.totalLoansTaken;
        const val5 = result.subResult.totalRecovery;
        const val6 = 0;
        const val7 = (val3 - val4) + (val5 + val6);

        const val8 = result.opBalTrackResult.totalOpeningInterest + result.subResult.totalInterest + result.loanResult.totalLoanInterest;

        const val9 = val7 + val8;

        const rows = [
            ['১. প্রারম্ভিক স্থিতি (Opening Balance)', val1, false, false],
            ['২. নিজস্ব চাঁদা (Own Contribution)', val2, false, false],
            ['৩. জের (১ + ২)', val3, false, true],
            ['৪. অগ্রিম গ্রহণ/ঋণ (Loan Taken)', val4, true, false],
            ['৫. অগ্রিম আদায় (Loan Recovery)', val5, false, false],
            ['৬. অন্যান্য (ফাঁকা)', val6, false, false],
            ['৭. জের ((৩ - ৪) + (৫ + ৬))', val7, false, true],
            ['৮. ওই বছরের মোট মুনাফা (Yearly Interest)', val8, false, false],
        ];

        body.innerHTML = rows.map(([label, value, isNegative, isBold]) => `
      <tr class="${isNegative && value > 0 ? 'negative' : ''}" style="${isBold ? 'font-weight:bold; background:#eef2ee; color:var(--deep-green);' : ''}">
        <td class="cl-label">${label}</td>
        <td class="cl-value">${fmt(value)}</td>
      </tr>
    `).join('') + `
      <tr class="total" style="font-size:1.15rem;">
        <td class="cl-label">৯. সমাপনী জের (৭ + ৮)</td>
        <td class="cl-value">${fmt(val9)}</td>
      </tr>
    `;
    }

    function calculate(){
        const input = gatherInput();
        const result = GPFCalculatorService.Run(input);

        renderSummary(result);
        if(document.getElementById('openingBalanceTrackTableBody')) {
            renderOpeningBalanceTrackTable(result);
        }
        renderMonthlyTable(result);
        renderLoanDetailTable(result);
        renderClosingTable(result);

        document.getElementById('panel-output').classList.remove('hidden');
        document.getElementById('panel-output').scrollIntoView({ behavior:'smooth', block:'start' });
    }

    document.getElementById('calcBtn').addEventListener('click', calculate);
    document.getElementById('printBtn').addEventListener('click', () => window.print());
    document.getElementById('resetBtn').addEventListener('click', () => {
        if (confirm('সব তথ্য মুছে ফেলতে চান?')) window.location.reload();
    });
});