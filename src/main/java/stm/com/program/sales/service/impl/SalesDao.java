package stm.com.program.sales.service.impl;

import java.util.List;
import stm.com.generic.service.impl.GenericDao;
import stm.com.program.sales.web.SalesCommand;

public interface SalesDao extends GenericDao<SalesCommand> {

	public List<SalesCommand> getSalesByDate(SalesCommand cmd);
	
	public int getTotalOrdersByMonth(SalesCommand cmd);
	
	public int getTotalPagesByMonth(SalesCommand cmd);
	
	public float getTotalOrderAmount(SalesCommand cmd);
	
	public float getTotalMonthly(SalesCommand cmd);
	
	public int getPagesByMonth(SalesCommand cmd);
	
	public int getTotalOrderByPages(SalesCommand cmd);
	
	public int getTotalOrderByDeadline(SalesCommand cmd);
	
	public float getTotalOrderAmountByYear(SalesCommand cmd);
	
	public float getTotalCashByYear(SalesCommand cmd);
	
	public float getTotalVmByYear(SalesCommand cmd);
}
