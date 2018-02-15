package stm.com.program.samples.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.generic.web.GenericController;
import stm.com.program.samples.service.SamplesService;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;

@Controller
@RequestMapping("/front/samples")
public class SamplesFrontController extends GenericController<SamplesService, SamplesCommand> {
	
	@Override
	public ModelAndView list(SamplesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		ModelAndView mav = super.list(cmd, req, res);
		SamplesService service = getService();
		
		SamplesCommand essay_sample = new SamplesCommand();
		essay_sample.setType("essay");
		mav.addObject("essay_samples", service.getListByType(essay_sample, req, res));
		
		SamplesCommand revision_sample = new SamplesCommand();
		revision_sample.setType("revision");
		mav.addObject("revision_samples", service.getListByType(revision_sample, req, res));
		
		SamplesCommand project_sample = new SamplesCommand();
		project_sample.setType("project");
		mav.addObject("project_samples", service.getListByType(project_sample, req, res));
		
		String names[] = {"One", "Two", "Three", "Four"};
		mav.addObject("name_list", names);		
		
		return mav;
	}

	@RequestMapping(value="/download.do", method=RequestMethod.POST)
	public void download(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String fileName = req.getParameter("filename");
		String folderDest = "/samples/";

		FileCommand cmd = new FileCommand();
		cmd.setNew_name(fileName);
		cmd.setOrig_name(fileName);
		
		FileMngUtil fileUtil = new FileMngUtil();
		fileUtil.downloadFile(cmd, folderDest, req, res);
	}
	
}