package ua.xenjes.coopproject.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor

@Entity
@Table(name = "app_user_has_project")
public class AppUserHasProject {

    @EmbeddedId
    private AppUserHasProjectKey id = new AppUserHasProjectKey();

    @ManyToOne
    @MapsId("appUserId")
    @JoinColumn(name = "app_user_id")
    private AppUser appUser;

    @ManyToOne
    @MapsId("projectId")
    @JoinColumn(name = "project_id")
    private Project project;

    @ManyToOne
    @JoinColumn(name = "app_user_role_id")
    private AppUserRole appUserRole;

}
