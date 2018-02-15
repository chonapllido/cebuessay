package stm.com.support.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.NoSuchMessageException;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import stm.com.sys.Configs;
import stm.com.sys.Constants;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.cmm.util.EgovUserDetailsHelper;

@Component
public class Functions {

	private static final Logger logger = LoggerFactory.getLogger(Functions.class);
	private static MessageSource ms;

	/**
	 * 다국어
	 * 
	 * @param messageSource
	 */
	@Autowired
	public void setMessageSource(MessageSource messageSource) {
		ms = messageSource;
	}

	/**
	 * 다국어
	 * 
	 * @return
	 */
	public static MessageSource getMessageSource() {
		return ms;
	}

	/**
	 * 앞에 특정 숫자 채우기
	 * 
	 * @param n
	 * @param length
	 * @param prefix
	 * @return
	 */
	public static String lPad(int n, int length, String prefix) {
		StringBuffer padded = new StringBuffer("" + n);
		while (padded.length() < length) {
			padded.insert(0, prefix);
		}
		return padded.toString();
	}

	/**
	 * UUID 추출
	 * 
	 * @param day
	 * @return
	 */
	public static String uuid() {
		UUID randomUUID = UUID.randomUUID();
		return randomUUID.toString();
	}

	/**
	 * QueryString 파라메터 추출
	 * 
	 * @return
	 */
	public static String getQueryString() {
		return getQueryString(null);
	}

	/**
	 * QueryString 파라메터 추출 (구분자 : 세미콜론(;))
	 * 
	 * @param paramException
	 * @return
	 */
	public static String getQueryString(String paramException) {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		String query = req.getQueryString();
		if (StringUtils.isEmpty(query) || (!StringUtils.isEmpty(paramException) && "*".equals(paramException))) {
			return "";
		}
		logger.debug("		:: Functions QueryString : " + query);

		String[] params = query.split("&");
		String key = "";
		String value = "";
		String ret = "";
		logger.debug("		:: Functions QueryString paramException : " + paramException);

		for (int i = 0; i < params.length; i++) {
			String[] p = params[i].split("=");

			if (p.length <= 1) {
				continue;
			}

			key = p[0];
			value = p[1];
			logger.debug("		:: Functions QueryString Exception [KEY] : " + key + "		[VALUE] : " + value);

			if ("CSRFToken".equals(key)) {
				continue;
			}

			if (!StringUtils.isEmpty(paramException)) {
				String[] pe = paramException.split(";");
				boolean bAdd = false;
				for (int j = 0; j < pe.length; j++) {
					if (!StringUtils.isEmpty(pe[j])) {
						if (pe[j].startsWith("*")) {
							if (key.endsWith(pe[j].substring(1))) {
								logger.debug("		:: Functions QueryString Exception First * [KEY] : " + key + "		[Compare KEY] : " + pe[j]);
								bAdd = true;
								continue;
							}
						} else if (pe[j].endsWith("*")) {
							if (key.startsWith(pe[j].substring(0, pe[j].length() - 1))) {
								logger.debug("		:: Functions QueryString Exception Last * [KEY] : " + key + "		[Compare KEY] : " + pe[j]);
								bAdd = true;
								continue;
							}
						} else {
							logger.debug("		:: Functions QueryString Exception [KEY] : " + key + "		[Compare KEY] : " + pe[j]);
							if (pe[j].equals(key)) {
								bAdd = true;
								continue;
							}
						}
					}
				}
				if (bAdd) {
					continue;
				}
			}

			ret += (ret.length() > 0 ? "&" : "") + key + "=" + value;
		}
		logger.debug("		:: Functions QueryString : " + ret);
		return ret;
	}

