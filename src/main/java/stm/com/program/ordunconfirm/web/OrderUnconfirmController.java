package stm.com.program.ordunconfirm.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import stm.com.generic.web.GenericController;
import stm.com.program.etorder.service.EtOrderService;
import stm.com.program.etorder.web.EtOrderCommand;
import stm.com.program.ordcomplete.web.OrderCompleteCommand;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.ordunconfirm.service.OrderUnconfirmService;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/order/unconfirmed")
public class OrderUnconfirmController extends GenericController<OrderUnconfirmService, OrderUnconfirmCommand> {

	@Override
	public String deleteList(OrderUnconfirmCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {

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
	public String updateList(OrderUnconfirmCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
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
		
		// update essaytop
		EtOrderCommand et_cmd = new EtOrderCommand();
		et_cmd.setId_checks(cmd.getId_checks());
		et_cmd.setIds(cmd.getIds());
		et_cmd.setStatus(cmd.getStatus());
		EtOrderService et_service = (EtOrderService) ApplicationHelper.getService("etorderService", req.getSession().getServletContext());
		et_service.updateList(et_cmd, req, res);
		
		return url;
		
	}
}