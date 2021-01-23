package ru.job4j.carmarket.persistence;

import ru.job4j.carmarket.model.User;

import java.util.Collection;

public interface Registration {

    void save(User user);

    boolean dropUser(User user);

    User findByEmail(String email);

    User getById(Long id);

    User getByData(String email,
                   String password);

    Collection<User> allUsers();

}