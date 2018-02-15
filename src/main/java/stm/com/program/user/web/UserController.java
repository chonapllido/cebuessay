package stm.com.program.user.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.support.SessionStatus;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import stm.com.generic.web.GenericController;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;
import stm.com.program.user.service.UserService;
import stm.com.program.virtualmoneylogs.service.VirtualMoneyLogsService;
import stm.com.program.virtualmoneylogs.web.VirtualMoneyLogsCommand;
import stm.com.support.util.ApplicationHelper;
import stm.com.sys.Constants;

@Controller
@RequestMapping("/back/user")
public class UserController extends GenericController<UserService, UserCommand> {
	
	@Autowired
	private EgovPropertyService propertyService;
	
	@Override
	public ModelAndView list(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = super.list(cmd, req, res);
		String user_price = "";
		
		if(req.getParameterMap().containsKey("user_price")){
			cmd.setUser_price(req.getParameter("user_price"));
			user_price = req.getParameter("user_price");
		}
		mav.addObject("user_price", user_price);
		
		if(req.getParameterMap().containsKey("user_total_order")){
			cmd.setUser_total_order(req.getParameter("user_total_order"));
		}
		
		return mav;
	}
	
	@RequestMapping(value="/blacklist.do", method=RequestMethod.POST)
	public String blackList(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		cmd.setUser_id(req.getParameter("user_id"));
		cmd.setBlacklist(req.getParameter("blacklist"));
		
		UserService service = getService();
		service.updateBlacklist(cmd, req, res);
		
		return "redirect:/back/user/list.do";
	}
	
	@RequestMapping(value="/officers/list.do")
	public ModelAndView getOfficers(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/officers/list");
		
		UserService service = getService();
		
		cmd.setPage_use_at(StringUtils.defaultIfEmpty(cmd.getPage_use_at(), "Y"));
		cmd.setPage_count_use_at(StringUtils.defaultIfEmpty(cmd.getPage_count_use_at(), "Y"));

		/** paging setting */
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

		cmd.setFirst_index(paginationInfo.getFirstRecordIndex());
		cmd.setLast_index(paginationInfo.getLastRecordIndex());
		cmd.setRecord_count_per_page(paginationInfo.getRecordCountPerPage());

		mav.addObject(Constants.CMD_VALUE, service.getListOfficersDetail(cmd, req, res));

		paginationInfo.setTotalRecordCount(cmd.getTotal_record_count());
		mav.addObject("paginationInfo", paginationInfo);
		
		return mav;
	}
	
	@RequestMapping(value="/officers/insert.do", method=RequestMethod.GET)
	public ModelAndView insertOfficer(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		ModelAndView mav = super.insert(cmd, req, res);
		mav.setViewName("/back/user/officers/write");
		
		return mav;
	}
	
