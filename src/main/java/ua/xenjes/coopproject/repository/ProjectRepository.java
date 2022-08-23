package ua.xenjes.coopproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import ua.xenjes.coopproject.entity.Project;

import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {

    @Query("select p, r.roleName " +
            "from Project p " +
            "inner join AppUserHasProject up " +
            "on p.id = up.project.id " +
            "inner join AppUser u " +
            "on up.appUser.id = u.id " +
            "inner join AppUserRole r " +
            "on r.id = up.appUserRole.id " +
            "where u.id = ?1 and r.roleName = 'ROLE_LEADER'")
    public List<Project> loadLeaderUserProjectsById(Long userId);

    @Query("select p, r.roleName " +
            "from Project p " +
            "inner join AppUserHasProject up " +
            "on p.id = up.project.id " +
            "inner join AppUser u " +
            "on up.appUser.id = u.id " +
            "inner join AppUserRole r " +
            "on r.id = up.appUserRole.id " +
            "where u.id = ?1 and r.roleName = 'ROLE_EMPLOYEE'")
    public List<Project> loadEmployeeUserProjectsById(Long userId);

    public Project findProjectByProjectSecureCode(String code);

    public Project findProjectById(Long id);

}
