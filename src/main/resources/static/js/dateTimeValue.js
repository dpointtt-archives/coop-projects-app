var dateControl = document.getElementById("taskTerm");
var dateString = document.getElementById("taskTermString").value;

console.log(dateString)

dateString.toString();

dateString.replace(" ", "T");
dateString.replace(":00.000", "")

dateControl.value = dateString;

console.log(dateString)
console.log(dateControl.value)