	@RequestMapping(value="/officers/insert.do", method=RequestMethod.POST)
	public String insertOfficer(UserCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception{
	
		super.insert(cmd, multireq, multireq, res, status, bindingResult);
		
		return "redirect:/back/user/officers/list.do";
	}
	
	@RequestMapping(value="/officers/update.do")
	public ModelAndView updateOfficer(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = super.update(cmd, req, res);
		mav.setViewName("/back/user/officers/write");
		
		return mav;
	}
	
	@RequestMapping(value = "/officers/update.do", method = RequestMethod.POST)
	public String update(UserCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
	
		super.update(cmd, multireq, req, res, status);
		
		return "redirect:/back/user/officers/list.do";
	}
		
	@RequestMapping(value = "/officers/delete.do", method = RequestMethod.POST)
	public String deleteOfficer(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
	
		cmd.setUser_id(req.getParameter("user_id"));
		super.delete(cmd, req, res);
		
		return "redirect:/back/user/officers/list.do";
	}
	
	@RequestMapping(value="/register/figure.do", method=RequestMethod.GET)
	public ModelAndView registerFigureGet(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/register/figure");
	
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		now.set(year, month, 1);
		int week = now.get(Calendar.WEEK_OF_MONTH);
		
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("week", week);

		return mav;
	}
	
	@RequestMapping(value="/register/figure.do", method=RequestMethod.POST)
	public ModelAndView registerFigurePOST(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/register/figure");
	
		Calendar now = Calendar.getInstance();
		int year = Integer.parseInt(req.getParameter("year").toString());
		int month = Integer.parseInt(req.getParameter("month").toString());
		now.set(year, month, 1);
		int week = now.get(Calendar.WEEK_OF_MONTH);
		
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("week", week);

		return mav;
	}
	
	@RequestMapping(value="/register/graph.do")
	public ModelAndView registerGraph(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/register/graph");

		return mav;
	}
	
	@RequestMapping(value="/writers/payment.do")
	public ModelAndView writers(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/writers/payment");

		Calendar cal = Calendar.getInstance();
		mav.addObject("currentYear", cal.get(Calendar.YEAR));
		
		String fromDate = "";
		String toDate = "";
		
		if(req.getParameterMap().containsKey("from_month")){
			String fromYear = req.getParameter("from_year");
			String fromMonth = req.getParameter("from_month");
			String toYear = req.getParameter("to_year");
			String toMonth = req.getParameter("to_month");
			fromDate = fromYear + "-" + fromMonth + "-01";
			toDate = toYear + "-" + toMonth + "-01";
			mav.addObject("toYear", toYear);
			mav.addObject("toMonth", toMonth);
			mav.addObject("fromYear", fromYear);
			mav.addObject("fromMonth", fromMonth);
		} else {
			toDate = cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH)+1) + "-01";
			mav.addObject("toYear", cal.get(Calendar.YEAR));
			mav.addObject("toMonth", (cal.get(Calendar.MONTH)+1));
			
			cal.add(Calendar.MONTH, -2);
			fromDate = cal.get(Calendar.YEAR) + "-" + cal.get(Calendar.MONTH) + "-01";
			mav.addObject("fromYear", cal.get(Calendar.YEAR));
			mav.addObject("fromMonth", cal.get(Calendar.MONTH));
		}
		
		cmd.setPosition_id("2");
		
		UserService service = getService();
		UserCommand user_cmd = service.getListOfficers(cmd, req, res);
		List mylist = user_cmd.getList();
		
		OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		
		for(int i=0;i<mylist.size();i++){
			UserCommand mycmd = (UserCommand)mylist.get(i);
			OrderCommand order = new OrderCommand();
			order.setStart_date(fromDate);
			order.setEnd_date(toDate);
			order.setWriter_id(mycmd.getUser_id());
			OrderCommand new_cmd = order_service.getWriterPayment(order, req, res);
			mycmd.setUser_total_order(new_cmd.getSubtotal());
			mycmd.setUser_total_payment(new_cmd.getTotal_payment());
		}
		
		mav.addObject(Constants.CMD_VALUE, user_cmd);
		
