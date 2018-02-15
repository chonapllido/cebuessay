package stm.com.program.sentmail.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.sentmail.service.SentmailService;
import stm.com.program.sentmail.web.SentmailCommand;

@Service("sentmailService")
public class SentmailServiceImpl extends GenericServiceImpl<SentmailDao, SentmailCommand> implements SentmailService {

	public int insertList(SentmailCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		SentmailDao dao = getDao();
		return dao.insertList(cmd);
	}
}
