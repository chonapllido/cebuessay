package stm.com.program.category.web;

import stm.com.generic.web.GenericCommand;

public class CategoryCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] category_ids;
	private String category_id;
	private String title;
	private String cdate;
	private String udate;
	/**
	 * @return the category_ids
	 */
	public String[] getCategory_ids() {
		return category_ids;
	}
	/**
	 * @param category_ids the category_ids to set
	 */
	public void setCategory_ids(String[] category_ids) {
		this.category_ids = category_ids;
	}
	/**
	 * @return the category_id
	 */
	public String getCategory_id() {
		return category_id;
	}
	/**
	 * @param category_id the category_id to set
	 */
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
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