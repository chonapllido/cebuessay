package stm.com.program.sales.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.sales.web.SalesCommand;

public interface SalesService extends GenericService<SalesCommand> {
	
	public SalesCommand getSalesByDate(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getTotalOrdersByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getTotalPagesByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public float getTotalOrderAmount(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public float getTotalMonthly(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int getPagesByMonth(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int getTotalOrderByPages(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getTotalOrderByDeadline(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public float getTotalOrderAmountByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public float getTotalCashByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public float getTotalVmByYear(SalesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
}
