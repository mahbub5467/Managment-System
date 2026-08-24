  function validateSafetyReport() {

    const reporterName =
    document.getElementById("reporterName").value.trim();

    const department =
    document.getElementById("department").value.trim();

    const contact =
    document.getElementById("contact").value.trim();

    const incidentDate =
    document.getElementById("incidentDate").value;

    const location =
    document.getElementById("location").value.trim();

    const incidentType =
    document.getElementById("incidentType").value;

    const description =
    document.getElementById("description").value.trim();

    const declaration =
    document.getElementById("declaration").checked;


    if (!reporterName) {

    alert("Please enter reporter name.");

    document
    .getElementById("reporterName")
    .focus();

    return false;
}


    if (!department) {

    alert("Please enter department or organization.");

    document
    .getElementById("department")
    .focus();

    return false;
}


    if (!contact) {

    alert("Please enter contact information.");

    document
    .getElementById("contact")
    .focus();

    return false;
}


    if (!incidentDate) {

    alert("Please select the incident date.");

    document
    .getElementById("incidentDate")
    .focus();

    return false;
}


    if (!location) {

    alert("Please enter the incident location.");

    document
    .getElementById("location")
    .focus();

    return false;
}


    if (!incidentType) {

    alert("Please select the safety event type.");

    document
    .getElementById("incidentType")
    .focus();

    return false;
}


    if (!description) {

    alert("Please provide the incident or hazard description.");

    document
    .getElementById("description")
    .focus();

    return false;
}


    if (!declaration) {

    alert(
    "Please confirm the declaration before submitting."
    );

    return false;
}


    return true;

}


    // =========================================================
    // AUTO HIDE ALERT
    // =========================================================

    setTimeout(function () {

    document
        .querySelectorAll(".alert")
        .forEach(function (alert) {

            alert.style.transition =
                "opacity .4s ease";

            alert.style.opacity = "0";

            setTimeout(function () {

                alert.remove();

            }, 400);

        });

}, 5000);


