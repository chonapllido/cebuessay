package stm.com.program.order.essay.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;

@Service("orderessayService")
public class OrderEssayServiceImpl extends GenericServiceImpl<OrderEssayDao, OrderEssayCommand> implements OrderEssayService {

	public int updateStatus(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.updateStatus(cmd);
	}
	
	public int updateManager(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.updateManager(cmd);
	}
	
	public int updateWriter(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.updateWriter(cmd);
	}

	public int updateResult(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.updateResult(cmd);
	}
	
	public int updateDelete(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.updateDelete(cmd);
	}
	
	public int cancelUnpaidOrder(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		return dao.cancelUnpaidOrder(cmd);
	}
	
	public OrderEssayCommand getTotalOrderByCategory(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		cmd.setList(dao.getTotalOrderByCategory(cmd));
		
		return cmd;
	}
	
	public OrderEssayCommand getWriterProductivity(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		cmd.setList(dao.getWriterProductivity(cmd));
		
		return cmd;
	}
	
	public OrderEssayCommand getWriterProductivityAll(OrderEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderEssayDao dao = getDao();
		cmd.setList(dao.getWriterProductivityAll(cmd));
		
		return cmd;
	}

}
