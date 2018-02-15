package stm.com.program.sales.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.sales.service.SalesService;
import stm.com.program.sales.service.impl.SalesDao;
import stm.com.program.sales.web.SalesCommand;

@Service("salesService")
public class SalesServiceImpl extends GenericServiceImpl<SalesDao, SalesCommand> implements SalesService {

	public SalesCommand getSalesByDate(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		SalesDao dao = getDao();
		cmd.setList(dao.getSalesByDate(cmd));

		return cmd;
	}
	
	public int getTotalOrdersByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalOrdersByMonth(cmd);
	}
	
	public int getTotalPagesByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalPagesByMonth(cmd);
	}
	
	public float getTotalOrderAmount(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalOrderAmount(cmd);
	}
	
	public float getTotalMonthly(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalMonthly(cmd);
	}
	
	public int getPagesByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalPagesByMonth(cmd);	
	}
	
	public int getTotalOrderByPages(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalOrderByPages(cmd);
	}
	
	public int getTotalOrderByDeadline(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalOrderByDeadline(cmd);
	}
	
	public float getTotalOrderAmountByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalOrderAmountByYear(cmd);
	}
	
	public float getTotalCashByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalCashByYear(cmd);
	}
	
	public float getTotalVmByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SalesDao dao = getDao();
		return dao.getTotalVmByYear(cmd);
	}
}
