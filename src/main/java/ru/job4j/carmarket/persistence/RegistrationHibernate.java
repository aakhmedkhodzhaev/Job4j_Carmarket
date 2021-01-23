package ru.job4j.carmarket.persistence;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import ru.job4j.carmarket.model.User;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;


public class RegistrationHibernate implements Registration, AutoCloseable {

    private final static RegistrationHibernate INSTANCE = new RegistrationHibernate();

    private final static RegistrationHibernate getInstance() {
        return INSTANCE;
    }

    private static final Logger LOG = Logger.getLogger(User.class.toString());

    private final StandardServiceRegistry registry = new StandardServiceRegistryBuilder().configure().build();

    private final SessionFactory sf = new MetadataSources(registry).buildMetadata().buildSessionFactory();
/*
    private Session session = null;
    private Transaction transaction = null;*/


    @Override
    public void save(User user) {
        if (user.getId() == null) {
            create(user);
        } else {
            update(user);
        }
    }


    private void create(User user) {
        try (Session session = sf.openSession()) {
            Transaction transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();
        }
    }

    private void update(User user) {
        try (Session session = sf.openSession()) {
            Transaction transaction = session.beginTransaction();
            session.save(user);
            transaction.commit();
        }
    }

    @Override
    public boolean dropUser(User user) {
        Boolean result;
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            if (user != null) {
                User users = session.get(User.class, user.getId());
                session.delete(users);
                result = true;
                session.getTransaction().commit();
            } else {
                result = false;
                LOG.info("You can't just take and Drop User");
            }
        }
        return result;
    }

    @Override
    public User findByEmail(String email) {
        User result;
        try (Session session = sf.openSession()) {
            session.beginTransaction();

            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<User> cq = cb.createQuery(User.class);
            Root<User> root = cq.from(User.class);
            cq.select(root).where(cb.equal(root.get("email"), email));

            Query query = session.createQuery(cq);
            query.setMaxResults(1);
            List<User> users = query.getResultList();
            if (users.size() == 0) {
                result = null;
            } else {
                result = users.get(0);
            }
        }
        return result;
    }

    @Override
    public User getById(Long id) {
        User user;
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            user = session.get(User.class, id);
        }
        return user;
    }

    @Override
    public User getByData(String email, String password) {
        User user;
        try (Session session = sf.openSession()) {
            session.beginTransaction();

            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<User> cr = cb.createQuery(User.class);
            Root<User> root = cr.from(User.class);
            cr.select(root).where(cb.equal(root.get("email"), email), cb.equal(root.get("password"), password));

            Query query = session.createQuery(cr);
            query.setMaxResults(1);
            List<User> users = query.getResultList();
            if (users.size() == 0) {
                user = null;
            } else {
                user = users.get(0);
            }
        }
        return user;
    }

    @Override
    public Collection<User> allUsers() {
        Collection<User> result;
        try (Session session = sf.openSession()) {
            session.beginTransaction();
            result = session.createQuery("from User Order by 1").getResultList();
        }
        return result;
    }

    @Override
    public void close() throws Exception {
        StandardServiceRegistryBuilder.destroy(registry);
    }

    public static void main(String[] args) {
        User user = new User();
        user.setEmail("root@mail.su");
        user.setName("Maxim");
        user.setPassword("1");
        RegistrationHibernate.getInstance().save(user);
        user.getId();
        user.getEmail();
        user.getName();
        user.getPassword();

    }

}