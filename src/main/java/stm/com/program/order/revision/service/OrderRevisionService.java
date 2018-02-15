package stm.com.program.order.revision.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.order.essay.service.impl.OrderEssayDao;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.web.OrderRevisionCommand;

public interface OrderRevisionService extends GenericService<OrderRevisionCommand> {

	public int updateStatus(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateManager(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateWriter(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int updateResult(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateDelete(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int cancelUnpaidOrder(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
