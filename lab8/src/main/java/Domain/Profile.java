package Domain;

import java.sql.Blob;
import java.util.Arrays;
import java.util.Objects;

public class Profile {
    private Integer user_id;
    private String name;
    private String emailAddress;
//    private Blob picture;
    private String pictureLocationOnDisk;
    private Integer age;
    private String homeTown;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Profile profile = (Profile) o;
        return Objects.equals(user_id, profile.user_id) &&
                Objects.equals(name, profile.name) &&
                Objects.equals(emailAddress, profile.emailAddress) &&
                Objects.equals(pictureLocationOnDisk, profile.pictureLocationOnDisk) &&
                Objects.equals(age, profile.age) &&
                Objects.equals(homeTown, profile.homeTown);
    }

    @Override
    public int hashCode() {
        return Objects.hash(user_id, name, emailAddress, pictureLocationOnDisk, age, homeTown);
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }

    public String getPictureLocationOnDisk() {
        return pictureLocationOnDisk;
    }

    public void setPictureLocationOnDisk(String pictureLocationOnDisk) {
        this.pictureLocationOnDisk = pictureLocationOnDisk;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getHomeTown() {
        return homeTown;
    }

    public void setHomeTown(String homeTown) {
        this.homeTown = homeTown;
    }

    public Profile() {
    }

    public Profile(Integer user_id, String name, String emailAddress, String picture, Integer age, String homeTown) {
        this.user_id = user_id;
        this.name = name;
        this.emailAddress = emailAddress;
        this.pictureLocationOnDisk = picture;
        this.age = age;
        this.homeTown = homeTown;
    }

}
