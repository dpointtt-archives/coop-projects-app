<#macro login>
<form action="/login" method="post">
    <div class="form-outline mb-4">
        <label class="form-label" for="form3Example3cg">Username:</label>
        <input type="text" id="form3Example3cg" name="username"
               class="form-control form-control-lg" placeholder="Username" />
    </div>
    <div class="form-outline mb-4">
        <label class="form-label" for="form3Example4cg">Password:</label>
        <input type="password" id="form3Example4cg" name="password"
               class="form-control form-control-lg" placeholder="Password" />
    </div>
    <#if errorLogin??>
        <h2 class="text-center mb-4 mt-2 error-text">Invalid username or password!</h2>
    </#if>
    <div class="d-flex justify-content-center">
        <button type="submit" value="Sign In"
                class="btn btn-outline-success btn-block btn-lg text-body">Log in</button>
    </div>
    <p class="text-center text-muted mt-5 mb-0">Don't have an account yet? <a href="/signup" class="fw-bold text-body"><u>Register here</u></a></p>
</form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="submit" value="Sign Out"/>
    </form>
</#macro>

<#macro signup>
    <form action="/signup" method="post">
        <div class="form-outline mb-4">
            <label class="form-label" for="usernameValidation">Username:</label>
            <input type="text" class="form-control form-control-lg" name="username"
                   id="usernameValidation" placeholder="Username" onkeyup="checkUsernameInput()" required/>
        </div>
        <div class="form-outline mb-4">
            <label class="form-label" for="passwordValidation">Password:</label>
            <input type="password" id="passwordValidation" name="password"
                   class="form-control form-control-lg" placeholder="Password" onkeyup="checkPasswordInput()" required />
        </div>
        <#if errorSignUp??>
            <h2 class="text-center mb-4 mt-2 error-text">Sorry, but someone with the same username or email is already registered!</h2>
        </#if>
        <div class="d-flex justify-content-center">
            <button id="registerButton" type="submit" value="Sign Up"
                    class="btn btn-outline-success btn-block btn-lg text-body">Register</button>
        </div>
        <p class="text-center text-muted mt-5 mb-0">Have already an account? <a href="/login" class="fw-bold text-body"><u>Login here</u></a></p>
    </form>
</#macro>