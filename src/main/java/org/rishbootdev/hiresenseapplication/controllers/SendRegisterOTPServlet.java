package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.mail.MessagingException;
import org.rishbootdev.hiresenseapplication.utils.MailUtil;


public class SendRegisterOTPServlet extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String role=request.getParameter("role");
		String otp=String.valueOf((int)(Math.random()*900000)+100000);
		session.setAttribute("regOTP", otp);
		session.setAttribute("regName", name);
		session.setAttribute("regEmail", email);
		session.setAttribute("regPassword", password);
		session.setAttribute("regRole",role);
		String appName=(String)super.getServletContext().getAttribute("appName");
		try {
			MailUtil.sendTextEmail(email,"Your OTP for "+appName+" Registration", "Hi "+name+"\n\n Your OTP to complete the registration process is "+otp);
			response.sendRedirect("register.jsp?showOtp=true");
		}catch(MessagingException ex) {
			throw new ServletException("Error in sending mail:"+ex.getMessage());
		}
	}

}
