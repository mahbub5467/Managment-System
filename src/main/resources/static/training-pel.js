


    document.addEventListener("DOMContentLoaded", function () {


    const trainingType =
    document.getElementById("trainingType");


    const trainingEntryArea =
    document.getElementById("trainingEntryArea");


    const initialSection =
    document.getElementById("initialSection");


    const otherSection =
    document.getElementById("otherSection");


    const trainingActions =
    document.getElementById("trainingActions");


    const otherTypeHeader =
    document.getElementById("otherTypeHeader");


    const otherTrainingTitle =
    document.getElementById("otherTrainingTitle");


    const otherTrainingDescription =
    document.getElementById(
    "otherTrainingDescription"
    );


    const initialCertificateDateGroup =
    document.getElementById(
    "initialCertificateDateGroup"
    );


    const initialCertificateFileGroup =
    document.getElementById(
    "initialCertificateFileGroup"
    );


    const initialCertificateDate =
    document.getElementById(
    "initialCertificateDate"
    );


    const initialCertificate =
    document.getElementById(
    "initialCertificate"
    );


    const otherCertificateDateGroup =
    document.getElementById(
    "otherCertificateDateGroup"
    );


    const otherCertificateFileGroup =
    document.getElementById(
    "otherCertificateFileGroup"
    );


    const otherCertificateDate =
    document.getElementById(
    "otherCertificateDate"
    );


    const otherCertificate =
    document.getElementById(
    "otherCertificate"
    );



    /* =====================================================
       HIDE EVERYTHING INITIALLY
    ====================================================== */

    function hideTrainingArea() {

    if (trainingEntryArea) {

    trainingEntryArea.classList.add(
    "hidden"
    );

}


    if (initialSection) {

    initialSection.classList.add(
    "hidden"
    );

}


    if (otherSection) {

    otherSection.classList.add(
    "hidden"
    );

}


    if (trainingActions) {

    trainingActions.classList.add(
    "hidden"
    );

}

}


    hideTrainingArea();



    /* =====================================================
       TRAINING TYPE CHANGE
    ====================================================== */

    if (trainingType) {

    trainingType.addEventListener(
    "change",
    function () {

    const type =
    this.value;


    hideTrainingArea();


    if (!type) {
    return;
}


    /* Show main training area */

    trainingEntryArea.classList.remove(
    "hidden"
    );


    /* Show buttons */

    trainingActions.classList.remove(
    "hidden"
    );


    /* Initial */

    if (type === "initial") {

    initialSection.classList.remove(
    "hidden"
    );

}


    /* Other types */

    else {

    otherSection.classList.remove(
    "hidden"
    );


    if (type === "recurrent") {

    otherTypeHeader.textContent =
    "Type of Recurrent Training";

    otherTrainingTitle.textContent =
    "Recurrent Training";

    otherTrainingDescription.textContent =
    "Enter recurrent training information.";

}


    else if (type === "specialized") {

    otherTypeHeader.textContent =
    "Type of Specialized Training";

    otherTrainingTitle.textContent =
    "Specialized Training";

    otherTrainingDescription.textContent =
    "Enter specialized training information.";

}


    else if (type === "previous") {

    otherTypeHeader.textContent =
    "Type of Previous Training";

    otherTrainingTitle.textContent =
    "Previous Training";

    otherTrainingDescription.textContent =
    "Enter previous training information.";

}

}

}
    );

}



    /* =====================================================
       INITIAL CERTIFICATION
    ====================================================== */

    document
    .querySelectorAll(
    'input[name="initialCertification"]'
    )
    .forEach(function (radio) {

    radio.addEventListener(
    "change",
    function () {

    if (this.value === "yes") {

    initialCertificateDateGroup
    .classList
    .remove("hidden");


    initialCertificateFileGroup
    .classList
    .remove("hidden");


    initialCertificateDate.disabled =
    false;


    initialCertificate.disabled =
    false;

}

    else {

    initialCertificateDateGroup
    .classList
    .add("hidden");


    initialCertificateFileGroup
    .classList
    .add("hidden");


    initialCertificateDate.disabled =
    true;


    initialCertificate.disabled =
    true;


    initialCertificateDate.value =
    "";


    initialCertificate.value =
    "";

}

}
    );

});



    /* =====================================================
       OTHER CERTIFICATION
    ====================================================== */

    document
    .querySelectorAll(
    'input[name="otherCertification"]'
    )
    .forEach(function (radio) {

    radio.addEventListener(
    "change",
    function () {

    if (this.value === "yes") {

    otherCertificateDateGroup
    .classList
    .remove("hidden");


    otherCertificateFileGroup
    .classList
    .remove("hidden");


    otherCertificateDate.disabled =
    false;


    otherCertificate.disabled =
    false;

}

    else {

    otherCertificateDateGroup
    .classList
    .add("hidden");


    otherCertificateFileGroup
    .classList
    .add("hidden");


    otherCertificateDate.disabled =
    true;


    otherCertificate.disabled =
    true;


    otherCertificateDate.value =
    "";


    otherCertificate.value =
    "";

}

}
    );

});



    /* =====================================================
       FILE VALIDATION
    ====================================================== */

    document
    .querySelectorAll(
    ".certificate-upload"
    )
    .forEach(function (input) {

    input.addEventListener(
    "change",
    function () {

    const file =
    this.files[0];


    if (!file) {
    return;
}


    const allowed =
    [
    ".pdf",
    ".jpg",
    ".jpeg",
    ".png"
    ];


    const fileName =
    file.name.toLowerCase();


    const valid =
    allowed.some(
    function (extension) {

    return fileName.endsWith(
    extension
    );

}
    );


    if (!valid) {

    alert(
    "Only PDF, JPG, JPEG and PNG files are allowed."
    );


    this.value = "";

    return;

}


    if (
    file.size >
    10 * 1024 * 1024
    ) {

    alert(
    "Certificate file size must not exceed 10 MB."
    );


    this.value = "";

}

}
    );

});



    /* =====================================================
       EMPLOYEE SEARCH
    ====================================================== */

    const employeeId =
    document.getElementById(
    "employeeId"
    );


    const employeeName =
    document.getElementById(
    "employeeName"
    );


    const designation =
    document.getElementById(
    "designation"
    );


    const joiningDate =
    document.getElementById(
    "joiningDate"
    );


    const employeeSearchBtn =
    document.getElementById(
    "employeeSearchBtn"
    );


    const employeeSearchStatus =
    document.getElementById(
    "employeeSearchStatus"
    );



    function clearEmployeeFields() {

    employeeName.value = "";

    designation.value = "";

    joiningDate.value = "";

}



    function formatDate(dateValue) {

    if (!dateValue) {
    return "";
}


    if (
    typeof dateValue === "string" &&
    /^\d{4}-\d{2}-\d{2}$/.test(
    dateValue
    )
    ) {

    return dateValue;

}


    const date =
    new Date(dateValue);


    if (
    isNaN(
    date.getTime()
    )
    ) {

    return "";

}


    return (
    date.getFullYear() +
    "-" +
    String(
    date.getMonth() + 1
    ).padStart(2, "0") +
    "-" +
    String(
    date.getDate()
    ).padStart(2, "0")
    );

}



    async function searchEmployee() {

    const id =
    employeeId.value.trim();


    if (!id) {

    clearEmployeeFields();


    employeeSearchStatus.textContent =
    "Please enter Employee ID.";

    employeeSearchStatus.className =
    "employee-search-status error";

    return;

}


    employeeSearchBtn.disabled =
    true;


    employeeSearchBtn.innerHTML =
    '<i class="fa-solid fa-spinner fa-spin"></i>';


    employeeSearchStatus.textContent =
    "Searching employee...";


    employeeSearchStatus.className =
    "employee-search-status loading";


    try {

    const contextPath =
    "${pageContext.request.contextPath}";


    const response =
    await fetch(
    contextPath +
    "/employee/search/" +
    encodeURIComponent(id),
{
    method: "GET",
    headers: {
    "Accept":
    "application/json"
}
}
    );


    if (!response.ok) {

    throw new Error(
    "Employee not found."
    );

}


    const data =
    await response.json();


    employeeName.value =
    data.name ||
    data.employeeName ||
    "";


    designation.value =
    data.designation ||
    data.employeeDesignation ||
    "";


    joiningDate.value =
    formatDate(
    data.joiningDate ||
    data.joinDate
    );


    employeeSearchStatus.textContent =
    "Employee information loaded successfully.";


    employeeSearchStatus.className =
    "employee-search-status success";


}

    catch (error) {

    clearEmployeeFields();


    employeeSearchStatus.textContent =
    error.message ||
    "Employee not found.";


    employeeSearchStatus.className =
    "employee-search-status error";

}

    finally {

    employeeSearchBtn.disabled =
    false;


    employeeSearchBtn.innerHTML =
    '<i class="fa-solid fa-magnifying-glass"></i>';

}

}



    employeeSearchBtn.addEventListener(
    "click",
    searchEmployee
    );


    employeeId.addEventListener(
    "keydown",
    function (event) {

    if (
    event.key === "Enter"
    ) {

    event.preventDefault();

    searchEmployee();

}

}
    );



    /* =====================================================
       FORM SUBMIT VALIDATION
    ====================================================== */

    const trainingForm =
    document.getElementById(
    "trainingForm"
    );


    trainingForm.addEventListener(
    "submit",
    function (event) {

    if (!trainingType.value) {

    event.preventDefault();

    alert(
    "Please select Training Type."
    );

    trainingType.focus();

    return;

}


    if (!trainingForm.checkValidity()) {

    event.preventDefault();

    trainingForm.reportValidity();

    return;

}

}
    );

});

