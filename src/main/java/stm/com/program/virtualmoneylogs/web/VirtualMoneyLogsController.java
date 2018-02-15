package stm.com.program.virtualmoneylogs.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import stm.com.generic.web.GenericController;
import stm.com.program.user.service.UserService;
import stm.com.program.user.web.UserCommand;
import stm.com.program.virtualmoneylogs.service.VirtualMoneyLogsService;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/vmlogs")
public class VirtualMoneyLogsController extends GenericController<VirtualMoneyLogsService, VirtualMoneyLogsCommand> {

	@RequestMapping(value="/insertVm.do", method=RequestMethod.POST)
	public String insertLog(VirtualMoneyLogsCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		getService().insert(cmd, req, res);
		
		UserCommand _cmd = new UserCommand();
		_cmd.setUser_id(cmd.getUser_id());
		_cmd.setVirtual_money(req.getParameter("virtual_money"));
		UserService _service = (UserService) ApplicationHelper.getService("userService", req.getSession().getServletContext());
		_service.addVirtualMoney(_cmd, req, res);
		
		return "redirect:/back/user/virtualmoney.do";
	}
		
}