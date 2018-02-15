package stm.com.program.etorder.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.etorder.service.EtOrderService;
import stm.com.program.etorder.web.EtOrderCommand;
import stm.com.program.order.essay.service.impl.OrderEssayDao;
import stm.com.program.order.essay.web.OrderEssayCommand;

@Service("etorderService")
public class EtOrderServiceImpl extends GenericServiceImpl<EtOrderDao, EtOrderCommand> implements EtOrderService {

	public int updateStatus(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		 EtOrderDao dao = getDao();
		 return dao.updateStatus(cmd);
	}
	
	public int cancelUnpaidOrder(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		 EtOrderDao dao = getDao();
		 return dao.cancelUnpaidOrder(cmd);
	}
	
	public int updateManager(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		EtOrderDao dao = getDao();
		return dao.updateManager(cmd);
	}
	
	public int updateWriter(EtOrderCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		EtOrderDao dao = getDao();
		return dao.updateWriter(cmd);
	}

}
