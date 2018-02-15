package stm.com.support.taglib;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

public class DateTag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private String format;
	private String value;

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : Date");
		JspWriter out = getJspContext().getOut();
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		if (StringUtils.isEmpty(value)) {
			super.doTag();
			return;
		}
		
		try {
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
			Date d = df.parse(value);

			DateFormat _df = new SimpleDateFormat(format, RequestContextUtils.getLocale(req));
			out.print(_df.format(d));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		super.doTag();
	}

	/**
	 * @return the format
	 */
	public String getFormat() {
		return format;
	}

	/**
	 * @param format
	 *            the format to set
	 */
	public void setFormat(String format) {
		this.format = format;
	}

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

}