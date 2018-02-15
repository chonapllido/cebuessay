package stm.com.program.ordcomplete.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.ordcomplete.service.OrderCompleteService;
import stm.com.program.ordcomplete.web.OrderCompleteCommand;

@Service("ordercompleteService")
public class OrderCompleteServiceImpl extends GenericServiceImpl<OrderCompleteDao, OrderCompleteCommand> implements OrderCompleteService {

	public int refundOrder(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		OrderCompleteDao dao = getDao();
		return dao.refundOrder(cmd);
	}
}
