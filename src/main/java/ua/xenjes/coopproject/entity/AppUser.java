package ua.xenjes.coopproject.entity;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

@Entity
@Table(name = "app_user")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", length = 20)
    private String username;

    @Column(name = "password", length = 20)
    private String password;


    @OneToMany(mappedBy = "appUser", cascade = CascadeType.ALL)
    private List<AppUserHasProject> appUserProjectList;

    @OneToMany(mappedBy = "appUser", cascade = CascadeType.ALL)
    private List<ProjectTask> projectTaskList;

    public AppUser(String username, String password) {
        this.username = username;
        this.password = password;
        this.appUserProjectList = new ArrayList<>();
        this.projectTaskList = new ArrayList<>();
    }
}
