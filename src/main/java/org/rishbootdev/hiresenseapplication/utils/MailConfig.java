package org.rishbootdev.hiresenseapplication.utils;

import java.util.Properties;

import jakarta.mail.Session;

public class MailConfig {
	private static final String USERNAME = "demomailing192@gmail.com";
    private static final String PASSWORD = "mgkw yzni necr qkaa";
	public static Session getSession() {
	   Properties prop = new Properties();
	   prop.put("mail.smtp.host", "smtp.gmail.com");
       prop.put("mail.smtp.port", "465");
       prop.put("mail.smtp.auth", "true");
       prop.put("mail.smtp.socketFactory.port", "465");
       prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
       MyAuthenticator auth=new MyAuthenticator(USERNAME,PASSWORD);
       return Session.getInstance(prop, auth);
	}
}
