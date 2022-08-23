const usernameInput = document.querySelector("#usernameValidation");
const passwordInput = document.querySelector("#passwordValidation")
const registerButton = document.querySelector("#registerButton")

function checkUsernameInput(){
    let username = document.getElementById("usernameValidation").value;

    if (username.length < 3 || username.length > 20){
        usernameInput.classList.remove("is-valid");
        usernameInput.classList.add("is-invalid");
    } else{
        usernameInput.classList.remove("is-invalid");
        usernameInput.classList.add("is-valid");
    }
}

function checkPasswordInput(){
    let pass = document.getElementById("passwordValidation").value;

    if (pass.length < 6 || pass.length > 20){
        passwordInput.classList.remove("is-valid");
        passwordInput.classList.add("is-invalid");
    }else {
        passwordInput.classList.remove("is-invalid");
        passwordInput.classList.add("is-valid");
    }
}

setInterval(function (){
    if (usernameInput.classList.contains("is-invalid") ||
        passwordInput.classList.contains("is-invalid")){
        registerButton.classList.add("disabled");
    }else {
        registerButton.classList.remove("disabled");
    }
}, 500)