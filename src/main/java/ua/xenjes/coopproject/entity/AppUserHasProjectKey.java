package ua.xenjes.coopproject.entity;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode

@Embeddable
public class AppUserHasProjectKey implements Serializable {

    @Column(name = "app_user_id")
    Long appUserId;

    @Column(name = "project_id")
    Long projectId;

}
