package stm.com.program.category.web;

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
import stm.com.program.category.service.CategoryService;

@Controller
@RequestMapping("/back/category")
public class CategoryController extends GenericController<CategoryService, CategoryCommand> {

	@Override
	public String insert(CategoryCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {

		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String deleteList(CategoryCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.deleteList(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
		
	}
}