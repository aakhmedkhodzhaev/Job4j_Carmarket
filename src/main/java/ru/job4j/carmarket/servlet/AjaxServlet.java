package ru.job4j.carmarket.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import ru.job4j.carmarket.model.Brand;
import ru.job4j.carmarket.model.City;
import ru.job4j.carmarket.model.Market;
import ru.job4j.carmarket.model.Model;
import ru.job4j.carmarket.persistence.StoreHibernate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

public class AjaxServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Gson gson = new Gson();


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            String operation = req.getParameter("operation");

            if (operation.equals("cities")) {
                Collection<City> city = StoreHibernate.getInstance().findAllCity();
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(city);
                resp.getWriter().write(json);
            }

            if (operation.equals("brand")) {
                Collection<Brand> brand = StoreHibernate.getInstance().findAllBrand();
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(brand);
                resp.getWriter().write(json);
            }

           /* if (operation.equals("model")) {
                Collection<Model> brand = StoreHibernate.getInstance().findAllBModel();
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(brand);
                resp.getWriter().write(json);
            }*/
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        if (req.getParameter("").length() > 5) {
            StoreHibernate.getInstance().save(
                    new Market()
            );
            resp.sendRedirect(req.getContextPath() + "/advertisement.do");
        } else {
            resp.sendRedirect(req.getContextPath() + "notes/edit.jsp");
        }

    }

}