	/**
	 * 컴포넌트 HTML 얻기
	 * 
	 * @param c
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static String getComponents(String c) throws Exception {
		StringBuffer html = new StringBuffer();
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		html = ((Map<String, StringBuffer>) req.getSession().getServletContext().getAttribute(Constants.TLDS)).get(c);
		if (html == null) {
			throw new Exception("		:: Not Found Components for " + c);
		}
		return html.toString();
	}

	/**
	 * 모바일 여부
	 * 
	 * @param req
	 * @return
	 */
	public static boolean isMobile(HttpServletRequest req) {
		String ua = req.getHeader("user-agent").toLowerCase();
		String[] devices = { "iphone", "ipod", "ipad", "android", "blackberry", "windows ce", "nokia", "webos", "opera mini", "sonyericsson", "opera mobi", "iemobile" };
		for (String d : devices) {
			if (ua.contains(d)) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 회원정보 가져오기
	 * 
	 * @return
	 */
	public static LoginVO getUser() {
		LoginVO vo = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (vo != null) {
			return vo;
		}
		return null;
	}

	/**
	 * 현재 언어 가져오기 (2자리수)
	 * 
	 * @return
	 */
	public static String getLanguage() {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return RequestContextUtils.getLocale(req).toString().substring(0, 2);
	}

	/**
	 * jquery params 형태로 리턴
	 * 
	 * @return
	 */
	public static String getJQueryParams(String params) {
		return params.replaceAll("&", "', ").replaceAll("=", " : '") + "'";
	}

	/**
	 * 신규 여부
	 * 
	 * @param datetime
	 * @param period
	 * @return
	 */
	public static boolean isNew(String datetime, String period) {
		if (StringUtils.isEmpty(period)) {
			period = "" + Configs.NEW_DAY;
		}

		try {
			Calendar nd = Calendar.getInstance();
			Calendar wd = Calendar.getInstance();
			
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			Date dt = df.parse(datetime);
			wd.setTime(dt);
			wd.add(Calendar.DATE, Integer.parseInt(period));

			if (nd.getTimeInMillis() <= wd.getTimeInMillis()) {
				return true;
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return false;
	}

	/**
	 * 내용 줄바꿈 처리
	 * 
	 * @param content
	 * @return
	 */
	public static String getWrap(String content) {
		return content.replaceAll("\\n", "<br/>");
	}

	/**
	 * 다국어 번들
	 * 
	 * @param content
	 * @return
	 */
	public static String getMessage(String key) {
		return getMessage(key, null);
	}

	/**
	 * 다국어 번들
	 * 
	 * @param key
	 * @param loc
	 * @return
	 */
	public static String getMessage(String key, Locale loc) {
		Locale _loc = loc;
		if (StringUtils.isEmpty(key)) {
			logger.debug("		:: Funtions getMessage Key empty");
			return "";
		}
		String _key = key.trim().replaceAll(" ", "");
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		_loc = _loc == null ? RequestContextUtils.getLocale(req) : _loc;
		String ret = null;
		try {
			ret = getMessageSource().getMessage(_key, null, _loc);
		} catch (NoSuchMessageException e) {
			logger.debug("		:: Funtions getMessage Key not found");
		}
		logger.debug("		:: Funtions getMessage : [KEY] " + key + "		[VALUE] " + ret + "		[LOCALE] " + _loc.toString());
		return ret == null ? key : ret;
	}

	/**
	 * MD5 암호화
	 * 
	 * @param data
	 * @return
	 * @throws NoSuchAlgorithmException
	 */
	public static String getMD5(String data) throws NoSuchAlgorithmException {
		MessageDigest messageDigest = MessageDigest.getInstance("MD5");
		messageDigest.update(data.getBytes(), 0, data.length());
		String hashed = new BigInteger(1, messageDigest.digest()).toString(16);
		if (hashed.length() < 32) {
			hashed = "0" + hashed;
		}

		return hashed;
	}

	/**
	 * 상세 코드값 반환
	 * 
	 * @param upcd
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	public static String getCode(String upcd, String cd) throws Exception {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		EgovCmmUseService service = (EgovCmmUseService) ApplicationHelper.getService("EgovCmmUseService", req.getSession().getServletContext());
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId(upcd);
		vo.setCode(cd);
		
		List<CmmnDetailCode> list = service.selectCmmCodeDetail(vo);
		
		if (list.size() <= 0) {
			return getMessage("errors.code.notfound");
		}
		
		return getMessage(((CmmnDetailCode) list.get(0)).getCodeNm());
	}

	/**
	 * 상세 코드 리스트 반환
	 * 
	 * @param upcd
	 * @param cd
	 * @return
	 * @throws Exception
	 */
	public static LinkedHashMap<String, String> getCodes(String upcd) throws Exception {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		EgovCmmUseService service = (EgovCmmUseService) ApplicationHelper.getService("EgovCmmUseService", req.getSession().getServletContext());
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId(upcd);
		
		LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
		if ("YN".equalsIgnoreCase(upcd)) {
			map.put("Y", "Y");
			map.put("N", "N");
		} else {
			List<CmmnDetailCode> list = service.selectCmmCodeDetail(vo);
			for (int i = 0; i < list.size(); i++) {
				CmmnDetailCode cmd = (CmmnDetailCode) list.get(i);
				map.put(cmd.getCode(), getMessage(cmd.getCodeNm()));
			}
		}
		
		return map;
	}

	/**
	 * 파일 종류 추출
	 * 
	 * @param prefix
	 * @param ext
	 * @return
	 */
	public static String getExtIcon(String prefix, String ext) {
		if (ext.contains(".xls")) {
			return prefix + "xls";
		} else if (ext.contains(".ppt")) {
			return prefix + "ppt";
		} else if (ext.contains(".doc")) {
			return prefix + "doc";
		} else if (ext.contains(".hwp")) {
			return prefix + "hwp";
		} else if (ext.contains(".pdf")) {
			return prefix + "pdf";
		} else if (ext.contains(".jpeg") || ext.contains(".jpg") || ext.contains(".png") || ext.contains(".gif")) {
			return prefix + "img";
		} else if (ext.contains(".zip")) {
			return prefix + "zip";
		}
		return "etc";
	}

	/**
	 * HTML 패턴
	 * 
	 * @author Administrator
	 *
	 */
	private static interface Patterns {
		// javascript tags and everything in between
		public static final Pattern SCRIPTS = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>", Pattern.DOTALL);

		public static final Pattern STYLE = Pattern.compile("<style[^>]*>.*</style>", Pattern.DOTALL);
		// HTML/XML tags
		public static final Pattern TAGS = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");

		@SuppressWarnings("unused")
		public static final Pattern nTAGS = Pattern.compile("<\\w+\\s+[^<]*\\s*>");
		// entity references
		public static final Pattern ENTITY_REFS = Pattern.compile("&[^;]+;");
		// repeated whitespace
		public static final Pattern WHITESPACE = Pattern.compile("\\s\\s+");
	}

	/**
	 * HTML 포멧 제거
	 * 
	 * @param s
	 * @return
	 */
	public static String getCleanHTML(String s) {
		if (s == null) {
			return null;
		}

		Matcher m;

		m = Patterns.SCRIPTS.matcher(s);
		s = m.replaceAll("");
		m = Patterns.STYLE.matcher(s);
		s = m.replaceAll("");
		m = Patterns.TAGS.matcher(s);
		s = m.replaceAll("");
		m = Patterns.ENTITY_REFS.matcher(s);
		s = m.replaceAll("");
		m = Patterns.WHITESPACE.matcher(s);
		s = m.replaceAll(" ");

		return s;
	}

	/**
	 * JSON 포멧 제거
	 * 
	 * @param s
	 * @return
	 */
	public static String getCleanJSON(String s) {
		if (s == null) {
			return null;
		}

		return s.replace("\\\\/", "\\/").replace("\\\"", "&#34;").replace("\\r\\n", "<br/>").replace("\\n", "<br/>").replace("\\\\", "\\");
	}
}