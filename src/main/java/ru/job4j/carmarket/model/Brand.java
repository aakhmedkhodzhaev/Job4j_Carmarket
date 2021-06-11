package ru.job4j.carmarket.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "j_brand")
public class Brand {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String name;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Brand)) {
            return false;
        }
        Brand brand = (Brand) o;
        return getId() == brand.getId();
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId());
    }

}