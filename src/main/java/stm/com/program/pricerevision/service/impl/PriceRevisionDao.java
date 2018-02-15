package stm.com.program.pricerevision.service.impl;

import java.util.List;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.pricerevision.web.PriceRevisionCommand;

public interface PriceRevisionDao extends GenericDao<PriceRevisionCommand> {
	
	public List<PriceRevisionCommand> getListOrderByDays(PriceRevisionCommand cmd);
	
	public int getMinimumDays(PriceRevisionCommand cmd);
	
	public int getMinWords(PriceRevisionCommand cmd);
	
	public int updateWords(PriceRevisionCommand cmd);
}
