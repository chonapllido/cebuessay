package stm.com.support.taglib;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import stm.com.support.util.Functions;

public class CodeTag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private String upcd;
	private String cd;

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : Code");
		JspWriter out = getJspContext().getOut();
		
		String html;
		try {
			html = Functions.getCode(upcd, cd);
			out.print(html);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.print(Functions.getMessage("errors.code.notfound"));
			e.printStackTrace();
		}

		super.doTag();
	}

	/**
	 * @return the upcd
	 */
	public String getUpcd() {
		return upcd;
	}

	/**
	 * @param upcd
	 *            the upcd to set
	 */
	public void setUpcd(String upcd) {
		this.upcd = upcd;
	}

	/**
	 * @return the cd
	 */
	public String getCd() {
		return cd;
	}

	/**
	 * @param cd
	 *            the cd to set
	 */
	public void setCd(String cd) {
		this.cd = cd;
	}
}