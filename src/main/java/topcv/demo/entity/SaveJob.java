package topcv.demo.entity;

import javax.persistence.*;

@Entity
@Table(name = "saved_jobs")
public class SaveJob {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "recruitment_id")
    private int recruitmentId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRecruitmentId() {
        return recruitmentId;
    }

    public void setRecruitmentId(int recruitmentId) {
        this.recruitmentId = recruitmentId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
