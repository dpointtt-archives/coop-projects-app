package ua.xenjes.coopproject.entity;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString

@Entity
@Table(name = "project")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String projectName;

    private String projectDescription;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private Timestamp projectTerm;

    private String projectSecureCode;

    @OneToMany(mappedBy = "project", cascade = CascadeType.ALL)
    List<AppUserHasProject> hasProjects;

    @OneToMany(mappedBy = "project", cascade = CascadeType.ALL)
    private List<ProjectTask> projectTaskList;

    public Project(String projectName, String projectDescription,Timestamp projectTerm, String projectSecureCode){
        this.projectName = projectName;
        this.projectDescription = projectDescription;
        this.projectTerm = projectTerm;
        this.projectSecureCode = projectSecureCode;
        this.hasProjects = new ArrayList<>();
        this.projectTaskList = new ArrayList<>();
    }

}
