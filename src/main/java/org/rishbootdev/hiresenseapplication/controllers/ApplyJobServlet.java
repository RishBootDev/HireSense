package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import org.rishbootdev.hiresenseapplication.dao.ApplicationDao;
import org.rishbootdev.hiresenseapplication.dao.JobDao;
import org.rishbootdev.hiresenseapplication.dao.ResumeAnalysisLogDAO;
import org.rishbootdev.hiresenseapplication.dao.UserDao;
import org.rishbootdev.hiresenseapplication.pojo.ApplicationPojo;
import org.rishbootdev.hiresenseapplication.pojo.JobPojo;
import org.rishbootdev.hiresenseapplication.pojo.ResumeAnalysisLogsPojo;
import org.rishbootdev.hiresenseapplication.pojo.UserPojo;
import org.rishbootdev.hiresenseapplication.utils.MailUtil;


public class ApplyJobServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("userId")==null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int userId=(Integer)session.getAttribute("userId");
		int jobId=Integer.parseInt(request.getParameter("jobId"));
		int score=(int)Double.parseDouble(request.getParameter("score"));
		try {
			String resumePath="N/A";
			List<ResumeAnalysisLogsPojo>logs= ResumeAnalysisLogDAO.getLogsByUser(userId);
			if(!logs.isEmpty()) {
				String resultJson=logs.get(0).getJsonResult();
				JSONObject obj=new JSONObject(resultJson);
				JSONObject data=obj.getJSONObject("data");
				resumePath=data.optString("resumePath","N/A");
			}
			ApplicationPojo app=new ApplicationPojo(0,userId,jobId,resumePath,score,"applied",null);
			ApplicationDao.apply(app);
			UserPojo u1=UserDao.getUserById(userId);
			JobPojo job= JobDao.getJobById(jobId);
			MailUtil.sendApplicationConfirmation(u1.getName(),u1.getEmail(),job.getTitle(),job.getCompany());
			UserPojo u2= UserDao.getUserById(job.getEmployerId());
			MailUtil.sendNewApplicationNotificationToEmployer(u2.getName(), u2.getEmail(), u1.getName(), job.getTitle());
            response.sendRedirect("UserDashBoardServlet?success=applied");

        }catch (Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("error.jsp");
		}
		
	}

}
