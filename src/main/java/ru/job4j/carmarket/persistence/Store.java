package ru.job4j.carmarket.persistence;

import ru.job4j.carmarket.model.Brand;
import ru.job4j.carmarket.model.City;
import ru.job4j.carmarket.model.Market;

import java.util.Collection;
import java.util.List;

public interface Store {

    void save(Market market);

    Collection<Market> findAll();

    Market getById(int id);

    Boolean removeById(int id);

    Boolean deleteAll(Market market);

    void save(City city);

    Collection<City> findAllCity();

    City getByIdCity(int id);

    Boolean removeByIdCity(int id);

    Collection<Brand> findAllBrand();

}