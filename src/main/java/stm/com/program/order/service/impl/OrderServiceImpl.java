package stm.com.program.order.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.order.essay.service.impl.OrderEssayDao;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.impl.OrderRevisionDao;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;

@Service("orderService")
public class OrderServiceImpl extends GenericServiceImpl<OrderDao, OrderCommand> implements OrderService {

	public int isFirstOrder(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.isFirstOrder(cmd);
	}
	
	public int updateStatus(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.updateStatus(cmd);
	}
	
	public int getListByUserCount(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();	
		return dao.getListByUserCount(cmd);
	}
	
	public OrderCommand getListByUser(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();	
		cmd.setList(dao.getListByUser(cmd));
		cmd.setTotal_record_count(cmd.getList().size());
		
		return cmd;
	}
	
	public OrderCommand getPendingTotalByMonth(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();	
		cmd.setList(dao.getPendingTotalByMonth(cmd));
		cmd.setTotal_record_count(cmd.getList().size());
		
		return cmd;
	}
	
	public int updateManager(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.updateManager(cmd);
	}
	
	public int updateWriter(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.updateWriter(cmd);
	}
	
	public int cancelOrder(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.cancelOrder(cmd);
	}
	
	public int updateDelete(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.updateDelete(cmd);
	}
	
	public String getTargetTimeToCancel(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.getTargetTimeToCancel(cmd);
	}
	
	public int cancelUnpaidOrder(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.cancelUnpaidOrder(cmd);
	}
	
	public OrderCommand getWriterPayment(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.getWriterPayment(cmd);
	}
	
	public OrderCommand getOrderUser(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.getOrderUser(cmd);
	}
	
	public int getTotalBetweenDate(OrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderDao dao = getDao();
		return dao.getTotalBetweenDate(cmd);
	}
}
