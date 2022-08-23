package ua.xenjes.coopproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import ua.xenjes.coopproject.entity.AppUser;
import ua.xenjes.coopproject.service.ProjectService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.Objects;

@Controller
public class ProjectController {

    private final ProjectService projectService;

    @Autowired
    public ProjectController(ProjectService projectService){
        this.projectService = projectService;
    }

    @GetMapping("/hub")
    public String viewHubPage(HttpServletRequest request,
                              Model model){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else {
            AppUser appUser = (AppUser) session.getAttribute("appuser");
            model.addAttribute("lead_projects", projectService.getLeaderUserProjects(appUser.getId()));
            model.addAttribute("employee_projects", projectService.getEmployeeUserProjects(appUser.getId()));
            return "hub";
        }
    }

    @PostMapping("/hub/create-project")
    public String createNewProject(String projectName,
                                   String projectDescription,
                                   String projectTerm,
                                   HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else {
            projectService.createProject((AppUser) session.getAttribute("appuser"), projectName, projectDescription, projectTerm);
        }
        return "redirect:/hub";
    }

    @PostMapping("/hub/add-project")
    public String addUserToProject(String projectCode, HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else {
            projectService.addProject((AppUser) session.getAttribute("appuser"), projectCode);
        }
        return "redirect:/hub";
    }

    @GetMapping("/hub/project/{id}")
    public String projectPage(@PathVariable("id") Long projectId,
                              Model model,
                              HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "redirect:/hub";
        }else {
            model.addAttribute("appuser-properties", projectService.getProjectAppUser(
                    (AppUser) session.getAttribute("appuser"),
                    projectService.getProjectById(projectId))
            );
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectUsers", projectService.userHasProject(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "project";
        }
    }

    @PostMapping("/hub/project/{id}/create-task")
    public String createTask(@PathVariable("id") Long projectId,
                             String taskName,
                             String taskDescription,
                             String taskTerm,
                             Model model,
                             HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.createProjectTask(taskName, taskDescription, taskTerm, projectId);
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub/project/{id}";
        }
    }

    @PostMapping("/hub/project/{projectId}/task/{taskId}/edit")
    public String editTask(@PathVariable("projectId") Long projectId,
                           @PathVariable("taskId") Long taskId,
                           String taskName,
                           String taskDescription,
                           String taskTerm,
                           String username,
                           Model model,
                           HttpServletRequest request) throws ParseException {
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.editProjectTask(taskName, taskDescription, taskTerm, username, taskId);
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub/project/{projectId}";
        }
    }

    @PostMapping("/hub/project/{projectId}/task/{taskId}/mark")
    public String markTask(@PathVariable("projectId") Long projectId,
                           @PathVariable("taskId") Long taskId,
                           String doneParam,
                           Model model,
                           HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.markTaskDone(projectService.getProjectTaskById(taskId), !Objects.equals(doneParam, "true"));
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub/project/{projectId}";
        }
    }

    @PostMapping("/hub/project/{projectId}/task/{taskId}/delete")
    public String removeTask(@PathVariable("projectId") Long projectId,
                           @PathVariable("taskId") Long taskId,
                           Model model,
                           HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.deleteTaskById(taskId);
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub/project/{projectId}";
        }
    }

    @PostMapping("/hub/project/{projectId}/remove-user")
    public String removeUserFromProject(@PathVariable("projectId") Long projectId,
                                        String username,
                                        Model model,
                                        HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.deleteUserFromProject(username, projectId);
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub/project/{projectId}";
        }
    }

    @PostMapping("/hub/project/{projectId}/delete-project")
    public String deleteProject(@PathVariable("projectId") Long projectId,
                                Model model,
                                HttpServletRequest request){
        HttpSession session = request.getSession();
        if (Objects.isNull(session.getAttribute("appuser"))){
            return "redirect:/login";
        }else if (!projectService.userAccessToProject((AppUser) session.getAttribute("appuser"), projectId)){
            return "error";
        }else {
            projectService.deleteProject(projectId);
            model.addAttribute("projectInfo", projectService.getProjectById(projectId));
            model.addAttribute("projectTaskList", projectService.getProjectTaskList(projectId));
            return "redirect:/hub";
        }
    }

}
