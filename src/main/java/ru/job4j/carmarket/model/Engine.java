package ru.job4j.carmarket.model;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "j_engine")
public class Engine {

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
        if (!(o instanceof Engine)) {
            return false;
        }
        Engine engine = (Engine) o;
        return getId() == engine.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

}