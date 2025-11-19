package org.rishbootdev.hiresenseapplication.utils;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class MailUtil {
   public static void sendTextEmail(String recepientEmailId,String subject,String body)throws MessagingException{
	   Session sess=MailConfig.getSession();
	   Message message=new MimeMessage(sess);
	   InternetAddress []addr=InternetAddress.parse(recepientEmailId);
	   message.setRecipients(Message.RecipientType.TO, addr);
       message.setSubject(subject);
       message.setText(body);
       Transport.send(message);   
	   
   }
   public static void sendApplicationConfirmation(String name,String toEmail,String jobTitle,String company)throws MessagingException{
	   String subject="✔Application Submitted -"+jobTitle;
	   String body="\n\nDear "+name+",\n\nYou have successfully applied for the position of "+jobTitle+" at "+company+"\n";
	   body+="We wish you best of luck\n\n";
	   body+="Regards, Team HireSense";
	   sendTextEmail(toEmail,subject,body);
   }
   public static void sendNewApplicationNotificationToEmployer(String employerName,String toEmail,String applicantName,String jobTitle)throws MessagingException{
	   String subject="✔New Application Received";
	   String body="\n\nDear "+employerName+",\n\nA new candidate ("+applicantName+") has applied for "+jobTitle;
	   body+="\n\nYou can review the applicant's details in your dashboard\n\n";
	   body+="Regards, Team HireSense";
	   sendTextEmail(toEmail,subject,body);
   }
   
}
