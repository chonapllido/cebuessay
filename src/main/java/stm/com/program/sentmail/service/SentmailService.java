package stm.com.program.sentmail.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.sentmail.web.SentmailCommand;

public interface SentmailService extends GenericService<SentmailCommand> {
	
	public int insertList(SentmailCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
}
