package ru.job4j.carmarket.servlet;

import ru.job4j.carmarket.model.User;
import ru.job4j.carmarket.persistence.RegistrationHibernate;
import ru.job4j.carmarket.util.MarketUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, NullPointerException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        //  String rememberMe = req.getParameter("rememberMe");
        //  boolean remember = "Y".equals(rememberMe);

        User user = RegistrationHibernate.getInstance().getByData(email, password);
        if (user != null) {
            HttpSession sc = req.getSession();
            user.setId(user.getId());
            user.setEmail(user.getEmail());
            user.setPassword(password);
            MarketUtil.saveLoginedUser(sc, user); // ToDo Сохранение данных user в сессии
            /*
            if (remember) {
                MarketUtil.saveUserCookie(resp, user);
            } else {
                MarketUtil.deleteUserCookies(resp);
            }*/
            sc.setAttribute("user", user); // Дублирует сохранение данных user в сессии
            resp.sendRedirect(req.getContextPath() + "/advertisement.jsp");
        } else {
            req.setAttribute("error", "Не верный email или пероль");
            req.getRequestDispatcher("/reg.do").forward(req, resp);
        }
    }
}