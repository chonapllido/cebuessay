package stm.com.program.readmaterial.web;

import stm.com.generic.web.GenericCommand;

public class ReadMaterialCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String id;
	private String description;
	private String pages;
	private String days;
	private String price;
	private String cdate;
	private String udate;

	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the pages
	 */
	public String getPages() {
		return pages;
	}
	/**
	 * @param pages the pages to set
	 */
	public void setPages(String pages) {
		this.pages = pages;
	}
	/**
	 * @return the days
	 */
	public String getDays() {
		return days;
	}
	/**
	 * @param days the days to set
	 */
	public void setDays(String days) {
		this.days = days;
	}
	/**
	 * @return the price
	 */
	public String getPrice() {
		return price;
	}
	/**
	 * @param price the price to set
	 */
	public void setPrice(String price) {
		this.price = price;
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