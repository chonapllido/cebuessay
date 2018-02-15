package egovframework.com.cmm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import stm.com.program.login.web.LoginCommand;
import stm.com.support.util.ApplicationHelper;
import egovframework.com.cmm.LoginVO;

public class AuthenticInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		boolean isPermittedURL = false;

		//LoginVO loginVO = (LoginVO) request.getSession().getAttribute("loginVO");
		LoginCommand loginVO = (LoginCommand) request.getSession().getAttribute("loginUser");

		String uri = request.getRequestURI();
		String url = "/front/main.do";

		if (loginVO != null) {
			isPermittedURL = true;
			if (uri.contains("/front/main.do")) {
				url = "/back/main.do";
				isPermittedURL = false;
			}
		}

		if (!isPermittedURL) {
			ModelAndView modelAndView = new ModelAndView("redirect:" + url);
			throw new ModelAndViewDefiningException(modelAndView);
		}

		// 메뉴 가져오기
		if (!uri.contains("/ajax/") && !uri.contains("/popup/") && !uri.contains("/grid/") && !uri.contains("/wfwin/") && !uri.contains("/mapping/") && !uri.contains("/attach/") && !uri.contains("/include/") && !uri.contains("/delete.do") && !uri.contains("/layout/") && "GET".equals(request.getMethod().toUpperCase())) {
//			MenuCommand menuCommand = new MenuCommand();
//			MenuService menuService = (MenuService) ApplicationHelper.getService("menuService", request.getSession().getServletContext());
//			menuCommand.setUser_id(loginVO.getInfo().getUser_id());
//			menuCommand.setSystem_type(loginVO.getInfo().getSystem_type());
//			request.setAttribute("menu", menuService.getMenu(menuCommand, request, response));
		}

		// 탭정보 조회
		String refer = request.getParameter("refer_appr");
		String master_inout_div = request.getParameter("master_inout_div");
		String ref_id = request.getParameter("org_ref_id") != null ? request.getParameter("org_ref_id") : request.getParameter("ref_id");

		if (refer != null && refer.contains("/masterbox") && !StringUtils.isEmpty(ref_id)) {
//			ApplymgtCommonCommand applymgtCommand = new ApplymgtCommonCommand();
//			ApplymgtCommonService applymgtService = (ApplymgtCommonService) ApplicationHelper.getService("applymgtCommonService", request.getSession().getServletContext());
//			applymgtCommand.setRef_id(ref_id);
			if ("INT".equals(master_inout_div)) {
//				request.setAttribute("tabinfo", applymgtService.getIntMasterTab(applymgtCommand, request, response));
			}
			if ("EXT".equals(master_inout_div)) {
//				request.setAttribute("tabinfo", applymgtService.getExtMasterTab(applymgtCommand, request, response));
			}
		}

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		// String uri = request.getRequestURI();

		super.postHandle(request, response, handler, modelAndView);
	}
}
