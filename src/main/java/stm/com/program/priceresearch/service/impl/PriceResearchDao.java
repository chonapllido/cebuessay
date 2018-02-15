package stm.com.program.priceresearch.service.impl;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.priceresearch.web.PriceResearchCommand;

public interface PriceResearchDao extends GenericDao<PriceResearchCommand> {
	
	public int getMaxPage(PriceResearchCommand cmd);

}