		return mav;
	}
	
	@RequestMapping(value="/writer/updateSalary.do", method=RequestMethod.POST, produces="text/plain")
	@ResponseBody
	public void updateSalary(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String salary = req.getParameter("salary");
		String user_id = req.getParameter("user_id");
		
		UserCommand cmd = new UserCommand();
		cmd.setSalary(salary);
		cmd.setUser_id(user_id);
		
		UserService service = getService();
		service.updateSalary(cmd, req, res);
		
	}
	
	@RequestMapping(value="/writers/productivity.do")
	public ModelAndView productivity(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/writers/productivity");
		int tmp_month;
		int year;
		int workdays = 20;
		if(req.getParameterMap().containsKey("detail_month")){
			tmp_month = Integer.parseInt(req.getParameter("detail_month"));
			year = Integer.parseInt(req.getParameter("detail_year"));
			workdays = Integer.parseInt(req.getParameter("working_days"));
		} else {
			Calendar cal = Calendar.getInstance();
			tmp_month = cal.get(Calendar.MONTH)+1;
			year = cal.get(Calendar.YEAR);
		}
		
		String month = (tmp_month < 10) ? "0"+tmp_month : ""+tmp_month;
		String date = year + "-" + month;
		
		mav.addObject("month", month);
		mav.addObject("year", year);
		mav.addObject("user_id", cmd.getUser_id());
		
		UserCommand writer = getService().getView(cmd, req, res);
		mav.addObject("name", writer.getName());
		
		OrderEssayCommand essay_cmd = new OrderEssayCommand();
		essay_cmd.setWriter_id(cmd.getUser_id());
		essay_cmd.setStart_date(date);
		essay_cmd.setStatus("3");
		OrderEssayService service = (OrderEssayService) ApplicationHelper.getService("orderessayService", req.getSession().getServletContext());
		
		mav.addObject("workdays", workdays);
		mav.addObject(Constants.CMD_VALUE, service.getWriterProductivity(essay_cmd, req, res));
		
		OrderEssayCommand _working_cmd = new OrderEssayCommand();
		_working_cmd.setWriter_id(cmd.getUser_id());
		_working_cmd.setStart_date(date);
		_working_cmd.setStatus("2");
		mav.addObject("cmd_working", service.getWriterProductivity(_working_cmd, req, res));
		
		// get previous month productivity
		int prev_tmp_month = ((tmp_month-1) == 0) ? 12 : tmp_month-1;
		String prev_month = (prev_tmp_month < 10) ? "0"+prev_tmp_month : ""+prev_tmp_month;
		int prev_year = (prev_tmp_month == 12) ? year-1 : year;		
		String prev_date = prev_year + "-" + prev_month;

		OrderEssayCommand _prev_cmd = new OrderEssayCommand();
		_prev_cmd.setWriter_id(cmd.getUser_id());
		_prev_cmd.setStart_date(prev_date);
		mav.addObject("cmd_prev", service.getWriterProductivityAll(_prev_cmd, req, res));

		// get next month productivity
		int next_tmp_month = (tmp_month == 12) ? 1 : tmp_month+1;
		String next_month = (next_tmp_month < 10) ? "0"+next_tmp_month : ""+next_tmp_month;
		int next_year = (next_tmp_month == 1) ? year+1 : year;
		String next_date = next_year + "-" + next_month;
		
		OrderEssayCommand _next_cmd = new OrderEssayCommand();
		_next_cmd.setWriter_id(cmd.getUser_id());
		_next_cmd.setStart_date(next_date);
		mav.addObject("cmd_next", service.getWriterProductivityAll(_next_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/virtualmoney.do")
	public ModelAndView virtualmoney(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/user/virtualmoney");
		
		cmd.setPage_use_at(StringUtils.defaultIfEmpty(cmd.getPage_use_at(), "Y"));
		cmd.setPage_count_use_at(StringUtils.defaultIfEmpty(cmd.getPage_count_use_at(), "Y"));

		/** paging setting */
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

		cmd.setFirst_index(paginationInfo.getFirstRecordIndex());
		cmd.setLast_index(paginationInfo.getLastRecordIndex());
		cmd.setRecord_count_per_page(paginationInfo.getRecordCountPerPage());

		mav.addObject("users", getService().getUserWithVm(cmd, req, res));
		paginationInfo.setTotalRecordCount(cmd.getTotal_record_count());
		mav.addObject("paginationInfo", paginationInfo);
		
		UserCommand _cmd = new UserCommand();
		mav.addObject("active_users", getService().getRecentActiveUsers(_cmd, req, res));
		
		VirtualMoneyLogsCommand log_cmd = new VirtualMoneyLogsCommand();
		VirtualMoneyLogsService log_service = (VirtualMoneyLogsService) ApplicationHelper.getService("virtualmoneylogsService",  req.getSession().getServletContext());
		mav.addObject("vmlogs", log_service.getList(log_cmd, req, res));
		
		return mav;
	}
	
	@RequestMapping(value="/updatevm.do", method=RequestMethod.POST, produces="text/plain")
	@ResponseBody
	public void updateVm(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		if(req.getParameterMap().containsKey("doaction")){
			String doaction = req.getParameter("doaction");
			String user_id = req.getParameter("user_id");
			String amount = req.getParameter("amount");
			
			cmd.setUser_id(user_id);
			cmd.setVirtual_money(amount);
			
			if(doaction.equals("add")){
				getService().addVirtualMoney(cmd, req, res);
			}
			
			if(doaction.equals("minus")){
				getService().minusVirtualMoney(cmd, req, res);
			}
		}
	}
	
	@RequestMapping(value="/calculateVm.do", method=RequestMethod.POST)
	public void getVm(UserCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String user_id = req.getParameter("user_id");
		String date_from = req.getParameter("date_from");
		String date_to = req.getParameter("date_end");
		
		OrderCommand _cmd = new OrderCommand();
		_cmd.setUser_id(user_id);
		_cmd.setStart_date(date_from);
		_cmd.setEnd_date(date_to);
		
		OrderService service = (OrderService) ApplicationHelper.getService("orderService", req.getSession().getServletContext());
		int total = service.getTotalBetweenDate(_cmd, req, res);
		
		double vm = total * (0.05);
		
		res.getWriter().println(vm);
	}
}