package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.ApplicationDao;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.dao.ResumeAnalysisLogDAO;
import org.rishbootdev.hiresenseapplication.pojo.ApplicationPojo;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;
import org.rishbootdev.hiresenseapplication.pojo.ResumeAnalysisLogsPojo;
import org.rishbootdev.hiresenseapplication.utils.AffindaAPI;


public class UserDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int userId=(Integer)session.getAttribute("userId");
		String search=request.getParameter("search");
		String sort=request.getParameter("sort");
		String location=request.getParameter("location");
		String experience=request.getParameter("experience");
		String packageLpa=request.getParameter("packageLpa");
		try {
			List<ResumeAnalysisLogsPojo>logs= ResumeAnalysisLogDAO.getLogsByUser(userId);
			boolean resumeUploaded=!logs.isEmpty();
			List<String>userSkills=null;
			if(resumeUploaded) {
				JSONObject obj=new JSONObject(logs.get(0).getJsonResult());
				userSkills= AffindaAPI.extractSkills(obj.toString());
			}
			List<JobPojo>jobs= JobDao.getAllJobsForUserDashboard(search, sort, location, experience, packageLpa);
			if(resumeUploaded && userSkills!=null) {
				for(JobPojo job:jobs) {
					int score=AffindaAPI.calculateMatchScore(job.getSkills(),userSkills);
					job.setScore(score);
				}
			}
			List<ApplicationPojo>appliedList= ApplicationDao.getApplicationsByUser(userId);
			Set<Integer>appliedJobIds=new HashSet<>();
			for(ApplicationPojo app:appliedList) {
			  appliedJobIds.add(app.getJobId());	
			}
			request.setAttribute("jobs",jobs);
			request.setAttribute("appliedJobIds",appliedJobIds);
			request.setAttribute("search",search);
			request.setAttribute("sort",sort);
			request.setAttribute("location",location);
			request.setAttribute("experience",experience);
			request.setAttribute("packageLpa",packageLpa);
			request.setAttribute("resumeUploaded",resumeUploaded);
			RequestDispatcher rd=request.getRequestDispatcher("userDashboard.jsp");
			rd.forward(request, response);			
		}catch(Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("error.jsp");
		}
			
			
		}
		
        @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
