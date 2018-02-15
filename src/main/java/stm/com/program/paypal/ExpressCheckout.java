package stm.com.program.paypal;


/*==================================================================
 PayPal Express Checkout Call
 ===================================================================
*/


import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import stm.com.program.order.essay.service.OrderEssayService;
import stm.com.program.order.essay.web.OrderEssayCommand;
import stm.com.program.order.revision.service.OrderRevisionService;
import stm.com.program.order.revision.web.OrderRevisionCommand;
import stm.com.program.order.service.OrderService;
import stm.com.program.order.web.OrderCommand;
import stm.com.support.util.ApplicationHelper;

@Controller
@RequestMapping("/paypal")
public class ExpressCheckout extends HttpServlet {
   
	private static final long serialVersionUID = -2722761580200224133L;
	
	@RequestMapping(value="/pay.do", method=RequestMethod.POST)
	public void checkout(HttpServletRequest request,
                      HttpServletResponse response)
         throws ServletException, IOException {

		HttpSession session = request.getSession();
        PayPal pp = new PayPal();

        session.setAttribute("paypal_order_type", request.getParameter("orderType"));
        session.setAttribute("paypal_order_id", request.getParameter("orderId"));
        /*
        '------------------------------------
        ' The returnURL is the location where buyers return to when a
        ' payment has been successfully authorized.
        '
        ' This is set to the value entered on the Integration Assistant
        '------------------------------------
        */
        
        String returnURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/paypal/review.do?page=review";
        
        /*
        '------------------------------------
        ' The cancelURL is the location buyers are sent to when they hit the
        ' cancel button during authorization of payment during the PayPal flow
        '
        ' This is set to the value entered on the Integration Assistant
        '------------------------------------
        */
        String cancelURL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/front/main.do";
      
        for (Object key : request.getParameterMap().keySet()) {
        		Object value = request.getParameterMap().get(key);
        		String val = value.toString();
        		session.setAttribute(key+"", val);
			   //session.setAttribute(key+"", request.getParameterMap().get(key)[0]);
			}

    	Map<String, String> nvp;
		nvp = pp.callShortcutExpressCheckout (request, returnURL, cancelURL);
        
		String strAck = nvp.get("ACK").toString().toUpperCase();
		
        if(strAck !=null && (strAck.equals("SUCCESS") || strAck.equals("SUCCESSWITHWARNING") ))
        {
            session.setAttribute("token", nvp.get("TOKEN").toString());
            // Redirect to paypal.com
            pp.redirectURL(response, nvp.get("TOKEN").toString());
        }
        else
        {
            // Display a user friendly Error on the page using any of the following error information returned by PayPal
            String ErrorCode = nvp.get("L_ERRORCODE0").toString();
            String ErrorShortMsg = nvp.get("L_SHORTMESSAGE0").toString();
            String ErrorLongMsg = nvp.get("L_LONGMESSAGE0").toString();
            String ErrorSeverityCode = nvp.get("L_SEVERITYCODE0").toString();
            
            String errorString = "SetExpressCheckout API call failed. "+
           		"<br>Detailed Error Message: " + ErrorLongMsg +
		        "<br>Short Error Message: " + ErrorShortMsg +
		        "<br>Error Code: " + ErrorCode +
		        "<br>Error Severity Code: " + ErrorSeverityCode;
            request.setAttribute("error", errorString);
        	RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
        	if (dispatcher != null){
        		dispatcher.forward(request, response);
        	}    
        }

	}
	
