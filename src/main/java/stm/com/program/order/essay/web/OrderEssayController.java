package stm.com.program.order.essay.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import stm.com.generic.web.GenericController;
import stm.com.program.category.service.CategoryService;
import stm.com.program.category.web.CategoryCommand;
import stm.com.program.level.service.LevelService;
import stm.com.program.level.web.LevelCommand;
import stm.com.program.login.web.LoginCommand;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;
import stm.com.program.priceessay.service.PriceEssayService;
import stm.com.program.priceessay.web.PriceEssayCommand;
import stm.com.program.readmaterial.service.ReadMaterialService;
import stm.com.program.readmaterial.web.ReadMaterialCommand;
import stm.com.program.writingformat.service.WritingFormatService;
import stm.com.program.writingformat.web.WritingFormatCommand;
import stm.com.support.fileio.FileMngUtil;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/order/essay")
public class OrderEssayController extends GenericController<OrderEssayService, OrderEssayCommand> {

	@Override
	public ModelAndView view(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
	
		LoginCommand login_cmd = getUserLogin(req, res);
		if (login_cmd == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/front/main.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		ModelAndView mav = super.view(cmd, req, res);
		
		OrderEssayService service = getService();
		OrderEssayCommand order_cmd = service.getView(cmd, req, res);
		
		DateFormat format = new SimpleDateFormat("y-M-d H:m:s");
		Date now = format.parse(order_cmd.getStart_date());
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, Integer.parseInt(order_cmd.getDays()));
		Date deadline = c.getTime();
		mav.addObject("deadline", deadline);
		
		OrderCommand o_cmd = new OrderCommand();
		o_cmd.setOrder_id(cmd.getOrder_id());
		
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		String cancelTime = order_service.getTargetTimeToCancel(o_cmd, req, res);
		
		if(cancelTime == null){
			cancelTime = "";
		}
		mav.addObject("cancelTime", cancelTime.replace("-", "/"));
		
		return mav;
	}
	
