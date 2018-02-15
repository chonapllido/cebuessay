package stm.com.program.sales.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import stm.com.generic.web.GenericController;
import stm.com.program.sales.service.SalesService;
import stm.com.sys.Constants;

@Controller
@RequestMapping("/back/sales")
public class SalesController extends GenericController<SalesService, SalesCommand> {

	@RequestMapping(value="/figure.do", method=RequestMethod.GET)
	public ModelAndView salesFigureGet(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sales/figure");
	
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		now.set(year, month, 1);
		int week = now.get(Calendar.WEEK_OF_MONTH);
		
		String my_month = Integer.toString(month+1);
		my_month = (my_month.length() == 1) ? "0"+my_month : my_month;
		SalesService service = getService();
		SalesCommand page_cmd = new SalesCommand();
		String date = year+"-"+my_month;

		page_cmd.setDate(date);
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("week", week);
		mav.addObject("total_pages", service.getTotalPagesByMonth(page_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/figure.do", method=RequestMethod.POST)
	public ModelAndView salesFigurePost(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sales/figure");
	
		Calendar now = Calendar.getInstance();
		int year = Integer.parseInt(req.getParameter("year").toString());
		int month = Integer.parseInt(req.getParameter("month").toString());
		now.set(year, month, 1);
		int week = now.get(Calendar.WEEK_OF_MONTH);
		
		String my_month = Integer.toString(month+1);
		my_month = (my_month.length() == 1) ? "0"+my_month : my_month;
		SalesService service = getService();
		SalesCommand page_cmd = new SalesCommand();
		String date = year+"-"+my_month;

		page_cmd.setDate(date);
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("week", week);
		mav.addObject("total_pages", service.getTotalPagesByMonth(page_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/graph.do")
	public ModelAndView salesGraphGet(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/sales/graph");
		String user_email = "";
		
		if(cmd.getSearch_keyword() != null){
			user_email = cmd.getSearch_keyword();
		}
		System.out.println("user email: "+cmd.getSearch_keyword());
		mav.addObject(Constants.CMD_VALUE, cmd);
		mav.addObject("user_email", user_email);
		return mav;
	}
	
}