package org.rishbootdev.hiresenseapplication.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.rishbootdev.hiresenseapplication.dao.UserDao;
import org.rishbootdev.hiresenseapplication.pojo.UserPojo;

public class VerifyRegisterOTPServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String inputOtp = request.getParameter("otp");
		HttpSession session = request.getSession();
		String actualOtp = (String) session.getAttribute("regOTP");
		if (inputOtp.equals(actualOtp)) {
			String name = (String) session.getAttribute("regName");
			String email = (String) session.getAttribute("regEmail");
			String password = (String) session.getAttribute("regPassword");
			String role = (String) session.getAttribute("regRole");
			UserPojo user = new UserPojo(0, name, email, password, role, "active", null);
			try {
				int userId = UserDao.registerUser(user);
				session.setAttribute("userId", userId);
				session.removeAttribute("regOTP");
				response.sendRedirect("login.jsp?registered=true");
			} catch (Exception ex) {
				throw new ServletException("Error in OTP verification/registration:" + ex.getMessage());
			}

		} else {
			response.sendRedirect("register.jsp?showOtp=true&error=invalid");
		}
	}
}
