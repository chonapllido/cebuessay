package stm.com.program.priceresearch.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.priceresearch.web.PriceResearchCommand;
import stm.com.program.priceresearch.service.impl.PriceResearchDao;
import stm.com.program.priceresearch.service.PriceResearchService;

@Service("priceresearchService")
public class PriceResearchServiceImpl extends GenericServiceImpl<PriceResearchDao, PriceResearchCommand> implements PriceResearchService {
	
	public int getMaxPage(PriceResearchCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceResearchDao dao = getDao();
		return dao.getMaxPage(cmd);
	}
}
