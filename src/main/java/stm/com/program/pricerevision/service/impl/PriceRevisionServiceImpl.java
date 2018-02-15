package stm.com.program.pricerevision.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.pricerevision.service.impl.PriceRevisionDao;
import stm.com.program.pricerevision.service.PriceRevisionService;
import stm.com.program.pricerevision.web.PriceRevisionCommand;

@Service("pricerevisionService")
public class PriceRevisionServiceImpl extends GenericServiceImpl<PriceRevisionDao, PriceRevisionCommand> implements PriceRevisionService {
	
	public PriceRevisionCommand getListOrderByDays(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceRevisionDao dao = getDao();
		cmd.setList(dao.getListOrderByDays(cmd));
		
		return cmd;		
	}
	
	public int getMinimumDays(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceRevisionDao dao = getDao();
		return dao.getMinimumDays(cmd);
	}
	
	public int getMinWords(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceRevisionDao dao = getDao();
		return dao.getMinWords(cmd);
	}
	
	public int updateWords(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceRevisionDao dao = getDao();
		return dao.updateWords(cmd);
	}
}
