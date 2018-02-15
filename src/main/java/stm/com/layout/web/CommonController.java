
package stm.com.layout.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.generic.web.GenericCommonController;
import stm.com.support.fileio.FileCommand;
import stm.com.support.fileio.FileMngUtil;

@Controller
public class CommonController extends GenericCommonController {
	
	@RequestMapping("/front/common.do")
	protected ModelAndView main(HttpServletRequest req, HttpServletResponse res) throws Exception {
		// TODO Auto-generated method stub
		ModelAndView mav = super.frontMain(req, res);
		mav.addObject("title", getTitle((String) mav.getModelMap().get("page")));
		mav.addObject("sub_title", getTitle((String) mav.getModelMap().get("page")));
		return mav;
	}
	
	private String getTitle(String page) {
		if ("sitemap".equals(page)) {
			return "사이트맵";
		} else if ("".equals(page)) {
			return "";
		}
		
		return "";
	}
}

