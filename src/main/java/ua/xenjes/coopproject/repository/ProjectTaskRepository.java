package ua.xenjes.coopproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.xenjes.coopproject.entity.AppUser;
import ua.xenjes.coopproject.entity.Project;
import ua.xenjes.coopproject.entity.ProjectTask;

import java.util.List;

@Repository
public interface ProjectTaskRepository extends JpaRepository<ProjectTask, Long> {
    List<ProjectTask> getProjectTasksByProject(Project project);
    ProjectTask getProjectTaskById(Long id);

    List<ProjectTask> getProjectTasksByAppUserAndProject(AppUser appUser, Project project);
}
