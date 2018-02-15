package stm.com.program.category.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.category.service.CategoryService;
import stm.com.program.category.web.CategoryCommand;

@Service("categoryService")
public class CategoryServiceImpl extends GenericServiceImpl<CategoryDao, CategoryCommand> implements CategoryService {

}
