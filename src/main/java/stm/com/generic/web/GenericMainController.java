package stm.com.generic.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Generic Main Page Controller
 * 
 * @author Park sung hyun
 * 
 */
public class GenericMainController {
	@RequestMapping("/index")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("layout.main");
		return mav;
	}
	
}
