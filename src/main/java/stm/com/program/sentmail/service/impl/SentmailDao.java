package stm.com.program.sentmail.service.impl;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.sentmail.web.SentmailCommand;

public interface SentmailDao extends GenericDao<SentmailCommand> {
	
	public int insertList(SentmailCommand cmd);
}
