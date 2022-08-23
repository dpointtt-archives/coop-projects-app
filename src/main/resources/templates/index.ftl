<#import "/spring.ftl" as spring/>
<#import "fragments/common.ftl" as c>
<#import "fragments/login.ftl" as l>
<@c.page>

    <#include "fragments/navbar-template.ftl">

    <div class="container text-center mt-1">
        <img src="/img/logoPC.png" alt="">
        <h1 class="my-text-h1 mt-5">CoopProjects</h1>
        <h2 class="my-text-h2">CoopProjects is a new way to navigate your projects</h2>
    </div><br/><br/><br/><br/>

    <div class="container justify-content-center align-content-center text-center mt-5 mb-5">
        <div class="row row-cols-3">
          <div class="col">
            <img src="/img/projectAddLogo256x256.png" alt="">
            <h2 class="my-text-h2">Create new projects</h2>
          </div>
          <div class="col">
            <img src="/img/addIcon256x256.png" alt="">
            <h2 class="my-text-h2">Add users to your projects</h2>
          </div>
          <div class="col">
            <img src="/img/giveTaskIcon256x256.png" alt="">
            <h2 class="my-text-h2">Give tasks to users</h2>
          </div>
        </div>
      </div><br/><br/>

      <div class="container text-center mt-5 mb-5">
        <h2 class="my-text-h2">Pretty simple right?</h2>
        <h2 class="my-text-h2">Join us for a new experience of team working</h2>
      </div>

      <div class="container justify-content-center align-content-center text-center mt-5">
        <h1 class="my-text-h1">Let's start working together!</h1>
        <br>
        <a href="/signup" class="btn btn-outline-success btn-lg">Join now</a>
      </div><br/><br/><br/><br/>

      <div class="lowermark mt-5 text-center justify-content-center align-content-center pb-5">
        <h1 class="pt-5" style="color: white; font-size: small;">CoopProjects© 2022</h1>
      </div>
</@c.page>