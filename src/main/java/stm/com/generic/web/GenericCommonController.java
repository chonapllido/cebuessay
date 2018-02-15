package stm.com.generic.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import stm.com.program.samples.service.SamplesService;
import stm.com.program.samples.web.SamplesCommand;
import stm.com.support.util.ApplicationHelper;

/**
 * Generic Common Page Controller
 * 
 * @author Park sung hyun
 * 
 */
public class GenericCommonController {
	@RequestMapping("/front/common")
	protected ModelAndView frontMain(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		String page = req.getParameter("page");
		if (page == null)
			throw new Exception("page parameter is not be null");
		
		SamplesService service = (SamplesService) ApplicationHelper.getService("samplesService", req.getSession().getServletContext());
		SamplesCommand essay_sample = new SamplesCommand();
		essay_sample.setType("essay");
		mav.addObject("essay_samples", service.getListByType(essay_sample, req, res));
		
		SamplesCommand revision_sample = new SamplesCommand();
		revision_sample.setType("revision");
		mav.addObject("revision_samples", service.getListByType(revision_sample, req, res));
		
		SamplesCommand project_sample = new SamplesCommand();
		project_sample.setType("project");
		mav.addObject("project_samples", service.getListByType(project_sample, req, res));
		
		
		mav.setViewName("common.page");
		mav.addObject("page", page);
		return mav;
	}
	
	@RequestMapping("/back/common")
	protected ModelAndView backMain(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		String page = req.getParameter("page");
		if (page == null)
			throw new Exception("page parameter is not be null");
		
		mav.setViewName("common.page");
		mav.addObject("page", page);
		return mav;
	}
	
}
