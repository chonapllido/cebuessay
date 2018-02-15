package stm.com.program.priceessay.service.impl;

import java.util.List;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.priceessay.web.PriceEssayCommand;

public interface PriceEssayDao extends GenericDao<PriceEssayCommand> {
	
	public int getMinimumDays(PriceEssayCommand cmd);
	
	public int getMinWords(PriceEssayCommand cmd);
	
	public int getMaxDays(PriceEssayCommand cmd);
	
	public int getMaxPage(PriceEssayCommand cmd);
	
	public float getPriceSpecialByDays(int days);
	
	public float getPriceByDays(int days);
	
	public PriceEssayCommand getDefaultPrice(PriceEssayCommand cmd);
	
	public String getDefaultPriceByDays(PriceEssayCommand cmd);
	
	public List<PriceEssayCommand> getListByUser(PriceEssayCommand cmd);
	
	public int updateWords(PriceEssayCommand cmd);

}
