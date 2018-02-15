package stm.com.program.price.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.program.category.service.CategoryService;
import stm.com.program.category.web.CategoryCommand;
import stm.com.program.login.web.LoginCommand;
import stm.com.program.priceessay.service.PriceEssayService;
import stm.com.program.priceessay.web.PriceEssayCommand;
import stm.com.program.pricerevision.service.PriceRevisionService;
import stm.com.program.pricerevision.web.PriceRevisionCommand;
import stm.com.support.util.ApplicationHelper;

@Controller
public class PriceFrontController {

	@SuppressWarnings("unchecked")
	@RequestMapping(value="/front/prices.do", method=RequestMethod.GET)
	public ModelAndView prices(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/prices");
		
		LoginCommand login_cmd = (LoginCommand) req.getSession().getAttribute("loginUser");
		
		PriceEssayCommand pessay_cmd = new PriceEssayCommand();
		PriceEssayService pessay_service = (PriceEssayService) ApplicationHelper.getService("priceessayService", req.getSession().getServletContext());
		
		if(login_cmd == null){
			pessay_cmd.setSpecial("0");
		} else {
			pessay_cmd.setSpecial(login_cmd.getUser_price());
		}
		
		List<PriceEssayCommand> pessay_list = pessay_service.getListByUser(pessay_cmd, req, res);
		String pessay_words = pessay_list.get(0).getWords();
		
		mav.addObject("essay_prices", pessay_list);
		mav.addObject("essay_words", pessay_words);
		
		PriceRevisionCommand prev_cmd = new PriceRevisionCommand();
		PriceRevisionService prev_service = (PriceRevisionService) ApplicationHelper.getService("pricerevisionService", req.getSession().getServletContext());
		List<PriceRevisionCommand> prev_list = (List<PriceRevisionCommand>) prev_service.getListOrderByDays(prev_cmd, req, res).getList();
		String prev_words = prev_list.get(0).getWords();
		
		mav.addObject("revision_prices", prev_list);
		mav.addObject("revision_words", prev_words);
		
		CategoryCommand category_cmd = new CategoryCommand();
		CategoryService category_service = (CategoryService) ApplicationHelper.getService("categoryService", req.getSession().getServletContext());
		mav.addObject("category_list", category_service.getList(category_cmd, req, res));
		
		return mav;
		
	}
}
