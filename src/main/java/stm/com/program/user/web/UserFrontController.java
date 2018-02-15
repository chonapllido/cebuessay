package stm.com.program.user.web;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import stm.com.generic.web.GenericController;
import stm.com.program.login.web.LoginCommand;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;
import stm.com.program.user.service.UserService;
import stm.com.support.mail.MailCommand;
import stm.com.support.mail.MailController;
import stm.com.support.util.ApplicationHelper;
import stm.com.sys.Constants;


@Controller
@RequestMapping("/front/user")
public class UserFrontController extends GenericController<UserService, UserCommand> {

	@Autowired
	private EgovPropertyService propertyService;
	
	private MailController mailUtil = new MailController();
	
	@RequestMapping(value="/idcheck.do", method = RequestMethod.GET)
	public ModelAndView idcheck(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		String email = req.getParameter("email");
		String userid = req.getParameter("userid");
		
		UserCommand usercmd = new UserCommand();
		usercmd.setEmail(email);
		usercmd.setUser_id(userid);
		
		int usedCnt;
	
		if (email == null || email.equals("")) {
			usedCnt = -1;
		} else {
			UserService userService = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
			usedCnt = userService.checkEmailDuplicate(usercmd, req, res);
		}

		mav.addObject("usedCnt", usedCnt);
		mav.addObject("checkId", email);
		mav.addObject("userId", userid);
		mav.setViewName("/front/user/idcheck");
	
		return mav;
	}
	
	@RequestMapping(value = "/idcheck.do", method = RequestMethod.POST)
	public ModelAndView checkIdDplct(HttpServletRequest req, HttpServletResponse res) throws Exception {

		ModelAndView mav = new ModelAndView();
		String email = (String) req.getParameter("checkId");
		String userid = (String) req.getParameter("userId");
		
		UserCommand cmd = new UserCommand();
		cmd.setEmail(email);
		cmd.setUser_id(userid);
		
		int usedCnt;

		if (email == null || email.equals("")) {
			usedCnt = -1;
		} else {
			UserService userService = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
			usedCnt = userService.checkEmailDuplicate(cmd, req, res);
		}
		
		mav.setViewName("/front/user/idcheck");
		mav.addObject("checkId", email);
		mav.addObject("userId", userid);
		mav.addObject("usedCnt", usedCnt);

		return mav;
	}
	
