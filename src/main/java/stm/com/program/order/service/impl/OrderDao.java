package stm.com.program.order.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.web.OrderCommand;

public interface OrderDao extends GenericDao<OrderCommand> {
	
	public int isFirstOrder(OrderCommand cmd);
	
	public int updateStatus(OrderCommand cmd);
	
	public int getListByUserCount(OrderCommand cmd);
	
	public List<OrderCommand> getListByUser(OrderCommand cmd);
	
	public List<OrderCommand> getPendingTotalByMonth(OrderCommand cmd);
	
	public int updateManager(OrderCommand cmd);
	
	public int updateWriter(OrderCommand cmd);
	
	public int cancelOrder(OrderCommand cmd);
	
	public int updateDelete(OrderCommand cmd);
	
	public String getTargetTimeToCancel(OrderCommand cmd);
	
	public int cancelUnpaidOrder(OrderCommand cmd);
	
	public OrderCommand getWriterPayment(OrderCommand cmd);
	
	public int getTotalBetweenDate(OrderCommand cmd);
	
	public OrderCommand getOrderUser(OrderCommand cmd);
}
