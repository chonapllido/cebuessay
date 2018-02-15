package stm.com.program.sentmail.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import stm.com.generic.web.GenericController;
import stm.com.program.sentmail.service.SentmailService;
import stm.com.program.user.service.UserService;
import stm.com.program.user.web.UserCommand;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;
import stm.com.support.mail.MailCommand;
import stm.com.support.mail.MailController;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/sentmail")
public class SentmailController extends GenericController<SentmailService, SentmailCommand> {

	MailController mailControl;
	
	@RequestMapping(value="/listadd.do", method=RequestMethod.GET)
	public ModelAndView listadd(SentmailCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sentmail/write");
		
		UserCommand _cmd = new UserCommand();
		UserService _service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		
		mav.addObject("users", _service.getListAll(_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/insertList.do", method=RequestMethod.POST)
	public String insertList(SentmailCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		String folderDest = "/uploads/mail/";
		String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + folderDest;
		FileMngUtil fileUtil = new FileMngUtil();
		
		Map<String, MultipartFile> files = multireq.getFileMap();
		
		/* send email */
		String emails = StringUtils.join(cmd.getId_checks(),",");
		MailCommand mail = new MailCommand();
		mail.setFromName("CebuEssay");
		mail.setSendFrom("cebu.seoul@cebuessay.com");
		mail.setSendTo(emails);
		mail.setMessage(cmd.getContent());
		mail.setSubject(cmd.getContent());
		
		if (!files.isEmpty()) {
			FileCommand _cmd = fileUtil.uploadFile(files, folderDest);
			cmd.setAttachment(_cmd.getOrig_name());
			filePath += _cmd.getOrig_name();
		
			mailControl.sendMailAttach(mail, filePath);
		} else {
			mailControl.sendMail(mail);
		}
		
		getService().insertList(cmd, req, res);
		
		return "redirect:/back/sentmail/list.do";
	}
	
	@RequestMapping(value="/listadd.do", method=RequestMethod.POST)
	public ModelAndView listaddPost(SentmailCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sentmail/write");
		
		UserCommand _cmd = new UserCommand();
		if(req.getParameterMap().containsKey("search_field")){
			_cmd.setSearch_field(req.getParameter("search_field"));
			_cmd.setSearch_keyword(req.getParameter("search_keyword"));
		}
		UserService _service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		UserCommand users = _service.getListAll(_cmd, req, res);
		users.setSearch_field(req.getParameter("search_field"));
		users.setSearch_keyword(req.getParameter("search_keyword"));
		
		mav.addObject("users", users);
		
		return mav;
	}
	@RequestMapping(value="/listadd.do")
	public ModelAndView insert(SentmailCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sentmail/write");
		
		UserCommand _cmd = new UserCommand();
		UserService _service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		
		mav.addObject("users", _service.getListAll(_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/downloadAttach.do", method=RequestMethod.POST)
	public void downloadResult(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String fileName = req.getParameter("file");
		String folderDest = "/uploads/mail/";
		
		FileCommand cmd = new FileCommand();
		cmd.setNew_name(fileName);
		cmd.setOrig_name(fileName);
		
		FileMngUtil fileUtil = new FileMngUtil();
		fileUtil.downloadFile(cmd, folderDest, req, res);
	}
	
}