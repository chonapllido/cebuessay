package stm.com.program.order.revision.service.impl;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.order.revision.web.OrderRevisionCommand;

public interface OrderRevisionDao extends GenericDao<OrderRevisionCommand> {
	
	public int updateStatus(OrderRevisionCommand cmd);
	
	public int updateManager(OrderRevisionCommand cmd);
	
	public int updateWriter(OrderRevisionCommand cmd);
	
	public int updateResult(OrderRevisionCommand cmd);
	
	public int updateDelete(OrderRevisionCommand cmd);
	
	public int cancelUnpaidOrder(OrderRevisionCommand cmd);
}
