package stm.com.program.priceessay.web;

import java.io.FileNotFoundException;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import stm.com.generic.web.GenericController;
import stm.com.program.priceessay.service.PriceEssayService;

@Controller
@RequestMapping("/back/price/essay")
public class PriceEssayController extends GenericController<PriceEssayService, PriceEssayCommand> {

	@Override
	public String insert(PriceEssayCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {

		if(cmd.getMaxpage().equals("")){
			cmd.setMaxpage(null);
		}
		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String update(PriceEssayCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		
		if(cmd.getMaxpage().equals("")){
			cmd.setMaxpage(null);
		}
		
		getService().update(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String delete(PriceEssayCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.delete(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@RequestMapping(value="/updateWords.do")
	public String updateWords(PriceEssayCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
				
		getService().updateWords(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
}