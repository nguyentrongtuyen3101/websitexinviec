package topcv.demo.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "users")
public class User {

    public enum Role {
        ADMIN,
        USER,
        COMPANY
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "address")
    private String address;

    @Column(name = "description")
    private String description;

    @Column(name = "email")
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "image")
    private String image;

    @Column(name = "password")
    private String password;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "status")
    private int status;

    @Enumerated(EnumType.STRING)
    @Column(name = "role_name")
    private Role roleName; 

    @Column(name = "cv_id")
    private Integer cvId;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<CV> cvs;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<SaveJob> saveJobs;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<FollowCompany> followCompanies;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<ApplyPost> applyPosts;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Recruitment> recruitments;

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Role getRoleName() {
        return roleName;
    }

    public void setRoleName(Role roleName) {
        this.roleName = roleName;
    }

    public Integer getCvId() {
        return cvId;
    }

    public void setCvId(Integer cvId) {
        this.cvId = cvId;
    }

    public List<CV> getCvs() {
        return cvs;
    }

    public void setCvs(List<CV> cvs) {
        this.cvs = cvs;
    }

    public List<SaveJob> getSaveJobs() {
        return saveJobs;
    }

    public void setSaveJobs(List<SaveJob> saveJobs) {
        this.saveJobs = saveJobs;
    }

    public List<FollowCompany> getFollowCompanies() {
        return followCompanies;
    }

    public void setFollowCompanies(List<FollowCompany> followCompanies) {
        this.followCompanies = followCompanies;
    }

    public List<ApplyPost> getApplyPosts() {
        return applyPosts;
    }

    public void setApplyPosts(List<ApplyPost> applyPosts) {
        this.applyPosts = applyPosts;
    }

    public List<Recruitment> getRecruitments() {
        return recruitments;
    }

    public void setRecruitments(List<Recruitment> recruitments) {
        this.recruitments = recruitments;
    }
}