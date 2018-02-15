package stm.com.program.order.essay.service.impl;

import java.util.List;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.order.essay.web.OrderEssayCommand;

public interface OrderEssayDao extends GenericDao<OrderEssayCommand> {
	
	public int updateStatus(OrderEssayCommand cmd);
	
	public int updateManager(OrderEssayCommand cmd);
	
	public int updateWriter(OrderEssayCommand cmd);
	
	public int updateResult(OrderEssayCommand cmd);
	
	public int updateDelete(OrderEssayCommand cmd);
	
	public int cancelUnpaidOrder(OrderEssayCommand cmd);
	
	public List<OrderEssayCommand> getTotalOrderByCategory(OrderEssayCommand cmd);
	
	public List<OrderEssayCommand> getWriterProductivity(OrderEssayCommand cmd);
	
	public List<OrderEssayCommand> getWriterProductivityAll(OrderEssayCommand cmd);
}
