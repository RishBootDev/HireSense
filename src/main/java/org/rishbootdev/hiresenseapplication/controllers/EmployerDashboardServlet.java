package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;


public class EmployerDashboardServlet extends HttpServlet {
	
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null||!"employer".equals((String)session.getAttribute("userRole"))) {
			response.sendRedirect("login.jsp");
			return;
		}
		
		int employerId=(Integer)session.getAttribute("userId");
		String search=request.getParameter("search");
		String sort=request.getParameter("sort");
		String status=request.getParameter("status");
		try {
			List<JobPojo>jobList= JobDao.getJobsByEmployer(employerId, search, status, sort);
			request.setAttribute("jobList", jobList);
			request.setAttribute("search",search);
			request.setAttribute("status",status);
			request.setAttribute("sort",sort);
			RequestDispatcher rd=request.getRequestDispatcher("employeDashboard.jsp");
			rd.forward(request, response);			
		}catch(Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	

}
