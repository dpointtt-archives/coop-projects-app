package ua.xenjes.coopproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ua.xenjes.coopproject.bl.DateTimeParser;
import ua.xenjes.coopproject.bl.ProjectCodeGenerator;
import ua.xenjes.coopproject.entity.AppUser;
import ua.xenjes.coopproject.entity.AppUserHasProject;
import ua.xenjes.coopproject.entity.Project;
import ua.xenjes.coopproject.entity.ProjectTask;
import ua.xenjes.coopproject.repository.*;

import java.text.ParseException;
import java.util.List;
@Service
public class ProjectService {

    private final ProjectRepository projectRepository;
    private final ProjectTaskRepository projectTaskRepository;
    private final AppUserRoleRepository appUserRoleRepository;
    private final AppUserHasProjectRepository appUserHasProjectRepository;
    private final AppUserRepository appUserRepository;

    @Autowired
    public ProjectService(ProjectRepository projectRepository,
                          ProjectTaskRepository projectTaskRepository,
                          AppUserRoleRepository appUserRoleRepository,
                          AppUserHasProjectRepository appUserHasProjectRepository,
                          AppUserRepository appUserRepository){
        this.projectRepository = projectRepository;
        this.projectTaskRepository = projectTaskRepository;
        this.appUserRoleRepository = appUserRoleRepository;
        this.appUserHasProjectRepository = appUserHasProjectRepository;
        this.appUserRepository = appUserRepository;
    }

    @Transactional
    public void createProject(AppUser appUser, String projectName, String projectDesc, String projectTerm) throws ParseException {
        String code = ProjectCodeGenerator.generateNewCode();

        projectRepository.save(new Project(projectName, projectDesc, DateTimeParser.dateTime(projectTerm), code));

        Project newProject = projectRepository.findProjectByProjectSecureCode(code);

        AppUserHasProject appUserHasProject = new AppUserHasProject();
        appUserHasProject.setProject(newProject);
        appUserHasProject.setAppUser(appUser);
        appUserHasProject.setAppUserRole(appUserRoleRepository.findAppUserRoleByRoleName("ROLE_LEADER"));

        appUserHasProjectRepository.save(appUserHasProject);
    }

    @Transactional
    public void addProject(AppUser appUser, String projectCode){
        AppUserHasProject appUserHasProject = new AppUserHasProject();
        appUserHasProject.setProject(projectRepository.findProjectByProjectSecureCode(projectCode));
        appUserHasProject.setAppUser(appUser);
        appUserHasProject.setAppUserRole(appUserRoleRepository.findAppUserRoleByRoleName("ROLE_EMPLOYEE"));

        appUserHasProjectRepository.save(appUserHasProject);
    }

    public void createProjectTask(String taskName, String taskDescription, String taskTerm, Long projectId) throws ParseException {
        projectTaskRepository.save(new ProjectTask(null,
                taskName,
                taskDescription,
                DateTimeParser.dateTime(taskTerm),
                false,
                ProjectCodeGenerator.generateNewCode(),
                projectRepository.findProjectById(projectId),
                null
        ));
    }

    public void editProjectTask(String taskName,
                                String taskDescription,
                                String taskTerm,
                                String username,
                                Long taskId) throws ParseException {
        ProjectTask editedTask = projectTaskRepository.getProjectTaskById(taskId);
        editedTask.setTaskName(taskName);
        editedTask.setTaskDescription(taskDescription);
        editedTask.setTaskTerm(DateTimeParser.dateTime(taskTerm));
        editedTask.setAppUser(appUserRepository.findByUsername(username));

        projectTaskRepository.save(editedTask);
    }

    public List<ProjectTask> getProjectTaskList(Long id){
        return projectTaskRepository.getProjectTasksByProject(getProjectById(id));
    }
    public Project getProjectById(Long id){
        return projectRepository.findProjectById(id);
    }
    public boolean userAccessToProject(AppUser appUser, Long id){
        return appUserHasProjectRepository.existsAppUserHasProjectByAppUserAndProject(appUser, getProjectById(id));
    }

    public List<Project> getLeaderUserProjects(Long userId){
        return projectRepository.loadLeaderUserProjectsById(userId);
    }

    public List<Project> getEmployeeUserProjects(Long userId){
        return projectRepository.loadEmployeeUserProjectsById(userId);
    }

    public List<AppUserHasProject> userHasProject(Long projectId){
        return appUserHasProjectRepository.getAppUserHasProjectsByProject(projectRepository.findProjectById(projectId));
    }

    public AppUserHasProject getProjectAppUser(AppUser appUser, Project project){
        return appUserHasProjectRepository.getAppUserHasProjectByAppUserAndProject(appUser, project);
    }

    public void markTaskDone(ProjectTask projectTask, boolean isDone){
        projectTask.setDone(isDone);
        projectTaskRepository.save(projectTask);
    }

    public void deleteTaskById(Long id){
        projectTaskRepository.deleteById(id);
    }

    public void deleteUserFromProject(String username, Long projectId){
        AppUser appUser = appUserRepository.findByUsername(username);
        Project project = projectRepository.findProjectById(projectId);

        project.setProjectSecureCode(ProjectCodeGenerator.generateNewCode());
        List<ProjectTask> userTasks = projectTaskRepository.getProjectTasksByAppUserAndProject(appUser, project);
        for (ProjectTask userTask : userTasks){
            userTask.setAppUser(null);
            projectTaskRepository.save(userTask);
        }
        appUserHasProjectRepository.delete(appUserHasProjectRepository.getAppUserHasProjectByAppUserAndProject(appUser, project));
    }

    public void deleteProject(Long projectId){
        List<AppUserHasProject> userHasProjects = appUserHasProjectRepository
                .getAppUserHasProjectsByProject(projectRepository.findProjectById(projectId));
        List<ProjectTask> projectTaskList = projectTaskRepository
                .getProjectTasksByProject(projectRepository.findProjectById(projectId));
        for (AppUserHasProject userHasProject : userHasProjects){
            appUserHasProjectRepository.delete(userHasProject);
        }
        for (ProjectTask projectTask : projectTaskList){
            projectTaskRepository.deleteById(projectTask.getId());
        }
        projectRepository.deleteById(projectId);
    }

    public ProjectTask getProjectTaskById(Long id){
        return projectTaskRepository.getProjectTaskById(id);
    }

}
