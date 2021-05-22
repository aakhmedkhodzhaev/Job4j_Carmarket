package ru.job4j.carmarket.persistence;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.carmarket.model.Market;

import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;

public class StoreHibernate implements Store, AutoCloseable {

    private final static StoreHibernate INSTANCE = new StoreHibernate();

    public final static StoreHibernate getInstance() {
        return INSTANCE;
    }

    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();

    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();

    private static final Logger LOG = Logger.getLogger(Market.class.toString());

    private Session session = null;
    private Transaction transaction = null;


    @Override
    public void save(Market market) {
        if (market.getId() == 0) {
            create(market);
        } else {
            update(market);
        }
    }

    @Override
    public Collection<Market> findAll() {
        Collection<Market> lMarket = null;
        try {
            start();
            lMarket = session.createQuery("from j_market").list(); // return empty getResultList() return null
            transaction.commit(); // за коммитить
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return lMarket;
    }

    private Market create(Market market) {
        return market;
    }

    private void update(Market market) {
    }

    @Override
    public Market getById(int id) {
        return null;
    }

    @Override
    public Boolean removeById(int id) {
        return null;
    }

    @Override
    public Boolean deleteAll(Market market) {
        return null;
    }


    private void start() {
        session = sf.openSession();
        transaction = session.beginTransaction();
    }

    @Override
    public void close() throws Exception {
        StandardServiceRegistryBuilder.destroy(registry);
    }

}