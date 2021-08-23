package ru.job4j.carmarket.servlet;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import ru.job4j.carmarket.model.*;
import ru.job4j.carmarket.persistence.RegistrationHibernate;
import ru.job4j.carmarket.persistence.StoreHibernate;
import ru.job4j.carmarket.util.MarketUtil;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Logger;

public class PersonalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOG = Logger.getLogger(Model.class.toString());

    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 2;  // 2MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 30;    // 30MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

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
        resp.setHeader("Content-Type", "text/xml; charset=UTF-8");
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");

        String name = null;
        String description = null;
        String iUser = null;
        String iMark = null;
        String iModel = null;
        String iCity = null;
        String iYear = null;
        String iPrice = null;
        String photoname = null;
        Long createdBy;

        try {
            DiskFileItemFactory factory = new DiskFileItemFactory();

            factory.setSizeThreshold(MEMORY_THRESHOLD);

            ServletContext servletContext = this.getServletConfig().getServletContext();
            File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
            factory.setRepository(repository);
            ServletFileUpload upload = new ServletFileUpload(factory);

            upload.setFileSizeMax(MAX_FILE_SIZE);
            upload.setSizeMax(MAX_REQUEST_SIZE);

            List<FileItem> items = upload.parseRequest(req);
            if (items != null && items.size() > 0) {

                File folder = new File("C:\\Projects\\Job4j\\Job4j_Middle\\Images\\");
                if (!folder.exists()) {
                    folder.mkdir();
                }
                for (FileItem item : items) {
                    if (!item.isFormField()) {
                        photoname = item.getName();
                        File file = new File(folder + File.separator + photoname);
                        try (FileOutputStream out = new FileOutputStream(file);
                             BufferedInputStream in = new BufferedInputStream(item.getInputStream())
                        ) {
                            byte[] dataBuffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = in.read(dataBuffer, 0, dataBuffer.length)) != -1) {
                                out.write(dataBuffer, 0, bytesRead);
                            }
                        }
                    }
                }
            }
            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem fileItem = iter.next();
                if (fileItem.isFormField()) {
                    if (fileItem.getFieldName().equals("name")) {
                        name = fileItem.getString();
                        LOG.info(name);
                    } else if (fileItem.getFieldName().equals("descriptions")) {
                        description = fileItem.getString();
                        LOG.info(description);
                    } else if (fileItem.getFieldName().equals("userId")) {
                        iUser = fileItem.getString();
                        LOG.info(iUser);
                    } else if (fileItem.getFieldName().equals("cmMark")) {
                        iMark = fileItem.getString();
                        LOG.info(iMark);
                    } else if (fileItem.getFieldName().equals("cmModel")) {
                        iModel = fileItem.getString();
                        LOG.info(iModel);
                    } else if (fileItem.getFieldName().equals("cmCity")) {
                        iCity = fileItem.getString();
                        LOG.info(iCity);
                    } else if (fileItem.getFieldName().equals("cmYear")) {
                        iYear = fileItem.getString();
                        LOG.info(iYear);
                    } else if (fileItem.getFieldName().equals("cmPrice")) {
                        iPrice = fileItem.getString();
                        LOG.info(iPrice);
                    }
                }
            }

            Car car = new Car();
            Brand brand = new Brand();
            Model model = new Model();

            User user = RegistrationHibernate.getInstance().getById(Long.valueOf(iUser));
            City city = StoreHibernate.getInstance().getByIdCity(Integer.valueOf(iCity));
            createdBy = user.getId();


            if (user.getId() == Long.valueOf(iUser)) {
                brand.setId(Integer.valueOf(iMark));
                model.setId(Integer.valueOf(iModel));
                car.setCreatedBy(user.getId());
                car.setBrand(brand);
                car.setModel(model);
                car.setPrice(iPrice);
                car.setYears(iYear);

                StoreHibernate.getInstance().save(
                        new Market(
                                name,
                                description,
                                user,
                                car,
                                city,
                                photoname,
                                createdBy
                        )
                );
                resp.sendRedirect(req.getContextPath() + "/advertisement.do");
            } else {
                resp.sendRedirect(req.getContextPath() + "notes/edit.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}