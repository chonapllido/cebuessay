package stm.com.program.priceresearch.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.priceresearch.web.PriceResearchCommand;

public interface PriceResearchService extends GenericService<PriceResearchCommand> {
	
	public int getMaxPage(PriceResearchCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
