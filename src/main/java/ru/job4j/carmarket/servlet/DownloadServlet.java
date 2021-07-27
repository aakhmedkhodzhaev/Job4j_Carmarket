package ru.job4j.carmarket.servlet;

import org.apache.commons.io.IOUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

public class DownloadServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String photo = req.getParameter("photo");
        resp.setContentType("photo=" + photo);
        resp.setContentType("image/jpg");
        resp.setHeader("Content-Disposition", "attachment; filename=\"" + photo + "\"");
        File file = new File("C:\\Projects\\Job4j\\Job4j_Middle\\Images\\" + File.separator + photo);
        try (FileInputStream in = new FileInputStream(file)) {
            byte[] bytes = IOUtils.toByteArray(in);
            resp.getOutputStream().write(bytes);
        }
    }
}