package stm.com.program.pricerevision.web;

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
import stm.com.program.pricerevision.service.PriceRevisionService;

@Controller
@RequestMapping("/back/price/revision")
public class PriceRevisionController extends GenericController<PriceRevisionService, PriceRevisionCommand> {

	@Override
	public String insert(PriceRevisionCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {

		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String update(PriceRevisionCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		
		getService().update(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String delete(PriceRevisionCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.delete(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@RequestMapping(value="/updateWords.do")
	public String updateWords(PriceRevisionCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
				
		getService().updateWords(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
}