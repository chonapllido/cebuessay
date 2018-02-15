package stm.com.program.priceessay.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.order.service.impl.OrderDao;
import stm.com.program.priceessay.service.PriceEssayService;
import stm.com.program.priceessay.web.PriceEssayCommand;

@Service("priceessayService")
public class PriceEssayServiceImpl extends GenericServiceImpl<PriceEssayDao, PriceEssayCommand> implements PriceEssayService {

	public int getMinimumDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getMinimumDays(cmd);
	}
	
	public int getMinWords(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getMinWords(cmd);
	}
	
	public int getMaxDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getMaxDays(cmd);
	}
	
	public int getMaxPage(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getMaxPage(cmd);
	}
	
	public float getPriceSpecialByDays(int days, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getPriceSpecialByDays(days);
	}
	
	public float getPriceByDays(int days, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getPriceByDays(days);
	}
	
	public PriceEssayCommand getDefaultPrice(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getDefaultPrice(cmd);
	}
	
	public String getDefaultPriceByDays(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		int maxdays = getMaxDays(cmd, req, res);
		int workdays = Integer.parseInt(cmd.getDays());
		
		if(workdays > maxdays ){
			cmd.setDays(maxdays+"");
		}
		
		return dao.getDefaultPriceByDays(cmd);
	}
	
	public List<PriceEssayCommand> getListByUser(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.getListByUser(cmd);
	}
	
	public int updateWords(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		PriceEssayDao dao = getDao();
		return dao.updateWords(cmd);
	}
}
