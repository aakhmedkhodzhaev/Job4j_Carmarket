package ru.job4j.carmarket.persistence;

import ru.job4j.carmarket.model.Market;

import java.io.Serializable;
import java.util.List;

public class StoreHibernate implements Store {

    private final static StoreHibernate INSTANCE = new StoreHibernate();

    private final static StoreHibernate getInstance() {
        return INSTANCE;
    }

    @Override
    public List<Market> lMarket() {
        return null;
    }

    @Override
    public Serializable add(Market market) {
        return null;
    }

    @Override
    public void updateMarket(Market market) {

    }

    @Override
    public Market getById(int id) {
        return null;
    }

    @Override
    public Market removeById(int id) {
        return null;
    }

    @Override
    public Market deleteAll(Market market) {
        return null;
    }
}