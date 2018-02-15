package stm.com.program.order.revision.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;

@Service("orderrevisionService")
public class OrderRevisionServiceImpl extends GenericServiceImpl<OrderRevisionDao, OrderRevisionCommand> implements OrderRevisionService {

	public int updateStatus(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.updateStatus(cmd);
	}
	
	public int updateManager(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.updateManager(cmd);
	}
	
	public int updateWriter(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.updateWriter(cmd);
	}
	
	public int updateResult(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.updateResult(cmd);
	}
	
	public int updateDelete(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.updateDelete(cmd);
	}
	
	public int cancelUnpaidOrder(OrderRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderRevisionDao dao = getDao();
		return dao.cancelUnpaidOrder(cmd);
	}
}
