package stm.com.program.order.revision.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.com.cmm.service.EgovProperties;
import stm.com.generic.web.GenericController;
import stm.com.program.level.service.LevelService;
import stm.com.program.level.web.LevelCommand;
import stm.com.program.login.web.LoginCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;
import stm.com.program.pricerevision.service.PriceRevisionService;
import stm.com.program.pricerevision.web.PriceRevisionCommand;
import stm.com.support.fileio.FileMngUtil;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/order/revision")
public class OrderRevisionController extends GenericController<OrderRevisionService, OrderRevisionCommand> {

	@Override
	public ModelAndView view(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		ModelAndView mav = super.view(cmd, req, res);
		
		OrderRevisionService service = getService();
		OrderRevisionCommand order_cmd = service.getView(cmd, req, res);
		String default_days = order_cmd.getDays();
		
		OrderCommand o_cmd = new OrderCommand();
		o_cmd.setOrder_id(cmd.getOrder_id());
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		String cancelTime = order_service.getTargetTimeToCancel(o_cmd, req, res);
		
		DateFormat format = new SimpleDateFormat("y-M-d H:m:s");
		Date now = format.parse(order_cmd.getStart_date());
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, Integer.parseInt(default_days));
		Date deadline = c.getTime();
		mav.addObject("deadline", deadline);
		
		if(cancelTime == null){
			cancelTime = "";
		}
		mav.addObject("cancelTime", cancelTime.replace("-", "/"));
		
		String dir = EgovProperties.getProperty("Globals.orderFilesPath") + "/uploads/revision/"+order_cmd.getFile();
		String data = new Scanner(new File(dir)).useDelimiter("\\A").next();
		mav.addObject("content", data);
		
		return mav;
	}
	
	@Override
	public ModelAndView update(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
	
		LoginCommand login_cmd = getUserLogin(req, res);
		if (login_cmd == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/front/main.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		ModelAndView mav = super.update(cmd, req, res);
		
		OrderRevisionService service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
		OrderRevisionCommand new_cmd = service.getView(cmd, req, res);
		String default_days = new_cmd.getDays(); //default deadline
		
		LevelCommand level_cmd = new LevelCommand();
		LevelService level_service = (LevelService) ApplicationHelper.getService("levelService", req.getSession().getServletContext());
		mav.addObject("level_list", level_service.getList(level_cmd, req, res));
		
		PriceRevisionCommand price_cmd = new PriceRevisionCommand();
		PriceRevisionService price_service = (PriceRevisionService) ApplicationHelper.getService("pricerevisionService", req.getSession().getServletContext());
		price_cmd.setDays(default_days);
		mav.addObject("min_days", price_service.getMinimumDays(price_cmd, req, res));
		mav.addObject("words", price_service.getMinWords(price_cmd, req, res));
		
		PriceRevisionCommand price_list_cmd = price_service.getListOrderByDays(price_cmd, req, res);
		String prices = "";
		
		DateFormat format = new SimpleDateFormat("y-M-d H:m:s");
		Date now = format.parse(new_cmd.getStart_date());
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, Integer.parseInt(default_days));
		Date deadline = c.getTime();
		
		mav.addObject("deadline", deadline);
		
		for(Object pcmd: price_list_cmd.getList()){
			PriceRevisionCommand prev_cmd = (PriceRevisionCommand) pcmd;
			if(!prices.equals("")){
				prices += ",";
			}
			prices += prev_cmd.getDays() + "-" + prev_cmd.getPrice();	
		}
		
		mav.addObject("prices", prices);
		
		OrderCommand order_cmd = new OrderCommand();
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		order_cmd.setUser_id(login_cmd.getUser_id());
		order_cmd.setUser_email(login_cmd.getEmail());
		int hasorder = (order_service.isFirstOrder(order_cmd, req, res) > 0) ? 1:0;
		mav.addObject("hasorder", hasorder);
		
		if(cmd.getTotal_payment() == "" || cmd.getTotal_payment() == null) cmd.setTotal_payment("0");
		
		String content = (req.getParameterMap().containsKey("content")) ? req.getParameter("content") : "";
		String no_words = (req.getParameterMap().containsKey("no_words")) ? req.getParameter("no_words") : "0";
		mav.addObject("content", content);
		mav.addObject("no_words", no_words);
	
		String dir = EgovProperties.getProperty("Globals.orderFilesPath") + "/uploads/revision/"+new_cmd.getFile();
		String data = new Scanner(new File(dir)).useDelimiter("\\A").next();
		mav.addObject("content", data);
		
		return mav;
	}
	
	@Override
	public String update(OrderRevisionCommand  cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);

		OrderRevisionService service = getService();
		if (isProtectSubmit(req, null)) {

			HashMap<String, String> _result = new HashMap<String, String>(); 
			
			FileMngUtil fileUtil = new FileMngUtil();
			Map<String, MultipartFile> files = multireq.getFileMap();
			
			if (!files.isEmpty()) {
				_result = fileUtil.parseFileInf(files, "/uploads/revision_upload/");
				cmd.setFile_upload(_result.get("originFileNameList"));
				cmd.setFile_upload_tmp(_result.get("newFileNameList"));
			} 
			
			fileUtil.editFile(req.getParameter("content"), "/uploads/revision/", cmd.getFile());
			service.update(cmd, req, res);
			
			OrderCommand order_cmd = new OrderCommand();
			order_cmd.setOrder_id(cmd.getOrder_id());
			order_cmd.setTotal_payment(cmd.getTotal_payment());
			order_cmd.setEnd_date(cmd.getEnd_date());
			
			OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
			order_service.update(order_cmd, req, res);
		}

		postControl(cmd, req, res, null);
		return "redirect:/back/order/revision/confirm.do";
	}
	
	@RequestMapping(value="/confirm.do", method=RequestMethod.GET)
	public ModelAndView confirm(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/order/essay/confirm");
		
		return mav;
	}
	
	private LoginCommand getUserLogin(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		LoginCommand cmd = (LoginCommand) req.getSession().getAttribute("loginUser");
		
		return cmd;
	}
}