<#import "/spring.ftl" as spring/>
<#import "fragments/common.ftl" as c>
<#import "fragments/login.ftl" as l>
<#import "fragments/modal.ftl" as m>
<#assign nowDate = .now?datetime>
<@c.page>
    <#include "fragments/navbar-template.ftl">

    <br><br><br><br>

    <@m.createProject>
    </@m.createProject>
    <@m.joinProject>
    </@m.joinProject>

    <div class="container text-center mb-5">
        <h1 class="my-text-h1">Project List</h1>
    </div>

    <#if lead_projects?has_content || employee_projects?has_content>
        <div class="container-sm ms-0">
            <div class="row row-cols-6">
                <#list lead_projects as leadUserProjects>
                    <div class="col offset-md-1">
                        <div class="card border-danger" style="width: 18rem; border-color: #7F5283 !important; background-color: #3D3C42 !important;">
                            <span class="badge" style="background-color: #EB4747">LEADER</span>
                            <div class="card-body">
                                <h5 class="card-title">${leadUserProjects.projectName}</h5>
                                <p class="card-text">${leadUserProjects.projectDescription}</p>
                                <p class="card-text">Term: ${leadUserProjects.projectTerm?string.short}
                                    <#if (((leadUserProjects.projectTerm?datetime?long - nowDate?long) / (1000 * 60 * 60 * 24))?int <= 1)>
                                        <span class="badge" style="background-color: #EB4747">Soon</span>
                                    </#if>
                                </p>
                                <a href="/hub/project/${leadUserProjects.id}" class="btn btn-outline-primary">Open</a>
                            </div>
                        </div>
                    </div>
                </#list>
                <#list employee_projects as emploUserProjects>
                    <div class="col offset-md-1">
                        <div class="card border-danger" style="width: 18rem; border-color: #7F5283 !important; background-color: #3D3C42 !important;">
                            <span class="badge" style="background-color: #7F5283">EMPLOYEE</span>
                            <div class="card-body">
                                <h5 class="card-title">${emploUserProjects.projectName}</h5>
                                <p class="card-text">${emploUserProjects.projectDescription}</p>
                                <p class="card-text">Term: ${emploUserProjects.projectTerm?string.short}
                                    <#if (((emploUserProjects.projectTerm?datetime?long - nowDate?long) / (1000 * 60 * 60 * 24))?int <= 1)>
                                        <span class="badge bg-danger">Soon</span>
                                    </#if>
                                </p>
                                <a href="/hub/project/${emploUserProjects.id}" class="btn btn-outline-primary">Open</a>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
    <#else>
        <h2 class="container text-center my-text-h2">Seems like you doesn't have any project yet.</h2>
    </#if>

</@c.page>