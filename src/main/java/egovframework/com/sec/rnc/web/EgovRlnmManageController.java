package egovframework.com.sec.rnc.web;

import java.net.URLDecoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.sec.rnc.service.EgovRlnmManageService;
import egovframework.rte.ptl.mvc.bind.annotation.CommandMap;

/**
 * 실명인증관련 요청을  비지니스 클래스로 전달하고 처리된결과를  해당   웹 화면으로 전달하는  Controller를 정의한다
 * @author 공통서비스 개발팀 조재영
 * @since 2009.04.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.10  조재영          최초 생성
 *
 * </pre>
 */
@Controller
public class EgovRlnmManageController {

    /** rlnmManageService */
    @Resource(name = "rlnmManageService")
    private EgovRlnmManageService rlnmManageService;
    
    /** Log Info */
    protected Log log = LogFactory.getLog(this.getClass());
    
    /**
     * 실명인증확인화면 호출(주민번호) 
     * @param model 모델
     * @return "egovframework/com/uss/umt/EgovStplatCnfirm"
     * @exception Exception
     */
    @RequestMapping("/sec/rnc/EgovRlnmCnfirm.do")
    public String rlnmCnfirm(Model model, HttpServletRequest request) throws Exception {
    	
    	model.addAttribute("ihidnum",     (String)request.getParameter("ihidnum"));     //주민번호
    	model.addAttribute("realname",    (String)request.getParameter("realname"));    //사용자이름
    	model.addAttribute("sbscrbTy",    (String)request.getParameter("sbscrbTy"));    //사용자유형
    	model.addAttribute("nextUrlName", (String)request.getParameter("nextUrlName")); //다음단계버튼명(이동할 URL에 따른)
    	model.addAttribute("nextUrl",     (String)request.getParameter("nextUrl"));     //다음단계로 이동할 URL
    	String result="";
    	
    	if("".equals((String)request.getParameter("ihidnum"))) {
    		result="info.user.rlnmCnfirm";
    		model.addAttribute("result",     result);   //실명확인 결과
    		return "egovframework/com/sec/rnc/EgovRlnmCnfirm";
    	}
    	 	
    	
        try{
             result = rlnmManageService.rlnmCnfirm(
        		(String)request.getParameter("ihidnum"), 
        		(String)request.getParameter("realname"),
        		(String)request.getParameter("sbscrbTy"));
             //방화벽 오픈전 테스트를 위해 임시추가 - 성공강제셋팅
             result = "00";
        }catch(Exception e){
        	log.error("Exception:  "  +  e.getClass().getName());  
        	log.error("Exception  Message:  "  +  e.getMessage());
        }finally{
        	model.addAttribute("result_tmp",result+"__"+result.substring(0,2));
        	if (result.substring(0,2).equals("00")){
            	result = "success.user.rlnmCnfirm";
            }else if(result.substring(0,2).equals("01")){
            	result = "fail.user.rlnmCnfirm";
            }else{
            	result = "fail.user.connectFail";
            }
        	model.addAttribute("result",     result);   //실명확인 결과
        	
            return "egovframework/com/sec/rnc/EgovRlnmCnfirm";
        }
    }
    
    /**
     * 실명인증확인화면 호출(GPIN) 
     * @param model 모델
     * @return "egovframework/com/uss/umt/EgovStplatCnfirm"
     * @exception Exception
     */
    @RequestMapping("/sec/rnc/EgovRlnmPinCnfirm.do")
    public String rlnmPinCnfirm(Model model, HttpServletRequest request) throws Exception {
        model.addAttribute("sbscrbTy", 		(String)request.getParameter("sbscrbTy"));     //사용자유형
    	model.addAttribute("nextUrlName", (String)request.getParameter("nextUrlName")); //다음단계버튼명(이동할 URL에 따른)
    	model.addAttribute("nextUrl",     (String)request.getParameter("nextUrl"));     //다음단계로 이동할 URL
    	String realName = (String)request.getParameter("realName");                         //결과_최초는 블랭크
        String result = (String)request.getParameter("result");                         //결과_최초는 블랭크
log.debug("realName:"+realName);
        if("".equals(result) && "".equals(realName)) {
    		result="info.user.rlnmPinCnfirm";
    		model.addAttribute("result",     result);   //실명확인 결과
    	}else{
    		if(!realName.equals("null")&&!realName.equals("")){
    			result="success.user.rlnmPinCnfirm";
    			model.addAttribute("result",     result);   //실명확인 결과 메시지
    			realName = URLDecoder.decode(realName,"UTF-8");  // gpin배포샘플은 기본인코딩이 euc-kr
    			model.addAttribute("realName",     realName);   //실명확인 결과 이름
    			//return "forward:"+(String)request.getParameter("nextUrl"); 성공시만 체크하여 직접 다음 URL로 이동할수도 있음
    		}else{
    		    result="fail.user.rlnmPinCnfirm";
    		    model.addAttribute("result",     result);   //실명확인 결과 메시지
    		    realName = new String(realName.getBytes("UTF-8"),"EUC-KR");  // gpin배포샘플은 기본인코딩이 euc-kr
    		    model.addAttribute("realName",     realName);   //실명확인 결과 이름
    		}
    	} 
        log.debug("result:"+result);
        return "egovframework/com/sec/rnc/EgovRlnmPinCnfirm";
    }
    
    /**
     * 실명인증확인화면 호출(GPIN) 
     * @param model 모델
     * @return "egovframework/com/uss/umt/EgovStplatCnfirm"
     * @exception Exception
     */
    @RequestMapping("/sec/rnc/EgovGPinCall.do")
    public String gpinCall(Model model, HttpServletRequest request) throws Exception {
        model.addAttribute("gpinId",        (String)request.getParameter("gpinId"));       //GPIN 아이디
        model.addAttribute("gpinPassword",  (String)request.getParameter("gpinPassword")); //GPIN 패스워드
        model.addAttribute("sbscrbTy", 		(String)request.getParameter("sbscrbTy"));     //사용자유형
        //model.addAttribute("urlName",       (String)request.getParameter("urlName"));   //다음단계버튼명(이동할 URL에 따른)
    	//model.addAttribute("urlInfo",       (String)request.getParameter("urlInfo"));   //다음단계로 이동할 URL
    	model.addAttribute("nextUrlName", (String)request.getParameter("nextUrlName")); //다음단계버튼명(이동할 URL에 따른)
    	model.addAttribute("nextUrl",     (String)request.getParameter("nextUrl"));     //다음단계로 이동할 URL
    	
        return "egovframework/com/sec/rnc/gpin/Sample-AuthRequest";
    }
    
	/**
	 * validato rule dynamic Javascript
	 */
	@RequestMapping("/sec/rnc/validator.do")
	public String validate(){
		return "egovframework/com/cmm/validator";
	}
	
	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/sec/rnc/EgovPageLink.do")
	public String moveToPage(@RequestParam("link") String linkPage){
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		String rtnLinkPage = linkPage;
		if (linkPage==null || linkPage.equals("")){
			rtnLinkPage="egovframework/com/cmm/egovError";
		}
		return rtnLinkPage;
	}
}