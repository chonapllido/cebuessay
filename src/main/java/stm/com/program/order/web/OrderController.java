package stm.com.program.order.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.com.cmm.service.EgovProperties;
import stm.com.generic.web.GenericController;
import stm.com.program.etorder.service.EtOrderService;
import stm.com.program.etorder.web.EtOrderCommand;
import stm.com.program.login.web.LoginCommand;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.service.OrderService;
import stm.com.program.user.service.UserService;
import stm.com.program.user.web.UserCommand;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;
import stm.com.support.mail.MailCommand;
import stm.com.support.mail.MailController;
import stm.com.support.util.ApplicationHelper;
import stm.com.support.util.Functions;

@Controller
@RequestMapping("/back/order")
public class OrderController extends GenericController<OrderService, OrderCommand> {

	MailController mailControl;
	
	@Override
	public ModelAndView list(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		ModelAndView mav = super.list(cmd, req, res);
		
		LoginCommand login_cmd = getUserLogin(req, res);
		if (login_cmd == null || !login_cmd.getPosition_id().equals("1") ) {
			ModelAndView modelAndView = new ModelAndView("redirect:/front/main.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		// cancel overdue orders
		cancelUnpaidOrders(req, res);
		
		OrderCommand new_cmd = new OrderCommand();
		OrderService service = getService();
		mav.addObject("pending_total", service.getPendingTotalByMonth(new_cmd, req, res));
				
		UserCommand writer_cmd = new UserCommand();
		UserService user_service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		writer_cmd.setPosition_id("2");
		mav.addObject("writers", user_service.getListOfficers(writer_cmd, req, res));

		UserCommand manager_cmd = new UserCommand();
		manager_cmd.setPosition_id("1");
		mav.addObject("managers", user_service.getListOfficers(manager_cmd, req, res));

		return mav;
	}
	
	@RequestMapping(value="/updateManager.do", method=RequestMethod.GET, produces="text/plain")
	@ResponseBody
	public void updateManager(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String type = req.getParameter("type");
		String order_id = req.getParameter("order_id");
		String manager_id = req.getParameter("manager_id");
		
		OrderCommand cmd = new OrderCommand();
		cmd.setOrder_id(order_id);
		cmd.setManager_id(manager_id);
		
		OrderService service = getService();
		service.updateManager(cmd, req, res);
		
		if(type.equals("Essay")){
			OrderEssayCommand new_cmd = new OrderEssayCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setManager_id(manager_id);
			
			OrderEssayService new_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			new_service.updateManager(new_cmd, req, res);
		} else {
			OrderRevisionCommand new_cmd = new OrderRevisionCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setManager_id(manager_id);
			
			OrderRevisionService new_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			new_service.updateManager(new_cmd, req, res);
		}
		
		// check if from Essaytop
		if(isFromEssaytop(cmd, req, res)){
			EtOrderCommand et_cmd = new EtOrderCommand();
			EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
			et_cmd.setCe_order_id(order_id);
			et_cmd.setManager_id(manager_id);
			et_service.updateManager(et_cmd, req, res);
		}

	}
	
	@RequestMapping(value="/updateWriter.do", method=RequestMethod.GET, produces="text/plain")
	@ResponseBody
	public void updateWriter(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String type = req.getParameter("type");
		String order_id = req.getParameter("order_id");
		String writer_id = req.getParameter("writer_id");
		
		OrderCommand cmd = new OrderCommand();
		cmd.setOrder_id(order_id);
		cmd.setWriter_id(writer_id);
		
		OrderService service = getService();
		service.updateWriter(cmd, req, res);
		
		if(type.equals("Essay")){
			OrderEssayCommand new_cmd = new OrderEssayCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setWriter_id(writer_id);
			
			OrderEssayService new_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			new_service.updateWriter(new_cmd, req, res);
		} else {
			OrderRevisionCommand new_cmd = new OrderRevisionCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setWriter_id(writer_id);
			
			OrderRevisionService new_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			new_service.updateWriter(new_cmd, req, res);
		}

		// check if from Essaytop
		if(isFromEssaytop(cmd, req, res)){
			EtOrderCommand et_cmd = new EtOrderCommand();
			EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
			et_cmd.setCe_order_id(order_id);
			et_cmd.setWriter_id(writer_id);
			et_service.updateWriter(et_cmd, req, res);
		}
	}

	@RequestMapping(value="/updateStatus.do", method=RequestMethod.GET, produces="text/plain")
	@ResponseBody
	public void updateStatus(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String type = req.getParameter("type");
		String order_id = req.getParameter("order_id");
		String status = req.getParameter("status");
		String email = req.getParameter("email");
		String action = req.getParameter("do");
		String topic = req.getParameter("topic");
		String result = (req.getParameterMap().containsKey("result")) ? req.getParameter("result") : "";
		
		OrderCommand cmd = new OrderCommand();
		cmd.setOrder_id(order_id);
		cmd.setStatus(status);
		
		OrderService service = getService();
		service.updateStatus(cmd, req, res);
		
		if(type.equals("Essay")){
			OrderEssayCommand new_cmd = new OrderEssayCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setStatus(status);
			
			OrderEssayService new_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			new_service.updateStatus(new_cmd, req, res);

		} else {
			OrderRevisionCommand new_cmd = new OrderRevisionCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setStatus(status);
			
			OrderRevisionService new_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			new_service.updateStatus(new_cmd, req, res);
		}

		/* if from essaytop, update essaytop */
		if(isFromEssaytop(cmd, req, res)){
			EtOrderCommand et_cmd = new EtOrderCommand();
			if(status.equals("3") ){
				et_cmd.setStatus("6");
			} else {
				et_cmd.setStatus(status);
			}
			et_cmd.setCe_order_id(order_id);
			EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
			et_service.updateStatus(et_cmd, req, res);
		}
		
		/* email user */
		MailCommand mail = new MailCommand();
		mail.setFromName("CebuEssay");
		mail.setSendFrom("cebu.seoul@cebuessay.com");
		mail.setSendTo(email);
	
		if(action.equals("confirm")){
			String message = "Dear Customer, \n\n We are happy to inform you that your order with order id: "+order_id+" and topic "+topic+" has been confirmed\n"+
					  "If you have any concerns, please email us at cebuessay@gmail.com.\n\n Best Regards, \n\n Cebu Essay Administrator";
		  
			mail.setSubject("Confirmation of Order "+order_id);
			mail.setMessage(message);	
			mailControl.sendMail(mail, "single");
			
		} else if(action.equals("finish")){
			String filePath = EgovProperties.getProperty("Globals.orderFilesPath") + "/results/" + type.toLowerCase() + "/" + result;
			String message =  "Dear customer,\n\nAttached is your order "+order_id+" from Cebu Essay with topic: "+topic+".\nIf you have questions, you may email us at cebuessay@gmail.com.\n\nBest Regards,\nCebu Essay\r\n\r\n";
			mail.setSubject("Submission of Order "+order_id);
			mail.setMessage(message);;
			mailControl.sendMailAttach(mail, filePath);
			
		} else {
			
		}
		
	}
	
	@RequestMapping(value="/cancelOrder.do", method=RequestMethod.GET, produces="text/plain")
	@ResponseBody
	public void cancelOrder(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String type = req.getParameter("type");
		String order_id = req.getParameter("order_id");
		String email = req.getParameter("email");

		OrderCommand cmd = new OrderCommand();
		cmd.setOrder_id(order_id);
		
		OrderService service = getService();
		service.cancelOrder(cmd, req, res);
		
		if(type.equals("Essay")){
			OrderEssayCommand new_cmd = new OrderEssayCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setStatus("4");
			
			OrderEssayService new_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			new_service.updateStatus(new_cmd, req, res);
			
		} else {
			OrderRevisionCommand new_cmd = new OrderRevisionCommand();
			new_cmd.setOrder_id(order_id);
			new_cmd.setStatus("4");
			
			OrderRevisionService new_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			new_service.updateStatus(new_cmd, req, res);
		}

		/* if from essaytop, update essaytop */
		if(isFromEssaytop(cmd, req, res)){
			EtOrderCommand et_cmd = new EtOrderCommand();
			et_cmd.setStatus("4");
			et_cmd.setCe_order_id(order_id);
			EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
			et_service.updateStatus(et_cmd, req, res);
		}
		
		/* email user */
		String message = "Dear Customer, \n\n\nGreetings! \n\nWe would like to inform you that your order "+order_id+" has been cancelled due to any of the following:\n\n"+
				  "1. Lack of payment within 12 hours.\n2. The level of the task is beyond our skills.\n3. We could not finish the essay on the given due date.\n\n"+
		          "More power!\n\n\n\nBest Regards, \n\nCebu Essay Administrator";
		MailCommand mail = new MailCommand();
		mail.setFromName("CebuEssay");
		mail.setSendFrom("cebu.seoul@cebuessay.com");
		mail.setSendTo(email);
		mail.setSubject("Cancellation Notice of Order "+order_id);
		mail.setMessage(message);	
		mailControl.sendMail(mail, "single");	
		
	}
	
	@RequestMapping(value="/uploadResult.do", method=RequestMethod.POST)
	public String uploadResult(OrderCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res) throws FileNotFoundException, IOException, Exception{
		
		HashMap<String, String> _result = new HashMap<String, String>();
		
		FileMngUtil fileUtil = new FileMngUtil();
		Map<String, MultipartFile> files = multireq.getFileMap();
	
		String folderDest = "/results/";
		
		if(cmd.getType_id().equals("1")){
			folderDest += "essay/";
		} else {
			folderDest += "revision/";
		}
		
		if (!files.isEmpty()) {
			_result = fileUtil.parseFileOrigNm(files, folderDest);
		} 
		
		if(cmd.getType_id().equals("1")){
			
			OrderEssayCommand essay_cmd = new OrderEssayCommand();
			essay_cmd.setOrder_id(cmd.getOrder_id());
			essay_cmd.setResult(_result.get("originFileNameList"));
			
			OrderEssayService essay_service =  (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			essay_service.updateResult(essay_cmd, req, res);
		
		} else {
			OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
			rev_cmd.setOrder_id(cmd.getOrder_id());
			rev_cmd.setResult(_result.get("originFileNameList"));
			
			OrderRevisionService rev_service =  (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			rev_service.updateResult(rev_cmd, req, res);
		}
		
		String url = "redirect:/back/order/list.do?"+Functions.getQueryString()+getParams();
		
		return url;
	}
	
	@RequestMapping(value="/downloadResult.do", method=RequestMethod.POST)
	public void downloadResult(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String fileName = req.getParameter("result");
		String type = req.getParameter("type_id");
		String folderDest = "/results/";
		
		FileCommand cmd = new FileCommand();
		cmd.setNew_name(fileName);
		cmd.setOrig_name(fileName);
		
		if(type.equals("1")){
			folderDest += "essay/";
		} else {
			folderDest += "revision/";
		}
		
		FileMngUtil fileUtil = new FileMngUtil();
		fileUtil.downloadFile(cmd, folderDest, req, res);
	}
	
	@RequestMapping(value="/downloadFile.do", method=RequestMethod.POST)
	public void downloadFile(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String fileNameOrig = req.getParameter("file");
		String fileNameNew 	= req.getParameter("file_upload");
		String type = req.getParameter("type_id");
		String folderDest = "/uploads/";
		
		FileCommand cmd = new FileCommand();
		cmd.setNew_name(fileNameNew);
		cmd.setOrig_name(fileNameOrig);
		
		if(type.equals("1")){
			folderDest += "essay/";
		} else {
			folderDest += "revision_upload/";
		}
		
		FileMngUtil fileUtil = new FileMngUtil();
		fileUtil.downloadFile(cmd, folderDest, req, res);
	}
	
	private void cancelUnpaidOrders(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderCommand cmd = new OrderCommand();
		OrderService service = getService();
		service.cancelUnpaidOrder(cmd, req, res);
		
		OrderEssayCommand essay_cmd = new OrderEssayCommand();
		OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
		essay_service.cancelUnpaidOrder(essay_cmd, req, res);
		
		OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
		OrderRevisionService rev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
		rev_service.cancelUnpaidOrder(rev_cmd, req, res);
		
		EtOrderCommand et_cmd = new EtOrderCommand();
		EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
		et_service.cancelUnpaidOrder(et_cmd, req, res);
	}

	private boolean isFromEssaytop(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String essaytop_id = EgovProperties.getProperty("Globals.EssaytopId");
		
		OrderCommand _cmd = getService().getOrderUser(cmd, req, res);
		String user_id = _cmd.getUser_id();
		
		if(user_id.equals(essaytop_id)){
			return true;
		} else {
			return false;
		}
	}
	
	private LoginCommand getUserLogin(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		LoginCommand cmd = (LoginCommand) req.getSession().getAttribute("loginUser");
		
		return cmd;
	}
}