package stm.com.program.pricerevision.web;

import stm.com.generic.web.GenericCommand;

public class PriceRevisionCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] price_ids;
	private String price_id;
	private String title;
	private String page;
	private String words;
	private String days;
	private String price;
	private String cdate;
	private String udate;
	private String maxpage;
	/**
	 * @return the price_ids
	 */
	public String[] getPrice_ids() {
		return price_ids;
	}
	/**
	 * @param price_ids the price_ids to set
	 */
	public void setPrice_ids(String[] price_ids) {
		this.price_ids = price_ids;
	}
	/**
	 * @return the private_id
	 */
	public String getPrice_id() {
		return price_id;
	}
	/**
	 * @param private_id the price_id to set
	 */
	public void setPrice_id(String price_id) {
		this.price_id = price_id;
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
	 * @return the page
	 */
	public String getPage() {
		return page;
	}
	/**
	 * @param page the page to set
	 */
	public void setPage(String page) {
		this.page = page;
	}
	/**
	 * @return the words
	 */
	public String getWords() {
		return words;
	}
	/**
	 * @param words the words to set
	 */
	public void setWords(String words) {
		this.words = words;
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
	/**
	 * @return the maxpage
	 */
	public String getMaxpage() {
		return maxpage;
	}
	/**
	 * @param maxpage the maxpage to set
	 */
	public void setMaxpage(String maxpage) {
		this.maxpage = maxpage;
	}
	
	
}