package org.rishbootdev.hiresenseapplication.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.ApplicationDao;
import java.io.IOException;

public class UpdateApplicationStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null ||
                !"employer".equals(session.getAttribute("userRole"))) {
            res.sendRedirect("login.jsp");
            return;
        }
        String appIdParam = req.getParameter("appId");
        String jobIdParam = req.getParameter("jobId");
        String status = req.getParameter("status");

        if (appIdParam == null || jobIdParam == null || status == null ||
                appIdParam.isEmpty() || jobIdParam.isEmpty() || status.isEmpty()) {
            res.sendRedirect("ViewApplicantsServlet?error=Invalid parameters");
            return;
        }
        try {
            int appId = Integer.parseInt(appIdParam);
            int jobId = Integer.parseInt(jobIdParam);

            boolean updated = ApplicationDao.updateApplicationStatus(appId, status);
            if (updated) {
                res.sendRedirect(
                        "ViewApplicantsServlet?jobId=" + jobId +
                                "&success=Status updated to " + status);
            } else {
                res.sendRedirect(
                        "ViewApplicantsServlet?jobId=" + jobId +
                                "&error=Failed to update status");
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }
}
