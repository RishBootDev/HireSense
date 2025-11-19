package org.rishbootdev.hiresenseapplication.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.dao.UserDao;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;
import org.rishbootdev.hiresenseapplication.pojo.UserPojo;

import java.io.IOException;
import java.util.List;

public class AdminPanelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null ||
                !"admin".equals(session.getAttribute("userRole"))) {
            res.sendRedirect("login.jsp");
            return;
        }

        String search = req.getParameter("search");
        String role = req.getParameter("role");
        String status = req.getParameter("status");

        try {
            List<UserPojo> users = UserDao.getFilteredUsers(search, role, status);
            List<JobPojo> jobs = JobDao.getAllJobsWithEmployerAndApplicantCount();

            req.setAttribute("users", users);
            req.setAttribute("jobs", jobs);

            req.getRequestDispatcher("adminPanel.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }

}
