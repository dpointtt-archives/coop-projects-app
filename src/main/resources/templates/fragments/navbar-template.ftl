<nav class="navbar fixed-top navbar-expand-lg navbar-custom">
  <div class="container-fluid">
    <#if Session.appuser??>
      <a class="navbar-brand" href="/hub">CoopProjects</a>
    <#else>
      <a class="navbar-brand" href="/">CoopProjects</a>
    </#if>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <#if Session.appuser??>
          <#if springMacroRequestContext.requestUri?contains("/hub") && !springMacroRequestContext.requestUri?contains("/project")>
          <li class="nav-item ms-3">
            <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#createProjectModal">New Project</button>
          </li>
              <li class="nav-item ms-3">
                  <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#joinProjectModal">Add Project</button>
              </li>
          </#if>
            <#if springMacroRequestContext.requestUri?contains("/project") && .vars['appuser-properties']?? && .vars['appuser-properties'].appUserRole.roleName == "ROLE_LEADER">
                <li class="nav-item ms-3">
                    <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#createProjectTaskModal">New Task</button>
                </li>
                <li class="nav-item ms-3">
                    <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#removeUserModal">Remove User</button>
                </li>
                <li class="nav-item ms-3">
                    <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#deleteProjectModal">Delete Project</button>
                </li>
            </#if>
          <li class="nav-item ms-3">
            <a class="btn btn-primary btn-sm" href="/hub">Hub</a>
          </li>
            <li class="nav-item ms-3">
                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#profileModal">Profile</button>
            </li>
          <#else>
            <li class="nav-item">
              <a class="btn btn-outline-primary btn-sm" href="/login">Log In</a>
            </li>
            <li class="nav-item ms-3">
              <a class="btn btn-primary btn-sm" href="/signup">Sign Up</a>
            </li>
        </#if>
      </ul>
    </div>
  </div>
</nav>