package stm.com.program.etorder.service.impl;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.etorder.web.EtOrderCommand;

public interface EtOrderDao extends GenericDao<EtOrderCommand> {
	
	public int updateStatus(EtOrderCommand cmd);
	
	public int cancelUnpaidOrder(EtOrderCommand cmd);
	
	public int updateManager(EtOrderCommand cmd);
	
	public int updateWriter(EtOrderCommand cmd);
}
