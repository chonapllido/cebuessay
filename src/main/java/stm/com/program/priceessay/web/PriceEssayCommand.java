package stm.com.program.priceessay.web;

import stm.com.generic.web.GenericCommand;

public class PriceEssayCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] price_ids;
	private String price_id;
	private String title;
	private String page;
	private String words;
	private String days;
	private String price;
	private String maxpage;
	private String special;
	private String cdate;
	private String udate;
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
	 * @return the price_id
	 */
	public String getPrice_id() {
		return price_id;
	}
	/**
	 * @param price_id the price_id to set
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
	/**
	 * @return the special
	 */
	public String getSpecial() {
		return special;
	}
	/**
	 * @param special the special to set
	 */
	public void setSpecial(String special) {
		this.special = special;
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