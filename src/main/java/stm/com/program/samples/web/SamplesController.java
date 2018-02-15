package stm.com.program.samples.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import stm.com.generic.web.GenericController;
import stm.com.program.priceessay.web.PriceEssayCommand;
import stm.com.program.samples.service.SamplesService;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;

@Controller
@RequestMapping("/back/samples")
public class SamplesController extends GenericController<SamplesService, SamplesCommand> {

	@Override
	public String insert(SamplesCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {
		
		String folderDest = "/samples/";
		FileMngUtil fileUtil = new FileMngUtil();
		
		Map<String, MultipartFile> files = multireq.getFileMap();
		
		if (!files.isEmpty()) {
			FileCommand _cmd = fileUtil.uploadFile(files, folderDest);
			cmd.setFile(_cmd.getOrig_name());
			cmd.setFile_type(_cmd.getType());
		} 
		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String delete(SamplesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.delete(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@RequestMapping(value="/download.do", method=RequestMethod.POST)
	public void downloadSample(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
		String folderDest = "/samples/";
		String fileName = req.getParameter("filename");
		
		FileCommand cmd = new FileCommand();
		cmd.setNew_name(fileName);
		cmd.setOrig_name(fileName);
		
		FileMngUtil fileUtil = new FileMngUtil();
		fileUtil.downloadFile(cmd, folderDest, req, res);
	}
	
}