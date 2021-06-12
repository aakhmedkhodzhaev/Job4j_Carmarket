package ru.job4j.carmarket.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;
import ru.job4j.carmarket.model.*;
import ru.job4j.carmarket.persistence.StoreHibernate;
import ru.job4j.carmarket.util.MarketUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;

public class AjaxServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private Gson gson = new Gson();

    private static final Logger LOG = Logger.getLogger(Model.class.toString());


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = MarketUtil.getLoginedUser(session);

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "login.jsp");
            req.setAttribute("user", user);
            return;
        } else {

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            req.setAttribute("user", user);
            // req.setAttribute("user", req.getSession().getAttribute("user")); // ToDo Дублирует сохранение данных user в сессии

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
                LOG.info("Ошибка");
            }

        }

    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        DiskFileItemFactory factory = new DiskFileItemFactory(); // ServletContext servletContext = this.getServletConfig().getServletContext();
        File files = new File("C:\\Projects\\Job4j\\Job4j_Middle\\Images\\"); // (File) servletContext.getAttribute("javax.servlet.context.tempdir");
        factory.setRepository(files);
        ServletFileUpload upload = new ServletFileUpload(factory);
        try {
            List<FileItem> items = upload.parseRequest(req);
            File folder = new File("images");
            if (!folder.exists()) {
                folder.mkdir();
            }
            for (FileItem item : items) {
                if (!item.isFormField()) {
                    File file = new File(folder + File.separator + item.getName());
                    try (BufferedInputStream in = new BufferedInputStream(item.getInputStream());
                         FileOutputStream out = new FileOutputStream(file)) {
                        byte[] bytes = IOUtils.toByteArray(in);
                        out.write(bytes);
                    }
                }
            }
        } catch (FileUploadException | FileNotFoundException e) {
            e.printStackTrace();
        }
        doGet(req, resp);
    }

}