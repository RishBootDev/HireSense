package org.rishbootdev.hiresenseapplication.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.JobDao;

import java.io.IOException;



public class ToggleJobStatusServlet extends HttpServlet {
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null||!"employer".equals((String)session.getAttribute("userRole"))) {
			response.sendRedirect("login.jsp");
			return;
		}
		int jobId=Integer.parseInt(request.getParameter("jobId"));
		try {
			JobDao.toggleJobStatus(jobId);
			response.sendRedirect("EmployerDashboardServlet");
		}catch(Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("EmployerDashboardServlet?error=1");
		}
	}

	

}
