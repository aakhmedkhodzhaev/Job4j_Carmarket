package ru.job4j.carmarket.persistence;

import ru.job4j.carmarket.model.Market;

import java.io.Serializable;
import java.util.List;

public interface Store {

    List<Market> lMarket();

    Serializable add(Market market);

    void updateMarket(Market market);

    Market getById(int id);

    Market removeById(int id);

    Market deleteAll(Market market);

}