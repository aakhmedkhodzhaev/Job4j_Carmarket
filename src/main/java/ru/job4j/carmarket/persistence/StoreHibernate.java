package ru.job4j.carmarket.persistence;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.carmarket.model.Brand;
import ru.job4j.carmarket.model.City;
import ru.job4j.carmarket.model.Market;
import ru.job4j.carmarket.model.Model;

import java.util.Collection;
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
            lMarket = session.createQuery("from Market").list(); // return empty getResultList() return null
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

    private void create(Market market) {
        start();
        session.save(market);
        if (transaction != null) {
            transaction.commit();
        } else {
            transaction.rollback();
        }
    }

    private void update(Market market) {
        start();
        session.update(market);
        if (transaction != null) {
            transaction.commit();
        } else {
            transaction.rollback();
        }
    }

    @Override
    public Market getById(int id) {
        try {
            start();
            Market result = session.get(Market.class, id);
            if (transaction != null) {
                transaction.commit();
                return result;
            } else {
                transaction.rollback();
            }
        } catch (HibernateException e) {
            transaction.rollback();
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return null;
    }

    @Override
    public Boolean removeById(int id) {
        Boolean result = false;
        try {
            start();
            Market delMarket = session.load(Market.class, id);
            session.delete(delMarket);
            if (transaction != null) {
                transaction.commit();
                result = true;
            } else {
                transaction.rollback();
            }
        } catch (Exception e) {
            transaction.rollback();
        }
        return result;
    }

    @Override
    public Boolean deleteAll(Market market) {
        Boolean result = false;
        try {
            start();
            Market delMarket = session.load(Market.class, market.getUser().getId());
            session.delete(delMarket);
            if (transaction != null) {
                transaction.commit();
                result = true;
            } else {
                transaction.rollback();
            }
        } catch (Exception e) {
            transaction.rollback();
        }
        return result;
    }

    @Override
    public void save(City city) {
        if (city.getId() == 0) {
            create(city);
        } else {
            update(city);
        }
    }

    private void create(City city) {
        start();
        session.save(city);
        if (transaction != null) {
            transaction.commit();
        } else {
            transaction.rollback();
        }
    }

    private void update(City city) {
        start();
        session.update(city);
        if (transaction != null) {
            transaction.commit();
        } else {
            transaction.rollback();
        }
    }


    @Override
    public Collection<City> findAllCity() {
        Collection<City> lCity;
        try {
            start();
            lCity = session.createQuery("from City").getResultList();
            return lCity;
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return null;
    }

    @Override
    public City getByIdCity(int id) {
        try {
            start();
            City result = session.get(City.class, id);
            if (transaction != null) {
                transaction.commit();
                return result;
            }
        } catch (HibernateException e) {
            transaction.rollback();
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return null;
    }

    @Override
    public Boolean removeByIdCity(int id) {
        return null;
    }

    @Override
    public Collection<Brand> findAllBrand() {
        Collection<Brand> lBrand;
        try {
            start();
            lBrand = session.createQuery("from Brand").getResultList();
            return lBrand;
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return null;
    }

    @Override
    public Collection<Model> findAllModel() {
        Collection<Model> lModel;
        try {
            start();
            lModel = session.createQuery("from Model").getResultList();
            return lModel;
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
        return null;
    }

    @Override
    public Collection<Model> findByIdModel(int id) {
        try {
            start();
            Collection<Model> result = session.createQuery("from Model where brand_id =" + id).getResultList();
            return result;
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            LOG.info("Ошибка");
        } finally {
            session.close();
        }
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

/*
  public static void main(String[] args) {
        int id = 2;
        Collection<Model> lModel = StoreHibernate.getInstance().findByIdModel(id);
            System.out.println(lModel);
        }*/

}