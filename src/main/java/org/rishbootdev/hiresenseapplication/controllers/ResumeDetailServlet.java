package org.rishbootdev.hiresenseapplication.controllers;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.rishbootdev.hiresenseapplication.dao.ResumeAnalysisLogDAO;
import org.rishbootdev.hiresenseapplication.pojo.ResumeAnalysisLogsPojo;
import org.rishbootdev.hiresenseapplication.utils.AffindaAPI;

import java.io.IOException;
import java.util.List;

public class ResumeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            List<ResumeAnalysisLogsPojo> logs = ResumeAnalysisLogDAO.getLogsByUser(userId);
            if (logs.isEmpty()) {
                req.setAttribute("error", "No analysis found for this user.");
            } else {
                ResumeAnalysisLogsPojo latest = logs.get(0);
                String resultJson = latest.getJsonResult();
                req.setAttribute("summary", AffindaAPI.extractSummary(resultJson));
                req.setAttribute("skillsList", AffindaAPI.extractSkills(resultJson));
                req.setAttribute("personalDetails", AffindaAPI.extractPersonalDetails(resultJson));
                req.setAttribute("education", AffindaAPI.extractEducation(resultJson));
                req.setAttribute("workExperience", AffindaAPI.extracteWorkExperience(resultJson));

            }
            req.getRequestDispatcher("resumeDetails.jsp").forward(req, res);
        } catch (Exception e) {
            throw new ServletException("Error fetching resume details", e);
        }
    }
}