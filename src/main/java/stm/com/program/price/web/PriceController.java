package stm.com.program.price.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.program.category.service.CategoryService;
import stm.com.program.category.web.CategoryCommand;
import stm.com.program.essaytype.service.EssaytypeService;
import stm.com.program.essaytype.web.EssaytypeCommand;
import stm.com.program.level.service.LevelService;
import stm.com.program.level.web.LevelCommand;
import stm.com.program.priceessay.service.PriceEssayService;
import stm.com.program.priceessay.web.PriceEssayCommand;
import stm.com.program.pricerevision.service.PriceRevisionService;
import stm.com.program.pricerevision.web.PriceRevisionCommand;
import stm.com.program.readmaterial.service.ReadMaterialService;
import stm.com.program.readmaterial.web.ReadMaterialCommand;
import stm.com.program.samples.service.SamplesService;
import stm.com.program.samples.web.SamplesCommand;
import stm.com.program.writingformat.service.WritingFormatService;
import stm.com.program.writingformat.web.WritingFormatCommand;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/back/prices")
public class PriceController {

	@RequestMapping(value="/list.do", method=RequestMethod.GET)
	public ModelAndView prices(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/back/prices");
		
		CategoryCommand cat_cmd = new CategoryCommand();
		CategoryService cat_service = (CategoryService) ApplicationHelper.getService("categoryService", req.getSession().getServletContext());
		mav.addObject("category", cat_service.getList(cat_cmd, req, res));
		
		EssaytypeCommand et_cmd = new EssaytypeCommand();
		EssaytypeService et_service = (EssaytypeService) ApplicationHelper.getService("essaytypeService", req.getSession().getServletContext());
		mav.addObject("essaytype", et_service.getList(et_cmd, req, res));
		
		WritingFormatCommand wf_cmd = new WritingFormatCommand();
		WritingFormatService wf_service = (WritingFormatService) ApplicationHelper.getService("writingformatService", req.getSession().getServletContext());
		mav.addObject("format", wf_service.getList(wf_cmd, req, res));
		
		LevelCommand level_cmd = new LevelCommand();
		LevelService level_service = (LevelService) ApplicationHelper.getService("levelService", req.getSession().getServletContext());
		mav.addObject("level", level_service.getList(level_cmd, req, res));
		
		ReadMaterialCommand rm_cmd = new ReadMaterialCommand();
		ReadMaterialService rm_service = (ReadMaterialService) ApplicationHelper.getService("readmaterialService", req.getSession().getServletContext());
		mav.addObject("readmaterial", rm_service.getList(rm_cmd, req, res));
		
		PriceEssayCommand pessay_cmd = new PriceEssayCommand();
		pessay_cmd.setSpecial("0");
		PriceEssayService pessay_service = (PriceEssayService) ApplicationHelper.getService("priceessayService", req.getSession().getServletContext());
		mav.addObject("priceessay", pessay_service.getListByUser(pessay_cmd, req, res));
		
		PriceEssayCommand special_essay_cmd = new PriceEssayCommand();
		special_essay_cmd.setSpecial("1");
		mav.addObject("priceessayspecial", pessay_service.getListByUser(special_essay_cmd, req, res));
		
		PriceRevisionCommand prev_cmd = new PriceRevisionCommand();
		PriceRevisionService prev_service = (PriceRevisionService) ApplicationHelper.getService("pricerevisionService", req.getSession().getServletContext());
		mav.addObject("pricerevision", prev_service.getListOrderByDays(prev_cmd, req, res));
		
		SamplesService sample_service = (SamplesService) ApplicationHelper.getService("samplesService", req.getSession().getServletContext());
		SamplesCommand essay_sample = new SamplesCommand();
		essay_sample.setType("essay");
		SamplesCommand rev_sample = new SamplesCommand();
		rev_sample.setType("revision");
		SamplesCommand proj_sample = new SamplesCommand();
		proj_sample.setType("project");
		mav.addObject("samples_essay", sample_service.getListByType(essay_sample, req, res));
		mav.addObject("samples_revision", sample_service.getListByType(rev_sample, req, res));
		mav.addObject("samples_project", sample_service.getListByType(proj_sample, req, res));
		return mav;
		
	}
}
