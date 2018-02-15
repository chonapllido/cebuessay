package stm.com.support.taglib;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import stm.com.support.util.Functions;

public class MessageTag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private String key;
	private Locale locale;

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : Message");
		JspWriter out = getJspContext().getOut();
		String html = key;
		html = Functions.getMessage(key, locale);
		out.print(html);

		super.doTag();
	}

	/**
	 * @return the key
	 */
	public String getKey() {
		return key;
	}

	/**
	 * @param key
	 *            the key to set
	 */
	public void setKey(String key) {
		this.key = key;
	}

	/**
	 * @return the locale
	 */
	public Locale getLocale() {
		return locale;
	}

	/**
	 * @param locale
	 *            the locale to set
	 */
	public void setLocale(Locale locale) {
		this.locale = locale;
	}

}