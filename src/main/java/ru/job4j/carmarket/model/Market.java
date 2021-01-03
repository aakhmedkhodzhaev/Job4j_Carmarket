package ru.job4j.carmarket.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "j_market")
public class Market {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

    private String description;

    private User user;

    private Car car;

    private String photoname;

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

    public String getPhoto() {
        return photoname;
    }

    public void setPhoto(String photoname) {
        this.photoname = photoname;
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
}