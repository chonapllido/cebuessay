package stm.com.program.ordcomplete.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;

import stm.com.generic.web.GenericController;
import stm.com.program.ordcomplete.service.OrderCompleteService;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.user.service.UserService;
import stm.com.program.user.web.UserCommand;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/order/complete")
public class OrderCompleteController extends GenericController<OrderCompleteService, OrderCompleteCommand> {

	@Override
	public ModelAndView list(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		ModelAndView mav =  super.list(cmd, req, res);
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		List years = new ArrayList();
		
		for(int i=2008; i<=year; i++){
			years.add(i);
		}
		Collections.reverse(years);
		mav.addObject("years", years);
		
		return mav;
	}
	@Override
	public String deleteList(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {

		String url = super.deleteList(cmd, req, res);
		
		OrderEssayCommand essay_cmd = new OrderEssayCommand();
		essay_cmd.setId_checks(cmd.getId_checks());
		essay_cmd.setIds(cmd.getIds());
		OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
		essay_service.deleteList(essay_cmd, req, res);
		
		OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
		rev_cmd.setId_checks(cmd.getId_checks());
		rev_cmd.setIds(cmd.getIds());
		OrderRevisionService rev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
		rev_service.deleteList(rev_cmd, req, res);
		
		return url;
	}	
	
	@Override
	public String updateList(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String url = super.updateList(cmd, req, res);
		
		OrderEssayCommand essay_cmd = new OrderEssayCommand();
		essay_cmd.setId_checks(cmd.getId_checks());
		essay_cmd.setIds(cmd.getIds());
		essay_cmd.setStatus(cmd.getStatus());
		OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
		essay_service.updateList(essay_cmd, req, res);
		
		OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
		rev_cmd.setId_checks(cmd.getId_checks());
		rev_cmd.setIds(cmd.getIds());
		rev_cmd.setStatus(cmd.getStatus());
		OrderRevisionService rev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
		rev_service.updateList(rev_cmd, req, res);
		
		return url;
		
	}
	
	@RequestMapping(value="/refund.do", method=RequestMethod.POST, produces="text/plain")
	@ResponseBody
	public void refund(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String order_id = req.getParameter("order_id");
		String user_id = req.getParameter("user_id");
		String total = req.getParameter("total");
		
		cmd.setOrder_id(order_id);
		OrderCompleteService service = getService();
		service.refundOrder(cmd, req, res);
		
		UserCommand user_cmd = new UserCommand();
		user_cmd.setUser_id(user_id);
		user_cmd.setVirtual_money(total);
		UserService user_service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		user_service.addVirtualMoney(user_cmd, req, res);
		
	}
	
}