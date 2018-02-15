package stm.com.program.writingformat.web;

import stm.com.generic.web.GenericCommand;

public class WritingFormatCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] format_ids;
	private String format_id;
	private String title;
	private String cdate;
	private String udate;
	/**
	 * @return the format_ids
	 */
	public String[] getFormat_ids() {
		return format_ids;
	}
	/**
	 * @param format_ids the format_ids to set
	 */
	public void setFormat_ids(String[] format_ids) {
		this.format_ids = format_ids;
	}
	/**
	 * @return the format_id
	 */
	public String getFormat_id() {
		return format_id;
	}
	/**
	 * @param format_id the format_id to set
	 */
	public void setFormat_id(String format_id) {
		this.format_id = format_id;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the cdate
	 */
	public String getCdate() {
		return cdate;
	}
	/**
	 * @param cdate the cdate to set
	 */
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	/**
	 * @return the udate
	 */
	public String getUdate() {
		return udate;
	}
	/**
	 * @param udate the udate to set
	 */
	public void setUdate(String udate) {
		this.udate = udate;
	}
	
}