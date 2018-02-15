package stm.com.program.pricerevision.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.pricerevision.web.PriceRevisionCommand;

public interface PriceRevisionService extends GenericService<PriceRevisionCommand> {
	
	public PriceRevisionCommand getListOrderByDays(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int getMinimumDays(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int getMinWords(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateWords(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

}
