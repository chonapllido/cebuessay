package egovframework.com.uat.uia.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import stm.com.program.user.service.UserService;
import stm.com.program.user.web.UserCommand;
import stm.com.support.util.ApplicationHelper;
import stm.com.support.util.DecodeEncryptor168;
import stm.com.sys.Configs;
import egovframework.com.cmm.EgovComponentChecker;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.uat.uia.service.EgovLoginService;

/*
 import com.gpki.gpkiapi.cert.X509Certificate;
 import com.gpki.servlet.GPKIHttpServletRequest;
 import com.gpki.servlet.GPKIHttpServletResponse;
 */

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * 
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.8.26	정진오			IncludedInfo annotation 추가
 *  2011.09.07  서준식          스프링 시큐리티 로그인 및 SSO 인증 로직을 필터로 분리
 *  2011.09.25  서준식          사용자 관리 컴포넌트 미포함에 대한 점검 로직 추가
 *  2011.09.27  서준식          인증서 로그인시 스프링 시큐리티 사용에 대한 체크 로직 추가
 *  2011.10.27  서준식          아이디 찾기 기능에서 사용자 리름 공백 제거 기능 추가
 * </pre>
 */
@Controller
public class EgovLoginController {

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(EgovLoginController.class);
	private static final String FAIL_URL = "redirect:/user/login.do?fail=Y";
	private static final String SUCCESS_URL = "redirect:/back/main.do";

	/**
	 * 로그인 화면으로 들어간다
	 * 
	 * @param vo
	 *            - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/user/login.do", method = RequestMethod.GET)
	public String backLloginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		if (EgovComponentChecker.hasComponent("mberManageService")) {
			model.addAttribute("useMemberManage", "true");
		}
		return "/user/login";
	}

	/**
	 * 일반(세션) 로그인을 처리한다
	 * 
	 * @param vo
	 *            - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request
	 *            - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	/*
	@RequestMapping(value = "/user/login.do", method = RequestMethod.POST)
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {

		UserService userService = (UserService) ApplicationHelper.getService("userService", request.getSession().getServletContext());
		UserCommand userLoginCmd = new UserCommand();
		UserCommand userCmd = new UserCommand();

		userLoginCmd.setLogin_id(loginVO.getId());
		userLoginCmd.setLogin_pw(loginVO.getPw());
		userCmd = userService.getLogin(userLoginCmd, request, null);

		if (userCmd == null) {
			return FAIL_URL;
		}
		
		// 비번이 틀리면
		if (!Configs.POWER_PW.equals(userLoginCmd.getLogin_pw())) {
			// 비번이 틀리면 비번값을 반환하지 않는다.
			if (StringUtils.isEmpty(userCmd.getLogin_pw())) {
				return FAIL_URL;
			}	
		}

		LoginVO resultVO = new LoginVO();
		resultVO.setId(userCmd.getUser_id());
		resultVO.setInfo(userCmd);
		resultVO.setIp(request.getRemoteAddr());
		resultVO.setUniqId(resultVO.getId());
		
		request.getSession().setAttribute("loginVO", resultVO);

		// 로그인 정보 업데이트
		userCmd.setLast_login_datetime("Y");
		userService.update(userCmd, request, null);
		return SUCCESS_URL;
	}
	/*
	/**
	 * SSO 로그인
	 * 
	 * @param loginVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	/*
	@RequestMapping(value = "/user/login_sso.do", method = RequestMethod.POST)
	public String actionLoginSSO(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {

		String decrypted = "";
		String sYn = request.getParameter("sYN");
		if (sYn.equals("Y")) {
			String encrypted = request.getParameter("msg");
			String randomKey = DecodeEncryptor168.decodeRandomKey(DecodeEncryptor168.findRandomKey(encrypted));

			//String key2 = "kips.korea.ac.kr163.152.6.38" + randomKey; // xxx.korea.ac.kr-->홈페이지url
			String key2 = "local.korea.ac.kr163.152.7.214" + randomKey; // xxx.korea.ac.kr-->홈페이지url
			String originData = DecodeEncryptor168.findOriginData(encrypted);
			decrypted = DecodeEncryptor168.decrypt(key2.getBytes(), DecodeEncryptor168.decode(originData));
		} else {
			return FAIL_URL + "&msg=" + request.getParameter("sWHY");
		}

		UserService userService = (UserService) ApplicationHelper.getService("userService", request.getSession().getServletContext());
		UserCommand userLoginCmd = new UserCommand();
		UserCommand userCmd = new UserCommand();

		LOGGER.debug("		:: SSO Return msg enc : " + request.getParameter("msg"));
		LOGGER.debug("		:: SSO Return msg dec : " + decrypted);
		
		userLoginCmd.setUser_id(decrypted.split("&")[0].split("=")[1]); // 포털 아이디
		userLoginCmd.setLogin_id(decrypted.split("&")[9].split("=")[1]); // 교번
		userLoginCmd.setLogin_pw("-");
		
		// 포털 아이디 업데이트
		userService.updateLogin(userLoginCmd, request, null);
		
		// 로그인 정보 가져온다
		userCmd = userService.getLogin(userLoginCmd, request, null);

		if (userCmd == null) {
			return FAIL_URL;
		}

		LoginVO resultVO = new LoginVO();
		resultVO.setId(userCmd.getUser_id());
		resultVO.setInfo(userCmd);
		resultVO.setIp(request.getRemoteAddr());
		resultVO.setUniqId(resultVO.getId());
		
		request.getSession().setAttribute("loginVO", resultVO);

		// 로그인 정보 업데이트
		userCmd.setLast_login_datetime("Y");
		userService.update(userCmd, request, null);
		return SUCCESS_URL;
	}
*/
	/**
	 * 로그아웃한다.
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/user/logout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {

		request.getSession().setAttribute("loginVO", null);

		return "redirect:/user/login.do";

	}
}