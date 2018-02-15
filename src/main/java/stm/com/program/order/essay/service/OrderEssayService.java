package stm.com.program.order.essay.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.order.essay.web.OrderEssayCommand;

public interface OrderEssayService extends GenericService<OrderEssayCommand> {

	public int updateStatus(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateManager(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int updateWriter(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateResult(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int updateDelete(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int cancelUnpaidOrder(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public OrderEssayCommand getTotalOrderByCategory(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public OrderEssayCommand getWriterProductivity(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public OrderEssayCommand getWriterProductivityAll(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
