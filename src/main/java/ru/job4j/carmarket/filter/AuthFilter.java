package ru.job4j.carmarket.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest sreq, ServletResponse sresp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) sreq;
        HttpServletResponse resp = (HttpServletResponse) sresp;
        String uri = req.getRequestURI();
        if (uri.endsWith("auth.do")) {
            chain.doFilter(sreq, sresp);
            return;
        }

        if (uri.endsWith("reg.do")) {
            chain.doFilter(sreq, sresp);
            return;
        }

        if (req.getSession().getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            return;
        }
        /*
        if (req.getSession().getAttribute("email") != null) {
            resp.sendRedirect(req.getContextPath() + "/advertisement.jsp");
            return;
        }

        HttpSession session = req.getSession(false);// don't create if it doesn't exist
        if (session != null && !session.isNew()) {
            chain.doFilter(req, resp);
        } else {
            resp.sendRedirect("/login.jsp");
        }
        */

        chain.doFilter(sreq, sresp);
    }

    @Override
    public void destroy() {
    }
}