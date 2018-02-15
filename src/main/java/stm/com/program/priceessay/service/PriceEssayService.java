package stm.com.program.priceessay.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.priceessay.web.PriceEssayCommand;

public interface PriceEssayService extends GenericService<PriceEssayCommand> {
	
	public int getMinimumDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int getMinWords(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getMaxDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getMaxPage(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public float getPriceSpecialByDays(int days, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public float getPriceByDays(int days, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public PriceEssayCommand getDefaultPrice(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public String getDefaultPriceByDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public List<PriceEssayCommand> getListByUser(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateWords(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
