package ua.xenjes.coopproject.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ua.xenjes.coopproject.entity.AppUserRole;

@Repository
public interface AppUserRoleRepository extends JpaRepository<AppUserRole, Long> {

    AppUserRole findAppUserRoleByRoleName(String roleName);

}
