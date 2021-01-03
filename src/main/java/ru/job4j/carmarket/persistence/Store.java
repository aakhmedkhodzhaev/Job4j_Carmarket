package ru.job4j.carmarket.persistence;

import ru.job4j.carmarket.model.Market;

import java.util.List;

public interface Store {

    void save(Market market);

    List<Market> findAll();

    Market getById(int id);

    Boolean removeById(int id);

    Boolean deleteAll(Market market);

}