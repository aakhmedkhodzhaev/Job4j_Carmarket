package ru.job4j.carmarket.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Objects;

@Entity
@Table(name = "j_market")
public class Market {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "car_id")
    private Car car;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "city_id")
    private City city;

    @Column(name = "photo_name")
    private String photoname;

    @Column(name = "created_by")
    private Long createdBy;

    @CreationTimestamp
    @Column(name = "created_date")
    private LocalDateTime createDate;

    @UpdateTimestamp
    @Column(name = "updated_date")
    private LocalDateTime updatedDate;


    public Market() {
        super();
    }

    public Market(int id, String name, String description, User user, Car car, City city, String photoname) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.user = user;
        this.car = car;
        this.city = city;
        this.photoname = photoname;
    }

    public Market(String name, String description, User user, Car car, City city, String photoname) {
        this.name = name;
        this.description = description;
        this.user = user;
        this.car = car;
        this.city = city;
        this.photoname = photoname;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Car getCar() {
        return car;
    }

    public void setCar(Car car) {
        this.car = car;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public String getPhoto() {
        return photoname;
    }

    public void setPhoto(String photoname) {
        this.photoname = photoname;
    }

    public Long getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Long createdBy) {
        this.createdBy = createdBy;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public LocalDateTime getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(LocalDateTime updatedDate) {
        this.updatedDate = updatedDate;
    }


    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Market)) {
            return false;
        }
        Market market = (Market) o;
        return getId() == market.getId();
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId());
    }

    public String toJsonString() {
        return "{" +
                "\"id\"" + ":" + id + "," +
                "\"name\"" + ":" + "\"" + name + "\"," +
                "\"city\"" + ":" + "\"" + city.getName() + "\"," +
                "\"price\"" + ":" + "\"" + car.getPrice() + "\"," +
                "\"photo\"" + ":" + "\"" + photoname + "\"," +
                "\"description\"" + ":" + "\"" + description + "\"," +
                "\"created\"" + ":" + "\"" + createDate + "\"," +
                "\"user\"" + ":" + "\"" + user.getId() + "\"" +
                "}";
    }

}