package stm.com.program.paypal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/front/paypal")
public class PaypalController {

	@RequestMapping(value="/paynow.do", method=RequestMethod.GET)
	public ModelAndView paynow(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/paypal/paynow");
		
		return mav;		
	}
	
	@RequestMapping(value="/preview.do", method=RequestMethod.POST)
	public ModelAndView preview(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/front/paypal/preview");
		
		mav.addObject("email", request.getParameter("email"));
		mav.addObject("username", request.getParameter("username"));
		mav.addObject("amount", request.getParameter("amount"));
		return mav;		
	}
}
