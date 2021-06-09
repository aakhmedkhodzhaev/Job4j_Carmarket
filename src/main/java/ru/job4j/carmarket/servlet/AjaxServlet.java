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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collection;
import java.util.logging.Logger;

public class AjaxServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Gson gson = new Gson();

    private static final Logger LOG = Logger.getLogger(Model.class.toString());


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        req.setAttribute("user", req.getSession().getAttribute("user"));

        try {
            String operation = req.getParameter("operation");

            if (operation.equals("cities")) {
                Collection<City> cities = StoreHibernate.getInstance().findAllCity();
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(cities);
                resp.getWriter().write(json);
            }

            if (operation.equals("brand")) {
                Collection<Brand> brands = StoreHibernate.getInstance().findAllBrand();
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(brands);
                resp.getWriter().write(json);
            }

            if (operation.equals("model")) {
                int id = Integer.valueOf(req.getParameter("id"));
                Collection<Model> models = StoreHibernate.getInstance().findByIdModel(id);
                gson = new GsonBuilder().setPrettyPrinting().create();
                String json = gson.toJson(models);
                resp.getWriter().write(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String userId = req.getParameter("user_id");
        String name = req.getParameter("name");
        String city = req.getParameter("iCity");
        String brand = req.getParameter("iMark");
        String model = req.getParameter("iModel");
        String descriptions = req.getParameter("descriptions");
        String years = req.getParameter("iYear");
        String price = req.getParameter("iPrice");
        String file = req.getParameter("iFile");
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