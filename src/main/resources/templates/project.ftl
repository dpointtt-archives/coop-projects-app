<#import "/spring.ftl" as spring/>
<#import "fragments/common.ftl" as c>
<#import "fragments/login.ftl" as l>
<#import "fragments/modal.ftl" as m>
<#assign nowDate = .now?datetime>
<@c.page>
    <#include "fragments/navbar-template.ftl">

    <br><br><br><br>

    <#if .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_LEADER">
        <@m.createProjectTask>
        </@m.createProjectTask>
        <@m.removeUser>
        </@m.removeUser>
        <@m.deleteProject>
        </@m.deleteProject>
    </#if>

    <div class="container text-center mb-5">
        <h1 class="my-text-h1">${projectInfo.projectName}</h1>
        <h2 class="my-text-h2">${projectInfo.projectDescription}</h2>
    </div>

    <#if projectTaskList?has_content>
        <div class="container-sm ms-0 w-50 me-0 float-start">
            <div class="container text-center mb-3">
                <h2 class="my-text-h2">Task list:</h2>
            </div>
            <div class="row row-cols-3 mb-4 mt-4">
                <#list projectTaskList as task>
                    <#if .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_LEADER">
                        <@m.editProjectTask taskToEdit=task>
                        </@m.editProjectTask>
                    </#if>
                    <@m.openProjectTask taskToMark=task>
                    </@m.openProjectTask>
                    <div class="col offset-md-1 mb-3">
                        <div class="card border-danger" style="width: 18rem; border-color: #7F5283 !important; background-color: #3D3C42 !important;">
                            <#if task.appUser??>
                            <#if task.appUser.id == Session.appuser.id>
                                <span class="badge" style="background-color: #66BFBF">Assigned to you</span>
                            <#else>
                                <span class="badge" style="background-color: #7F5283">Assigned to ${task.appUser.username}</span>
                            </#if>
                            </#if>
                            <div class="card-body">
                                <#if !task.done>
                                    <span class="badge" style="background-color: #A6D1E6">IN PROGRESS</span>
                                <#else>
                                    <span class="badge" style="background-color: #59CE8F">DONE</span>
                                </#if>
                                <h5 class="card-title">${task.taskName}</h5>
                                <p class="card-text">Term: ${task.taskTerm?string.short}
                                    <#if (((task.taskTerm?datetime?long - nowDate?long) / (1000 * 60 * 60 * 24))?int <= 1)>
                                        <span class="badge" style="background-color: #EB4747">Soon</span>
                                    </#if>
                                </p>
                                <#if .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_LEADER">
                                    <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editTaskModal${task.id}">Edit</button>
                                </#if>
                                <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#openTaskModal${task.id}">Open</button>
                            </div>
                        </div>
                    </div>
                </#list>
            </div>
        </div>
        <div class="container w-50 float-end top-0">
            <div class="container text-center mb-3">
                <h2 class="my-text-h2">User list:</h2>
            </div>
            <div class="card border-danger" style="border-color: #7F5283 !important; background-color: #3D3C42 !important;">
                <div class="card-body">
                    <h5 class="card-title text-center">Project users</h5>
                    <#list projectUsers as pUser>
                        <#if pUser.appUserRole.roleName == "ROLE_LEADER">
                            <p class="card-text">Username: ${pUser.appUser.username}&nbsp;<span class="badge" style="background-color: #EB4747">LEADER</span></p>
                        <#else>
                            <p class="card-text">Username: ${pUser.appUser.username}</p>
                        </#if>
                        <#if pUser.appUser.projectTaskList?has_content>
                            <p class="card-text">${pUser.appUser.username} tasks:</p>
                            <#list pUser.appUser.projectTaskList as pUserTask>
                                <#if pUserTask.project.id == projectInfo.id>
                                <p class="card-text">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${pUserTask.taskName}&nbsp;
                                <#if pUserTask.done>
                                    <span class="badge" style="background-color: #59CE8F">DONE</span>
                                <#else>
                                    <span class="badge" style="background-color: #A6D1E6">IN PROGRESS</span>
                                </#if>
                                </p>
                                </#if>
                            </#list>
                        </#if>
                        <br>
                        <br>
                    </#list>
                </div>
            </div>
        </div>
    <#else>
        <h2 class="container text-center my-text-h2">Seems like project doesn't have any task.</h2>
    </#if>
</@c.page>