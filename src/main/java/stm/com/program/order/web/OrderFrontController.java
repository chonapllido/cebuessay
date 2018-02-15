package stm.com.program.order.web;

import javax.servlet.http.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.generic.web.GenericController;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.service.OrderService;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;
import stm.com.support.util.ApplicationHelper;
import stm.com.support.util.Functions;

@Controller
@RequestMapping("/front/order")
public class OrderFrontController extends GenericController<OrderService, OrderCommand> {


	@RequestMapping(value="/review.do", method=RequestMethod.GET)
	public ModelAndView review(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/order/review");
		
		return mav;
	}
	
	@RequestMapping(value="/deleteOrder.do", method=RequestMethod.POST)
	public String deleteOrder(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		OrderService service = getService();
		service.updateDelete(cmd, req, res);
		
		if(cmd.getType_id().equals("1")){
			OrderEssayCommand essay_cmd = new OrderEssayCommand();
			essay_cmd.setOrder_id(cmd.getOrder_id());
			OrderEssayService essay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
			essay_service.updateDelete(essay_cmd, req, res);
		} else {
			OrderRevisionCommand rev_cmd = new OrderRevisionCommand();
			rev_cmd.setOrder_id(cmd.getOrder_id());
			OrderRevisionService rev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", req.getSession().getServletContext());
			rev_service.updateDelete(rev_cmd, req, res);
		}
		
		return "redirect:/front/user/mypage.do?"+Functions.getQueryString()+getParams() ;
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
}