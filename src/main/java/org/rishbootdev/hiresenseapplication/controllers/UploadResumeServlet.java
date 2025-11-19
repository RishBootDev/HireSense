package org.rishbootdev.hiresenseapplication.controllers;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.List;

import org.json.JSONObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import org.rishbootdev.hiresenseapplication.dao.ResumeAnalysisLogDAO;
import org.rishbootdev.hiresenseapplication.pojo.ResumeAnalysisLogsPojo;
import org.rishbootdev.hiresenseapplication.utils.AffindaAPI;

@MultipartConfig
public class UploadResumeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("userId") == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int userId = (Integer) session.getAttribute("userId");
		Part filePart = request.getPart("resume");
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

		String uploadDir = getServletContext().getRealPath("/resumes");
		File dir = new File(uploadDir);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File resumeFile = new File(dir, fileName);
		try {
			List<ResumeAnalysisLogsPojo> logs = ResumeAnalysisLogDAO.getLogsByUser(userId);
			if (!logs.isEmpty()) {
				String prevJson = logs.get(0).getJsonResult();
				JSONObject obj = new JSONObject(prevJson);
				String prevPath = obj.getJSONObject("data").optString("resumePath", null);
				if (prevPath != null) {
					File oldFile = new File(prevPath);
					if (oldFile.exists()) {
						oldFile.delete();
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		try(InputStream input=filePart.getInputStream();FileOutputStream out=new FileOutputStream(resumeFile)){
			byte[]buffer=new byte[1024];
			int bytesRead;
			while((bytesRead=input.read(buffer))!=-1){
				out.write(buffer,0,bytesRead);
			}
		}
		// Call Affinda  API 
		try {
			   String resultJson= AffindaAPI.analyzeResume(resumeFile);
			   JSONObject result=new JSONObject(resultJson);
			   result.getJSONObject("data").put("resumePath", resumeFile.getAbsolutePath());
			   ResumeAnalysisLogDAO.saveLog(userId,result.toString());
			   
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		response.sendRedirect("userDashboard.jsp");

	}

}
