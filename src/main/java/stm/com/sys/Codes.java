package stm.com.sys;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class Codes {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	public Codes(ServletContext context) throws Exception {
//		Map<String, LinkedHashMap<String, String>> codes = new HashMap<String, LinkedHashMap<String, String>>();
//		CodeService service = (CodeService) ApplicationHelper.getService("codeService", context);
//		CodeCommand cmd = new CodeCommand();
//		cmd.setList(service.getCodes(cmd));
//
//		for (int i = 0; i < cmd.getList().size(); i++) {
//			CodeCommand _cmd = new CodeCommand();
//			_cmd = (CodeCommand) cmd.getList().get(i);
//
//			logger.debug("			:: System Code Data : [Main Key] " + _cmd.getCd_id());
//
//			LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();
//			for (int j = 0; j < _cmd.getList().size(); j++) {
//				CodeCommand __cmd = new CodeCommand();
//				__cmd = (CodeCommand) _cmd.getList().get(j);
//				map.put(__cmd.getCd_id(), __cmd.getCd_nm());
//
//				logger.debug("			:: System Code Data : 		[Sub Key] " + __cmd.getCd_id() + "		[Value] " + __cmd.getCd_nm());
//			}
//
//			codes.put(_cmd.getCd_id(), map);
//		}
//
//		context.setAttribute(Constants.CODES, codes);
	}

	/**
	 * 코드값 얻기
	 * 
	 * @param context
	 * @param key
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static LinkedHashMap<String, String> get(ServletContext context, String key) {
		Map<String, LinkedHashMap<String, String>> codes = new HashMap<String, LinkedHashMap<String, String>>();
		codes = (Map<String, LinkedHashMap<String, String>>) context.getAttribute(Constants.CODES);
		return codes.get(key);
	}

	/**
	 * 코드값 얻기 (RequestContextHolder 이용)
	 * 
	 * @param key
	 * @return
	 */
	public static LinkedHashMap<String, String> get(String key) {
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return get(req.getSession().getServletContext(), key);
	}

	/**
	 * 서브 코드값 얻기
	 * 
	 * @param context
	 * @param key
	 * @param subkey
	 * @return
	 */
	public static String get(ServletContext context, String key, String subkey) {
		return ((LinkedHashMap<String, String>) get(context, key)).get(subkey);
	}

	/**
	 * 서브 코드값 얻기 (RequestContextHolder 이용)
	 * 
	 * @param key
	 * @param subkey
	 * @return
	 */
	public static String get(String key, String subkey) {
		return ((LinkedHashMap<String, String>) get(key)).get(subkey);
	}
}
