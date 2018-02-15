package stm.com.program.readmaterial.web;

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
import stm.com.program.readmaterial.service.ReadMaterialService;

@Controller
@RequestMapping("/back/readmaterial")
public class ReadMaterialController extends GenericController<ReadMaterialService, ReadMaterialCommand> {

	@Override
	public String insert(ReadMaterialCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {

		getService().insert(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String deleteList(ReadMaterialCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.deleteList(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
		
	}
	
	@Override
	public String update(ReadMaterialCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		
		getService().update(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
	
	@Override
	public String delete(ReadMaterialCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		super.delete(cmd, req, res);
		
		return "redirect:/back/prices/list.do";
	}
}