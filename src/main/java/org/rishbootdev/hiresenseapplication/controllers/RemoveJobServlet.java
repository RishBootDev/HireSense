package org.rishbootdev.hiresenseapplication.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.JobDao;

import java.io.IOException;

public class RemoveJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        // Session check
        if (session == null || session.getAttribute("userId") == null ||
                !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        String jobIdParam = request.getParameter("jobId");

        if (jobIdParam == null || jobIdParam.trim().isEmpty()) {
            response.sendRedirect("AdminPanelServlet?error=Invalid Job ID");
            return;
        }
        try {
            int jobId = Integer.parseInt(jobIdParam);
            boolean deleted = JobDao.deleteJob(jobId);
            if (deleted) {
                response.sendRedirect("AdminPanelServlet?success=Job deleted successfully");
            } else {
                response.sendRedirect("AdminPanelServlet?error=Job deletion failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
