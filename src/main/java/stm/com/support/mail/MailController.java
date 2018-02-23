package stm.com.support.mail;

import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.MailParseException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;

import stm.com.program.order.web.OrderCommand;
import egovframework.com.cmm.service.EgovProperties;

@Controller
public class MailController {

	public void sendMail(MailCommand cmd, String flag){

		SimpleMailMessage mail_msg = new SimpleMailMessage();
		if(flag.equals("single")){
			mail_msg.setTo(cmd.getSendTo());
		} else {
			mail_msg.setTo(cmd.getSendToM());
		}
		mail_msg.setFrom(cmd.getSendFrom());
		mail_msg.setSubject(cmd.getSubject());
		mail_msg.setText(cmd.getMessage());

		Properties mailProperties = new Properties(); 
        mailProperties.put("mail.smtp.auth", true); 
        mailProperties.put("mail.debug", true); 
        mailProperties.put("mail.smtp.starttls.enable", true); 
        mailProperties.put("mail.smtp.starttls.required", true); 
        mailProperties.put("mail.smtp.ssl.trust", EgovProperties.getProperty("Globals.mailHost"));

        JavaMailSenderImpl mailSender = new JavaMailSenderImpl(); 
        mailSender.setJavaMailProperties(mailProperties); 
        mailSender.setHost(EgovProperties.getProperty("Globals.mailHost")); 
        mailSender.setPort(Integer.parseInt(EgovProperties.getProperty("Globals.mailPort"))); 
        mailSender.setUsername(EgovProperties.getProperty("Globals.mailUserName")); 
        mailSender.setPassword(EgovProperties.getProperty("Globals.mailPassword"));
  
        try {
			mailSender.send(mail_msg);
			
		} catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
	public void sendMailAttach(MailCommand cmd, String filePath){
		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl(); 
		MimeMessage message = mailSender.createMimeMessage(); 
		
		try{
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(cmd.getSendFrom());
			helper.setTo(cmd.getSendTo());
			helper.setSubject(cmd.getSubject());
			helper.setText(cmd.getMessage());
			
			FileSystemResource file = new FileSystemResource(filePath);
			helper.addAttachment(file.getFilename(), file);
		} catch(MessagingException e){
			throw new MailParseException(e);
		}
		
		try {
			mailSender.send(message);
		}catch(Exception e) {
			e.printStackTrace();
		}		
	}
	
	public void sendOrderNotice(OrderCommand cmd, String topic){
		String to[] = {"chona_fhlare@yahoo.com", "chonapllido@gmail.com"};
		String fromEmail = EgovProperties.getProperty("Globals.mailSendFromEmail");
		String fromName	= EgovProperties.getProperty("Globals.mailSendFromName");
		String subject = "CebuEssay New Order #"+cmd.getOrder_id();
		String message = "Order ID: "+cmd.getOrder_id()+"\nUser Email: "+cmd.getUser_email()+"\nTopic: "+topic+";"
				+ "\nDeadline: "+cmd.getEnd_date().substring(0, 10)+"\nPrice: "+cmd.getTotal_payment()+"$";
		
		
		MailCommand mail = new MailCommand();
		mail.setSendFrom(fromEmail);
		mail.setFromName(fromName);
		mail.setSendToM(to);
		mail.setSendTo(to[0]);
		//mail.setSendTo("csinternational08@gmail.com,cebuessay@gmail.com");
		mail.setSubject(subject);
		mail.setMessage(message);
		
		System.out.println(message);

		this.sendMail(mail, "multiple");
	
	}
}
