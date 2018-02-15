package stm.com.support.taglib;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import stm.com.support.util.Functions;

public class AButtonTag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	private String style;
	private String href;
	private String value;
	private String color;
	private String fontsize;
	private String permission;
	private String permissionshow;
	private boolean bPermission;
	private boolean bPermissionshow;

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : <a> Button");
		JspWriter out = getJspContext().getOut();
		String html = "&nbsp;";
		String iconTag = "";
		String onlyIcon = "";

		if (StringUtils.isEmpty(permission) || !"false".equals(permission)) {
			bPermission = true;
		} else {
			bPermission = false;
		}
		if (StringUtils.isEmpty(permissionshow) || "false".equals(permissionshow)) {
			bPermissionshow = false;
		} else {
			bPermissionshow = true;
		}

		if (!bPermission) {
			if (bPermissionshow) {
				href = "javascript:alert('" + Functions.getMessage("권한이없습니다") + "');";
			} else {
				out.print(html);
				super.doTag();
				return;
			}
		}

		try {
			html = Functions.getComponents("abutton");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (StringUtils.isEmpty(color)) {
			color = "color1";
		}
		if (StringUtils.isEmpty(fontsize)) {
			fontsize = "15";
		}
		if (href.contains("javascript:")) {
			href = "href=\"#" + value + "\" onclick=\"" + href.replace("javascript:", "") + ";return false;\"";
		} else {
			href = "href=\" + href + \"";
		}

		html = html.replace("[BTNTYPE]", Functions.getMessage(value, Locale.ENGLISH).toLowerCase());
		html = html.replace("[COLOR]", color);
		html = html.replace("[SIZE]", fontsize);
		html = html.replace("[TEXT]", Functions.getMessage(value));
		html = html.replace("[ACTION]", href);
		iconTag = html.substring(html.indexOf("[ICON[") + 6, html.indexOf("]ICON]"));
		onlyIcon = html.substring(html.indexOf("[ONLY ICON[") + 11, html.indexOf("]ONLY ICON]"));
		if (style != null && onlyIcon.toUpperCase().equals("ICON")) {
			html = html.replace("[ICON[", "").replace("]ICON]", "");
			html = html.replace(onlyIcon, "");
			html = html.replace("[ONLY ICON[", "").replace("]ONLY ICON]", "");
			html = html.replace("[TEXT HEAD]", "head");
			html = html.replace("[ONLY TEXT]", "&nbsp;");
		} else if (style != null && onlyIcon.toUpperCase().equals("TEXT")) {
			html = html.replace("[ICON[" + iconTag + "]ICON]", "");
			html = html.replace("[TEXT HEAD]", "text head");
			html = html.replace("[ONLY TEXT]", Functions.getMessage(value));
		} else {
			html = html.replace("[ICON[", "").replace("]ICON]", "");
			html = html.replace("[ONLY ICON[", "").replace("]ONLY ICON]", "");
			html = html.replace("[ONLY TEXT]", value);
			html = html.replace("[TEXT HEAD]", Functions.getMessage(value));
		}

		out.print(html);

		super.doTag();
	}

	/**
	 * @return the style
	 */
	public String getStyle() {
		return style;
	}

	/**
	 * @param style
	 *            the style to set
	 */
	public void setStyle(String style) {
		this.style = style;
	}

	/**
	 * @return the href
	 */
	public String getHref() {
		return href;
	}

	/**
	 * @param href
	 *            the href to set
	 */
	public void setHref(String href) {
		this.href = href;
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

	/**
	 * @return the color
	 */
	public String getColor() {
		return color;
	}

	/**
	 * @param color
	 *            the color to set
	 */
	public void setColor(String color) {
		this.color = color;
	}

	/**
	 * @return the fontsize
	 */
	public String getFontsize() {
		return fontsize;
	}

	/**
	 * @param fontsize
	 *            the fontsize to set
	 */
	public void setFontsize(String fontsize) {
		this.fontsize = fontsize;
	}

	/**
	 * @return the permission
	 */
	public String getPermission() {
		return permission;
	}

	/**
	 * @param permission
	 *            the permission to set
	 */
	public void setPermission(String permission) {
		this.permission = permission;
	}

	/**
	 * @return the permissionshow
	 */
	public String getPermissionshow() {
		return permissionshow;
	}

	/**
	 * @param permissionshow
	 *            the permissionshow to set
	 */
	public void setPermissionshow(String permissionshow) {
		this.permissionshow = permissionshow;
	}

	/**
	 * @return the bPermission
	 */
	public boolean isbPermission() {
		return bPermission;
	}

	/**
	 * @param bPermission
	 *            the bPermission to set
	 */
	public void setbPermission(boolean bPermission) {
		this.bPermission = bPermission;
	}

	/**
	 * @return the bPermissionshow
	 */
	public boolean isbPermissionshow() {
		return bPermissionshow;
	}

	/**
	 * @param bPermissionshow
	 *            the bPermissionshow to set
	 */
	public void setbPermissionshow(boolean bPermissionshow) {
		this.bPermissionshow = bPermissionshow;
	}
}