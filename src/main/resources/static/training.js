function updateDates() {
    const now = new Date();

    const options = {
        timeZone: 'Asia/Dhaka',
        day: '2-digit',
        month: 'short',
        year: 'numeric'
    };

    const currentDate = now
        .toLocaleDateString('en-GB', options)
        .replace(/ /g, '-');

    document.getElementById('dayOpenedDate').textContent = currentDate;
    document.getElementById('serverDate').textContent = currentDate;
}

updateDates();