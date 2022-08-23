<#import "fragments/common.ftl" as c>
<#import "fragments/login.ftl" as l>
<@c.page>
<section class="vh-100" style="background-color: #A6D1E6;">
    <div class="mask d-flex align-items-center h-100">
        <div class="container h-100">
            <div class="row d-flex justify-content-center align-items-center h-100">
                <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                    <div class="card" style="border-radius: 15px; background-color: #FEFBF6;">
                        <div class="card-body p-5">
                            <h2 class="my-text-h2 text-uppercase text-center mb-5">Log in</h2>
                            <@l.login></@l.login>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</@c.page>