	@Override
	public ModelAndView update(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {

		LoginCommand login_cmd = getUserLogin(req, res);
		if (login_cmd == null) {
			ModelAndView modelAndView = new ModelAndView("redirect:/front/main.do");
			throw new ModelAndViewDefiningException(modelAndView);
		}
		
		ModelAndView mav = super.update(cmd, req, res);
	
		OrderEssayService service = getService();
		OrderEssayCommand new_cmd = service.getView(cmd, req, res);
		String default_days =new_cmd.getDays(); //default deadline
		
		CategoryCommand category_cmd = new CategoryCommand();
		CategoryService category_service = (CategoryService) ApplicationHelper.getService("categoryService", req.getSession().getServletContext());
		mav.addObject("category_list", category_service.getList(category_cmd, req, res));
		
		WritingFormatCommand format_cmd = new WritingFormatCommand();
		WritingFormatService format_service = (WritingFormatService) ApplicationHelper.getService("writingformatService", req.getSession().getServletContext());
		mav.addObject("format_list", format_service.getList(format_cmd, req, res));
		
		LevelCommand level_cmd = new LevelCommand();
		LevelService level_service = (LevelService) ApplicationHelper.getService("levelService", req.getSession().getServletContext());
		mav.addObject("level_list", level_service.getList(level_cmd, req, res));
		
		PriceEssayCommand price_cmd = new PriceEssayCommand();
		PriceEssayService price_service = (PriceEssayService) ApplicationHelper.getService("priceessayService", req.getSession().getServletContext());
		price_cmd.setDays(default_days);
		int temp_maxpage = price_service.getMaxPage(price_cmd, req, res);
		int maxpage = (temp_maxpage == 0) ? 40 : temp_maxpage;
		int min_days = price_service.getMinimumDays(price_cmd, req, res);
		
		mav.addObject("maxpage", maxpage);
		mav.addObject("words", price_service.getMinWords(price_cmd, req, res));
		mav.addObject("min_days", min_days);
		
		String pages = "0", price = "0", free_pages = "0", has_free = "0";
		ReadMaterialCommand material_cmd = new ReadMaterialCommand();
		ReadMaterialService material_service = (ReadMaterialService) ApplicationHelper.getService("readmaterialService", req.getSession().getServletContext());
		ReadMaterialCommand new_material_cmd = material_service.getList(material_cmd, req, res);
		
		List<ReadMaterialCommand> myList = (List<ReadMaterialCommand>) new_material_cmd.getList();
		
		for(int i=0; i<myList.size(); i++){
			ReadMaterialCommand myCmd = (ReadMaterialCommand) myList.get(i);
			
			if(myCmd.getPrice().equals("0")){
				free_pages = myCmd.getPages();
				has_free = "1";
			}
			if(myCmd.getDays().equals(default_days)){
				pages = myCmd.getPages();
				price = myCmd.getPrice();
			}
		}
		
		if(pages == "0"){
			ReadMaterialCommand myCurCmd = (ReadMaterialCommand) myList.get(myList.size()-1);
			pages = myCurCmd.getPages();
			price = myCurCmd.getPrice();
		}
		
		mav.addObject("has_free", has_free);
		mav.addObject("free_pages", free_pages);
		mav.addObject("pages", pages);
		mav.addObject("price", price);
		
		OrderCommand order_cmd = new OrderCommand();
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		order_cmd.setUser_id(login_cmd.getUser_id());
		order_cmd.setUser_email(login_cmd.getEmail());
		int hasorder = order_service.isFirstOrder(order_cmd, req, res);
		mav.addObject("hasorder", hasorder-1);
		
		// Set deadline of order
		DateFormat format = new SimpleDateFormat("y-M-d H:m:s");
		Date now = format.parse(new_cmd.getStart_date());
		Calendar c = Calendar.getInstance();
		c.setTime(now);
		c.add(Calendar.DATE, Integer.parseInt(default_days));
		Date deadline = c.getTime();
		mav.addObject("deadline", deadline);
		
		// get default price 
		PriceEssayCommand default_price_cmd = new PriceEssayCommand();
		default_price_cmd.setSpecial(login_cmd.getUser_price());
		PriceEssayCommand default_price = price_service.getDefaultPrice(default_price_cmd, req, res);
		
		mav.addObject("default_days", default_price.getDays());
		mav.addObject("default_price", default_price.getPrice());
		
		return mav;
	}
	
	@Override
	public String update(OrderEssayCommand  cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);

		OrderEssayService service = getService();

		if (isProtectSubmit(req, null)) {

			HashMap<String, String> _result = new HashMap<String, String>(); 
			
			FileMngUtil fileUtil = new FileMngUtil();
			Map<String, MultipartFile> files = multireq.getFileMap();
			
			if (!files.isEmpty()) {
				_result = fileUtil.parseFileInf(files, "/uploads/essay/");
				cmd.setFile(_result.get("originFileNameList"));
				cmd.setFile_upload(_result.get("newFileNameList"));
			} 

			if(req.getParameterMap().containsKey("etc_format")){
				if(!req.getParameter("etc_format").equals("")){
					cmd.setFormat(req.getParameter("etc_format"));
				}
			}
			cmd.setRead_material(req.getParameter("materials_text"));
			service.update(cmd, req, res);
			
			OrderCommand order_cmd = new OrderCommand();
			order_cmd.setOrder_id(cmd.getOrder_id());
			order_cmd.setTotal_payment(cmd.getTotal_payment());
			order_cmd.setEnd_date(cmd.getEnd_date());
			
			OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
			order_service.update(order_cmd, req, res);
		}

		postControl(cmd, req, res, null);
		return "redirect:/back/order/essay/confirm.do";
	}
	
	@RequestMapping(value="/confirm.do", method=RequestMethod.GET)
	public ModelAndView confirm(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/order/essay/confirm");
		
		return mav;
	}
	
	private LoginCommand getUserLogin(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		LoginCommand cmd = (LoginCommand) req.getSession().getAttribute("loginUser");
		
		return cmd;
	}
}