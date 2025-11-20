package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;
import java.util.List;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.ApplicationDao;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.pojo.ApplicationPojo;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;


public class ViewApplicantsServlet extends HttpServlet {
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null||!"employer".equals((String)session.getAttribute("userRole"))) {
			response.sendRedirect("login.jsp");
			return;
		}
		try {
			    int jobId=Integer.parseInt(request.getParameter("jobId"));
			    String status=request.getParameter("status")!=null?request.getParameter("status"):"applied";
			    //Fetch job details
			    JobPojo job= JobDao.getJobById(jobId);
			    if(job==null) {
			    	response.sendRedirect("EmployerDashboardServlet?error=InvalidJob");
			    	return;
			    }
			    List<ApplicationPojo>list= ApplicationDao.getApplicationsByJobAndStatus(jobId, status);
			    request.setAttribute("job", job);
			    request.setAttribute("applicants", list);
			    request.setAttribute("status", status);
			    RequestDispatcher rd=request.getRequestDispatcher("viewApplicants.jsp");
				rd.forward(request, response);
			    
		}catch(Exception ex) {
           ex.printStackTrace();
			throw new ServletException("Unable to fetch applicants or job details");
		}
	}
}
