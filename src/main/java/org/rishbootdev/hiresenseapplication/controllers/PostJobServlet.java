package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;


public class PostJobServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null||!"employer".equals((String)session.getAttribute("userRole"))) {
			response.sendRedirect("login.jsp");
			return;
		}
		try {
			int employerId=(Integer)session.getAttribute("userId");
			String title=request.getParameter("title");
			String description=request.getParameter("description");
			String skills=request.getParameter("skills");
			String company=request.getParameter("company");
			String location=request.getParameter("location");
			String experience=request.getParameter("experience");
			String packageLpa=request.getParameter("packageLpa");
			int vaccancies=Integer.parseInt(request.getParameter("vaccancies"));
			JobPojo job=new JobPojo();
			job.setTitle(title);
			job.setDescription(description);
			job.setSkills(skills);
			job.setCompany(company);
			job.setLocation(location);
			job.setExperience(experience);
			job.setPackageLpa(packageLpa);
			job.setVacancies(vaccancies);
			job.setEmployerId(employerId);
			boolean result= JobDao.postJob(job);
			if(result) {
				response.sendRedirect("EmployerDashboardServlet?success=1");
			}else {
				response.sendRedirect("EmployerDashboardServlet?error=1");
			}
		}catch(Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("EmployerDashboardServlet?error=1");
		}
	}

}
