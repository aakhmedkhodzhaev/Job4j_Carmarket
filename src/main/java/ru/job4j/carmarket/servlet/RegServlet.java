package ru.job4j.carmarket.servlet;

import ru.job4j.carmarket.model.User;
import ru.job4j.carmarket.persistence.RegistrationHibernate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        if (user.getName() != null) {
            req.setAttribute("email", RegistrationHibernate.getInstance().findByEmail("email"));
        }
        req.getRequestDispatcher("reg.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, NullPointerException {
        String email = req.getParameter("email"),
                name = req.getParameter("name"),
                password = req.getParameter("pswd");

        req.setCharacterEncoding("UTF-8");
        if (RegistrationHibernate.getInstance().findByEmail(email) == null // проверка на наличие уникальности, так же в таблице на данном столбце стоит ограничению по unique (constraint)
                && name != "" && password != ""
                && email.length() > 5 && name.length() > 3 && password.length() > 0) {
            RegistrationHibernate.getInstance().save(
                    new User(
                            email,
                            name,
                            password
                    )
            );
            resp.sendRedirect(req.getContextPath() + "/auth.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "/reg.do");
        }
    }

}