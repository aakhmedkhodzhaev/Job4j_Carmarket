package ru.job4j.carmarket.servlet;

import ru.job4j.carmarket.model.Market;
import ru.job4j.carmarket.persistence.StoreHibernate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;

public class JsonServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        Collection<Market> markets;
        markets = StoreHibernate.getInstance().findAll();
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        int sizeMarket = markets.size();
        for (int i = 0; i < sizeMarket; i++) {
            sb.append(((ArrayList<Market>) markets).get(i).toJsonString());
            if (i == sizeMarket - 1) {
                break;
            }
            sb.append(",");
        }
        sb.append("]");

        PrintWriter writer = resp.getWriter();
        writer.append(sb);

        writer.flush();
    }


}