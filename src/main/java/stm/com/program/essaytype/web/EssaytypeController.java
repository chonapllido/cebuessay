package stm.com.program.essaytype.web;

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
import stm.com.program.essaytype.service.EssaytypeService;

@Controller
@RequestMapping("/back/essaytype")
public class EssaytypeController extends GenericController<EssaytypeService, EssaytypeCommand> {

	@Override
	public String insert(EssaytypeCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {

		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String deleteList(EssaytypeCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.deleteList(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
		
	}
}