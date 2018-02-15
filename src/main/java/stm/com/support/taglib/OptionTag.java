package stm.com.support.taglib;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import stm.com.support.util.Functions;

public class OptionTag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private Object object;
	private String select;
	private String exception;

	@SuppressWarnings("unchecked")
	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : Option");
		JspWriter out = getJspContext().getOut();

		String html = "";

		if (StringUtils.isEmpty(select)) {
			select = "";
		}

		boolean bExcept = false;
		logger.debug("		:: Option Exception : " + exception);
		if (object instanceof LinkedHashMap) {
			for (Entry<String, String> el : ((LinkedHashMap<String, String>) object).entrySet()) {
				logger.debug("		:: Option : " + ((select.equals(el.getKey())) ? "[SELECTED]" : "") + " [KEY] " + el.getKey() + "		[VALUE] " + Functions.getMessage(el.getValue()));

				if (!StringUtils.isEmpty(exception)) {
					String[] e = exception.split(";");
					for (int i = 0; i < e.length; i++) {
						bExcept = false;
						if (el.getKey().equals(e[i])) {
							bExcept = true;
							continue;
						}
					}
					if (bExcept) {
						continue;
					}
				}
				html += "<option value=\"" + el.getKey() + "\" " + ((select.equals(el.getKey())) ? "selected=\"selected\"" : "") + ">" + Functions.getMessage(el.getValue()) + "</option>";
			}
		} else if (object instanceof Map) {
			for (Entry<String, String> el : ((Map<String, String>) object).entrySet()) {
				logger.debug("		:: Option : " + ((select.equals(el.getKey())) ? "[SELECTED]" : "") + " [KEY] " + el.getKey() + "		[VALUE] " + Functions.getMessage(el.getValue()));
				
				if (!StringUtils.isEmpty(exception)) {
					String[] e = exception.split(";");
					for (int i = 0; i < e.length; i++) {
						bExcept = false;
						if (el.getKey().equals(e[i])) {
							bExcept = true;
							continue;
						}
					}
					if (bExcept) {
						continue;
					}
				}
				html += "<option value=\"" + el.getKey() + "\" " + ((select.equals(el.getKey())) ? "selected=\"selected\"" : "") + ">" + Functions.getMessage(el.getValue()) + "</option>";
			}
		} else if (object instanceof List) {
			Iterator<String> el = ((List<String>) object).iterator();
			while (el.hasNext()) {
				logger.debug("		:: Option : " + ((select.equals(el.next())) ? "[SELECTED]" : "") + " [KEY] " + el.next() + "		[VALUE] " + Functions.getMessage(el.next()));

				if (!StringUtils.isEmpty(exception)) {
					String[] e = exception.split(";");
					for (int i = 0; i < e.length; i++) {
						bExcept = false;
						if (el.next().equals(e[i])) {
							bExcept = true;
							continue;
						}
					}
					if (bExcept) {
						continue;
					}
				}
				html += "<option value=\"" + el.next() + "\" " + ((select.equals(el.next())) ? "selected=\"selected\"" : "") + ">" + Functions.getMessage(el.next()) + "</option>";
			}
		}

		out.print(html);
		super.doTag();
	}

	/**
	 * @return the object
	 */
	public Object getObject() {
		return object;
	}

	/**
	 * @param object
	 *            the object to set
	 */
	public void setObject(Object object) {
		this.object = object;
	}

	/**
	 * @return the select
	 */
	public String getSelect() {
		return select;
	}

	/**
	 * @param select
	 *            the select to set
	 */
	public void setSelect(String select) {
		this.select = select;
	}

	/**
	 * @return the exception
	 */
	public String getException() {
		return exception;
	}

	/**
	 * @param exception
	 *            the exception to set
	 */
	public void setException(String exception) {
		this.exception = exception;
	}
}