	@RequestMapping(value="/pay.do", method=RequestMethod.GET)
	public void checkoutGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		checkout(request, response);
	}

	@RequestMapping(value="/review.do", method=RequestMethod.GET)
	public ModelAndView review(HttpServletRequest request, HttpServletResponse response)
    		throws ServletException, IOException, Exception {
		
		HttpSession session = request.getSession(true);
		String finalPaymentAmount = (String)session.getAttribute("Payment_Amount");
		ModelAndView mav = new ModelAndView();
		
		if (isSet(request.getParameter("PayerID")))
			session.setAttribute("payer_id", request.getParameter("PayerID"));
		
		String token = "";
		if (isSet(request.getParameter("token"))){
			session.setAttribute("TOKEN", request.getParameter("token"));
			token = request.getParameter("token");
		}else{
			token = (String) session.getAttribute("TOKEN");
		}
		
		// Check to see if the Request object contains a variable named 'token'	
		PayPal pp = new PayPal();   	
		Map<String, String> result = new HashMap<String, String>();
		// If the Request object contains the variable 'token' then it means that the user is coming from PayPal site.	
		if (isSet(token))
		{
			/*
			* Calls the GetExpressCheckoutDetails API call
			*/
			Map<String, String> getec = pp.getShippingDetails(session, token );
			String strAck = getec.get("ACK");	 
			if(strAck !=null && (strAck.equalsIgnoreCase("SUCCESS") || strAck.equalsIgnoreCase("SUCCESSWITHWARNING") ))
			{
				result.putAll(getec);
				/*
				* The information that is returned by the GetExpressCheckoutDetails call should be integrated by the partner into his Order Review 
				* page		
				*/
				String email 			= getec.get("EMAIL"); // ' Email address of payer.
				String payerId 			= getec.get("PAYERID"); // ' Unique PayPal customer account identification number.
				String payerStatus		= getec.get("PAYERSTATUS"); // ' Status of payer. Character length and limitations: 10 single-byte alphabetic characters.
				String firstName		= getec.get("FIRSTNAME"); // ' Payer's first name.
				String lastName			= getec.get("LASTNAME"); // ' Payer's last name.
				String cntryCode		= getec.get("COUNTRYCODE"); // ' Payer's country of residence in the form of ISO standard 3166 two-character country codes.
				String shipToName		= getec.get("PAYMENTREQUEST_0_SHIPTONAME"); // ' Person's name associated with this address.
				String shipToStreet		= getec.get("PAYMENTREQUEST_0_SHIPTOSTREET"); // ' First street address.
				String shipToCity		= getec.get("PAYMENTREQUEST_0_SHIPTOCITY"); // ' Name of city.
				String shipToState		= getec.get("PAYMENTREQUEST_0_SHIPTOSTATE"); // ' State or province
				String shipToCntryCode	= getec.get("PAYMENTREQUEST_0_SHIPTOCOUNTRYCODE"); // ' Country code. 
				String shipToZip		= getec.get("PAYMENTREQUEST_0_SHIPTOZIP"); // ' U.S. Zip code or other country-specific postal code.
				String addressStatus 	= getec.get("ADDRESSSTATUS"); // ' Status of street address on file with PayPal 
				String totalAmt   		= getec.get("PAYMENTREQUEST_0_AMT"); // ' Total Amount to be paid by buyer
				String currencyCode     = getec.get("CURRENCYCODE"); // 'Currency being used 
				
			} 
			else  
			{
				//Display a user friendly Error on the page using any of the following error information returned by PayPal
		        String ErrorCode = getec.get("L_ERRORCODE0").toString();
		        String ErrorShortMsg = getec.get("L_SHORTMESSAGE0").toString();
		        String ErrorLongMsg = getec.get("L_LONGMESSAGE0").toString();
		        String ErrorSeverityCode = getec.get("L_SEVERITYCODE0").toString();
		        
		        String errorString = "SetExpressCheckout API call failed. "+
		
		       		"<br>Detailed Error Message: " + ErrorLongMsg +
			        "<br>Short Error Message: " + ErrorShortMsg +
			        "<br>Error Code: " + ErrorCode +
			        "<br>Error Severity Code: " + ErrorSeverityCode;
		       
		        mav.addObject("error", errorString);
		    	mav.setViewName("/paypal/error");
		    	
		    	return mav;
		    }
		}   
		
		/*
		* Calls the DoExpressCheckoutPayment API call
		*/

		if (isSet(request.getParameter("page")) && request.getParameter("page").equals("return")){  
	
			Map doEC = pp.confirmPayment (session,finalPaymentAmount,request.getServerName() );
			String strAck = doEC.get("ACK").toString().toUpperCase();
			if(strAck !=null && (strAck.equalsIgnoreCase("Success") || strAck.equalsIgnoreCase("SuccessWithWarning"))){
		    	result.putAll(doEC);
		    	
		    	mav.addObject("ack", strAck);
		    	System.out.println("ack value"+ strAck);
		    	
		    	//session.invalidate();
		    	session.removeAttribute("payer_id");
		    	session.removeAttribute("TOKEN");
		    	
		    	String order_id = (String) session.getAttribute("paypal_order_id");
		    	
		    	// update status of order to paid
		    	OrderCommand cmd = new OrderCommand();
		    	cmd.setOrder_id(order_id);
		    	cmd.setStatus("5");
		    	OrderService order_service = (OrderService) ApplicationHelper.getService("orderService", request.getSession().getServletContext());
		    	order_service.updateStatus(cmd, request, response);
		    	
		    	// Essay
		    	if(session.getAttribute("paypal_order_type").equals("Essay")){
		    		OrderEssayCommand oessay_cmd = new OrderEssayCommand();
		    		oessay_cmd.setOrder_id(order_id);
		    		oessay_cmd.setStatus("5");
		    		OrderEssayService oessay_service = (OrderEssayService) ApplicationHelper.getService("orderessayService", request.getSession().getServletContext());
		    		oessay_service.updateStatus(oessay_cmd, request, response);
		    	
		    	// Revision
		    	} else {
		    		OrderRevisionCommand orev_cmd = new OrderRevisionCommand();
		    		orev_cmd.setOrder_id(order_id);
		    		orev_cmd.setStatus("5");
		    		OrderRevisionService orev_service = (OrderRevisionService) ApplicationHelper.getService("orderrevisionService", request.getSession().getServletContext());
		    		orev_service.updateStatus(orev_cmd, request, response);
		    	}
		    	
			}else{
		    	//Display a user friendly Error on the page using any of the following error information returned by PayPal
		        String ErrorCode = doEC.get("L_ERRORCODE0").toString();
		        String ErrorShortMsg = doEC.get("L_SHORTMESSAGE0").toString();
		        String ErrorLongMsg = doEC.get("L_LONGMESSAGE0").toString();
		        String ErrorSeverityCode = doEC.get("L_SEVERITYCODE0").toString();	            
		        String errorString = "SetExpressCheckout API call failed. "+	
		       		"<br>Detailed Error Message: " + ErrorLongMsg +
			        "<br>Short Error Message: " + ErrorShortMsg +
			        "<br>Error Code: " + ErrorCode +
			        "<br>Error Severity Code: " + ErrorSeverityCode;
		    
		    	mav.addObject("error", errorString);
		    	mav.setViewName("/paypal/error");
			}
			
			mav.setViewName("/paypal/return");
		}else{
			mav.setViewName("/paypal/review");
		}
		
		mav.addObject("result", result);
		
		return mav;
	}
	
	@RequestMapping(value="/review.do", method=RequestMethod.POST)
	public ModelAndView reviewPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception{
		ModelAndView mav = review(request, response);
		return mav;
	}
	
	private boolean isSet(Object value){
		return (value !=null && value.toString().length()!=0);
	}

}