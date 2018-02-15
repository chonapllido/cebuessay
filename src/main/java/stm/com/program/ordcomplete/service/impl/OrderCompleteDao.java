package stm.com.program.ordcomplete.service.impl;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.ordcomplete.web.OrderCompleteCommand;
import stm.com.program.order.essay.web.OrderEssayCommand;

public interface OrderCompleteDao extends GenericDao<OrderCompleteCommand> {
	
	public int refundOrder(OrderCompleteCommand cmd);
	
}