	@Override
	public String insert(UserCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {
		super.insert(cmd, multireq, req, res, status, bindingResult);
		
		String url = myLogin(cmd, req, res);
				
		return "redirect:"+url;
	}
	
	@Override
	public String update(UserCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		super.update(cmd, multireq, req, res, status);
		
		String url = myLogin(cmd, req, res);
		return "redirect:"+url;
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String doLogin(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String url = this.myLogin(cmd, req, res);
		
		return "redirect:"+url;
	}

	public String myLogin(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		String url = "/front/main.do";
		
		UserService service = getService();
		UserCommand user = service.getLogin(cmd, req, res);
		
		if (user == null) {
			url = url + "?loginFail=Y"; 
			return url;
		}
		
		LoginCommand loginUser = new LoginCommand();
		loginUser.setEmail(user.getEmail());
		loginUser.setUser_id(user.getUser_id());
		loginUser.setName(user.getName());
		loginUser.setPosition_id(user.getPosition_id());
		loginUser.setBlacklist(user.getBlacklist());
		loginUser.setUser_price(user.getUser_price());
		
		req.getSession().setAttribute("loginUser", loginUser);
		
		return url;
	}
	
	@RequestMapping(value="/logout.do")
	public String doLogout(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		req.getSession().setAttribute("loginUser", null);
		return "redirect:/front/main.do";
	}
	
	@RequestMapping(value="/withdraw.do")
	public String withdraw(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String email = req.getParameter("email");
		String user_id = req.getParameter("user_id");
		
		UserCommand cmd = new UserCommand();
		cmd.setEmail(email);
		cmd.setUser_id(user_id);
		
		UserService service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		service.delete(cmd, req, res);
		
		req.getSession().setAttribute("loginUser", null);
		return "redirect:/front/main.do";
	}
	
	@RequestMapping(value="/mypage.do")
	public ModelAndView mypage(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/user/mypage");
		
		LoginCommand login_cmd = getUserLogin(req, res);
		if (login_cmd == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/front/main.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		cmd.setUser_id(login_cmd.getUser_id());
		cmd.setTotal_record_count(order_service.getListByUserCount(cmd, req, res));
		
		/** cancel unpaid orders **/
		cancelUnpaidOrders(req, res);
		
		/** paging setting */
		cmd.setPage_use_at("Y");
		if (cmd.getCurrent_page_no() <= 0) {
			cmd.setCurrent_page_no(1);
		}
		if (cmd.getRecord_count_per_page() <= 0) {
			cmd.setRecord_count_per_page(propertyService.getInt("pageUnit"));
		}
		if (cmd.getPage_size() <= 0) {
			cmd.setPage_size(propertyService.getInt("pageSize"));
		}

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(cmd.getCurrent_page_no());
		paginationInfo.setRecordCountPerPage(cmd.getRecord_count_per_page());
		paginationInfo.setPageSize(cmd.getPage_size());
		paginationInfo.setTotalRecordCount(cmd.getTotal_record_count());
		cmd.setFirst_index(paginationInfo.getFirstRecordIndex());
		cmd.setLast_index(paginationInfo.getLastRecordIndex());
		cmd.setRecord_count_per_page(paginationInfo.getRecordCountPerPage());
		
		UserCommand user_cmd = new UserCommand();
		user_cmd.setUser_id(login_cmd.getUser_id());
		UserService service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
	
		mav.addObject(Constants.CMD_VALUE, order_service.getListByUser(cmd, req, res));
		mav.addObject("virtual_money", service.getUserVm(user_cmd, req, res).getVirtual_money());
		mav.addObject("paginationInfo", paginationInfo);
		
		return mav;
		
	}
	
	@RequestMapping(value="/forgot_password.do", method=RequestMethod.GET)
	public ModelAndView forgotpwd(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/user/forgot_password");
		
		return mav;
	}
	
	@RequestMapping(value="/forgot_password.do", method=RequestMethod.POST)
	public ModelAndView forgotpwdPost(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/user/forgot_password_msg");
		
		UserCommand login = getService().getPassword(cmd, req, res);
		String password = login.getPassword();
		String found = "no";

		if(password != null && !password.isEmpty()){
			MailCommand mail = new MailCommand();
			mail.setFromName("CebuEssay");
			mail.setSendFrom("cebuessay@gmail.com");
			mail.setSendTo(cmd.getEmail());
			mail.setSubject("CebuEssay Password");

			String message = "Your CebuEssay password is:\n\n"+password+"\n\n";
			message += "Best Regards,\nCebuEssay";
			mail.setMessage(message);
			mailUtil.sendMail(mail);

			found = "yes";
		}
		mav.addObject("found", found);
		
		return mav;
	}
	@RequestMapping(value="/tutorial.do", method=RequestMethod.GET)
	public ModelAndView tutorial(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/user/tutorial");
		
		return mav;
	}
	
	private LoginCommand getUserLogin(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		LoginCommand cmd = (LoginCommand) req.getSession().getAttribute("loginUser");
		
		return cmd;
	}
	
	private void cancelUnpaidOrders(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderCommand cmd = new OrderCommand();
		OrderService service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		service.cancelUnpaidOrder(cmd, req, res);
		
		OrderEssayCommand essay_cmd = new OrderEssayCommand();
		OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
		essay_service.cancelUnpaidOrder(essay_cmd, req, res);
		
		OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
		OrderRevisionService rev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
		rev_service.cancelUnpaidOrder(rev_cmd, req, res);
	}
}