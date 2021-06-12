package ru.job4j.carmarket.model;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(name = "j_car")
public class Car {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @ManyToOne
    @JoinColumn(name = "brand_id", foreignKey = @ForeignKey(name = "j_brand_id_fk"))
    private Brand brand;

    @ManyToOne
    @JoinColumn(name = "model_id", foreignKey = @ForeignKey(name = "j_model_id_fk"))
    private Model model;

    @Column(name = "price")
    private String price;

    @Column(name = "years")
    private String years;

    @Column(name = "created_by")
    private Long createdBy;

    @Column(name = "created_date")
    private LocalDateTime createDate;

    // private Set<Driver> drivers = new HashSet<>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getYears() {
        return years;
    }

    public void setYears(String years) {
        this.years = years;
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

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    /*
        @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
        @JoinTable(name = "j_history_owner", joinColumns = {
                @JoinColumn(name = "driver_id", nullable = false, updatable = false)},
                inverseJoinColumns = {@JoinColumn(name = "car_id",
                        nullable = false, updatable = false)})
        public Set<Driver> getDrivers() {
            return drivers;
        }

        public void setDrivers(Set<Driver> drivers) {
            this.drivers = drivers;
        }

        // @OneToOne(cascade = CascadeType.ALL, mappedBy = "j_car")*/
    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Car)) {
            return false;
        }
        Car car = (Car) o;
        return getId() == car.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }

}