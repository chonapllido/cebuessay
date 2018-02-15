package stm.com.program.ordcomplete.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.ordcomplete.web.OrderCompleteCommand;

public interface OrderCompleteService extends GenericService<OrderCompleteCommand> {

	public int refundOrder(OrderCompleteCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
