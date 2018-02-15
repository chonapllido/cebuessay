package stm.com.program.category.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import stm.com.generic.web.GenericController;
import stm.com.program.category.service.CategoryService;

@Controller
@RequestMapping("/front/category")
public class CategoryFrontController extends GenericController<CategoryService, CategoryCommand> {

	
	
}