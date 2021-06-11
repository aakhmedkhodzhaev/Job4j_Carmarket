package ru.job4j.carmarket.servlet;

import ru.job4j.carmarket.model.*;
import ru.job4j.carmarket.persistence.StoreHibernate;
import ru.job4j.carmarket.util.MarketUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PersonalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        req.setAttribute("notes", StoreHibernate.getInstance().findAll());
        req.setAttribute("user", req.getSession().getAttribute("user"));
        User user = MarketUtil.getLoginedUser(session);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        } else {
            req.getRequestDispatcher("advertisement.jsp").forward(req, resp);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String description = req.getParameter("descriptions");
        String iUser = req.getParameter("userId");
        String iMark = req.getParameter("cmMark");
        String iModel = req.getParameter("cmModel");
        String iCity = req.getParameter("cmCity");
        String iYear = req.getParameter("cmYear");
        String iPrice = req.getParameter("cmPrice");

        String photoname = req.getParameter("cmFile");

        User user = new User();
        Car car = new Car();
        Brand brand = new Brand();
        Model model = new Model();
        City city = new City();
        user.setId(Long.valueOf(iUser));
        brand.setName(iMark);
        model.setName(iModel);
        car.setBrand(brand);
        car.setModel(model);
        car.setPrice(iPrice);
        car.setYears(iYear);
        city.setId(Integer.valueOf(iCity));

        if (user != null) {
            StoreHibernate.getInstance().save(
                    new Market(
                            name,
                            description,
                            user,
                            car,
                            city,
                            photoname
                    )
            );
            resp.sendRedirect(req.getContextPath() + "/advertisement.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "notes/edit.jsp");
        }

    }

}