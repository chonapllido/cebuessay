package stm.com.program.etorder.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.etorder.web.EtOrderCommand;

public interface EtOrderService extends GenericService<EtOrderCommand> {
	
	public int updateStatus(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int cancelUnpaidOrder(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateManager(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int updateWriter(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
