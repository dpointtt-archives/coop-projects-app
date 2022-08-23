<#macro createProject>
    <div class="modal fade" id="createProjectModal" tabindex="-1" aria-labelledby="createProjectModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createProjectModalLabel">Create new project</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/hub/create-project" method="post">
                <div class="modal-body">
                    <div class="form-outline mb-3">
                        <label class="form-label my-label" for="projectTitle">Project title:</label>
                        <input id="projectTitle" type="text" name="projectName" class="form-control form-control-lg" placeholder="Project title" />
                    </div>
                    <div class="form-outline mb-3">
                        <label class="form-label my-label" for="projectDescription">Description:</label>
                        <input id="projectDescription" type="text" name="projectDescription" class="form-control form-control-lg" placeholder="Project title" />
                    </div>
                    <div class="form-outline mb-3">
                        <label class="form-label my-label" for="projectTerm">Project term:</label>
                        <input id="projectTerm" type="datetime-local" name="projectTerm" class="form-control form-control-lg" placeholder="Project title" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-outline-success">Create</button>
                </div>
            </form>
        </div>
    </div>
</div>
</#macro>

<#macro joinProject>
<div class="modal fade" id="joinProjectModal" tabindex="-1" aria-labelledby="joinProjectModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="joinProjectModalLabel">Join to a project</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="/hub/add-project" method="post">
                <div class="modal-body">
                    <div class="form-outline mb-3">
                        <label class="form-label my-label" for="projectCode">Project code:</label>
                        <input id="projectCode" type="text" name="projectCode" class="form-control form-control-lg" placeholder="Code" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-outline-success">Join</button>
                </div>
            </form>
        </div>
    </div>
</div>
</#macro>

<#macro createProjectTask>
    <div class="modal fade" id="createProjectTaskModal" tabindex="-1" aria-labelledby="createProjectTaskModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="createProjectTaskModalLabel">Create new task</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/hub/project/${projectInfo.id}/create-task" method="post">
                    <div class="modal-body">
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectTitle">Task title:</label>
                            <input id="projectTitle" type="text" name="taskName" class="form-control form-control-lg" placeholder="Project title" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectDescription">Description:</label>
                            <input id="projectDescription" type="text" name="taskDescription" class="form-control form-control-lg" placeholder="Project title" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectTerm">Task term:</label>
                            <input id="projectTerm" type="datetime-local" name="taskTerm" class="form-control form-control-lg" placeholder="Project title" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-success">Create</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>

<#macro profile>
    <div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="profileModalLabel">Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/logout" method="post">
                    <div class="modal-body">
                        <p>Username: ${Session.appuser.username}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-success">Log out</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>

<#macro editProjectTask taskToEdit>
    <div class="modal fade" id="editTaskModal${taskToEdit.id}" tabindex="-1" aria-labelledby="editTaskModalLabel${taskToEdit.id}" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editTaskModalLabel${taskToEdit.id}">Edit task</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/hub/project/${projectInfo.id}/task/${taskToEdit.id}/edit" method="post">
                    <div class="modal-body">
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectTitle">Task title:</label>
                            <input id="projectTitle" type="text" name="taskName" class="form-control form-control-lg" placeholder="Task title" value="${taskToEdit.taskName}" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectDescription">Description:</label>
                            <input id="projectDescription" type="text" name="taskDescription" class="form-control form-control-lg" placeholder="Task description" value="${taskToEdit.taskDescription}" />
                        </div>
                        <div class="form-outline mb-3">
                            <label class="form-label my-label" for="projectTerm">Task term:</label>
                            <input id="taskTermString" type="text" name="taskTermString" value="${taskToEdit.taskTerm?string.xs_ms_nz}" hidden />
                            <input id="taskTerm" type="datetime-local" name="taskTerm" class="form-control form-control-lg" placeholder="Task term" value="${taskToEdit.taskTerm?string.xs_ms_nz}" />
                        </div>
                        <div class="form-outline mb-3">
                            <div class="input-group mb-3">
                                <label class="input-group-text" for="inputGroupSelect01">User</label>
                                <select class="form-select" id="inputGroupSelect01" name="username">
                                    <#list projectUsers as projectUser>
                                    <option value="${projectUser.appUser.username}">${projectUser.appUser.username}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-success">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>

<#macro openProjectTask taskToMark>
    <div class="modal fade" id="openTaskModal${taskToMark.id}" tabindex="-1" aria-labelledby="openTaskModalLabel${taskToMark.id}" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="openTaskModalLabel${taskToMark.id}">${taskToMark.taskName}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                    <div class="modal-body">
                        <p>Description:</p>
                        <p>${taskToMark.taskDescription}</p>
                    </div>
                    <div class="modal-footer">
                        <#if .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_LEADER">
                            <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/delete" method="post">
                                <button type="submit" class="btn btn-outline-danger">Remove task</button>
                            </form>
                            <#if taskToMark.done>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="true" hidden />
                                    <button type="submit" class="btn btn-outline-success">Unmark task</button>
                                </form>
                            <#else>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="false" hidden />
                                    <button type="submit" class="btn btn-outline-success">Mark done</button>
                                </form>
                            </#if>
                        <#elseif .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_EMPLOYEE" && taskToMark.appUser?has_content && taskToMark.appUser.id == Session.appuser.id>
                            <#if taskToMark.done>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="true" hidden />
                                    <button type="submit" class="btn btn-outline-success">Unmark task</button>
                                </form>
                            <#else>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="false" hidden />
                                    <button type="submit" class="btn btn-outline-success">Mark done</button>
                                </form>
                            </#if>
                        <#else>
                            <#if taskToMark.done>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="true" hidden />
                                    <button type="submit" class="btn btn-outline-success disabled">Unmark task</button>
                                </form>
                            <#else>
                                <form action="/hub/project/${projectInfo.id}/task/${taskToMark.id}/mark" method="post">
                                    <input type="hidden" name="doneParam" value="false" hidden />
                                    <button type="submit" class="btn btn-outline-success disabled">Mark done</button>
                                </form>
                            </#if>
                        </#if>
                    </div>
            </div>
        </div>
    </div>
</#macro>

<#macro removeUser>
    <div class="modal fade" id="removeUserModal" tabindex="-1" aria-labelledby="removeUserModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="removeUserModalLabel">Remove user</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/hub/project/${projectInfo.id}/remove-user" method="post">
                    <div class="modal-body">
                        <p>Select user you want to remove and click 'Remove' button.(Notice that after removing user from project, your invite code will be regenerated.)</p>
                        <div class="form-outline mb-3">
                            <div class="input-group mb-3">
                                <label class="input-group-text" for="inputGroupSelect01">User</label>
                                <select class="form-select" id="inputGroupSelect01" name="username">
                                    <#list projectUsers as projectUser>
                                        <#if Session.appuser?? && Session.appuser.id != projectUser.appUser.id>
                                            <option value="${projectUser.appUser.username}">${projectUser.appUser.username}</option>
                                        </#if>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-danger">Remove</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>

<#macro deleteProject>
    <div class="modal fade" id="deleteProjectModal" tabindex="-1" aria-labelledby="deleteProjectModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteProjectModalLabel">Remove user</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="/hub/project/${projectInfo.id}/delete-project" method="post">
                    <div class="modal-body">
                        <p>Notice that after deleting your project, all tasks will be deleted too.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-outline-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</#macro>