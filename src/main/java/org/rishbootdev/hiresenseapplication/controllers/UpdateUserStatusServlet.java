package org.rishbootdev.hiresenseapplication.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.UserDao;

import java.io.IOException;

public class UpdateUserStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null ||
                !"admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        String userIdParam = request.getParameter("userId");
        String action = request.getParameter("action");

        if (userIdParam == null || action == null) {
            response.sendRedirect("AdminPanelServlet?error=Invalid request");
            return;
        }
        try {
            int userId = Integer.parseInt(userIdParam);
            String newStatus = action.equals("block") ? "blocked" : "active";
            int updated = UserDao.updateStatus(userId, newStatus);
            if (updated>0) {
                response.sendRedirect(
                        "AdminPanelServlet?success=User status updated successfully");
            } else {
                response.sendRedirect(
                        "AdminPanelServlet?error=Status update failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminPanelServlet?error=Something went wrong");
        }
    }
}
