package stm.com.program.user.web;

import stm.com.generic.web.GenericCommand;

public class UserCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] user_ids;
	private String position_id;
	private String name;
	private String password;
	private String telephone;
	private String gender;
	private String country;
	private String salary;
	private String user_price;
	private String blacklist;
	private String virtual_money;
	private String activation_key;
	private String date;
	private String date_modifed;
	private String valid_flag;
	
	private String search_email;
	private String search_price;
	
	private String user_total_order;
	private String user_total_payment;
	
	/**
	 * @return the user_ids
	 */
	public String[] getUser_ids() {
		return user_ids;
	}
	/**
	 * @param user_ids the user_ids to set
	 */
	public void setUser_ids(String[] user_ids) {
		this.user_ids = user_ids;
	}
	/**
	 * @return the position_id
	 */
	public String getPosition_id() {
		return position_id;
	}
	/**
	 * @param position_id the position_id to set
	 */
	public void setPosition_id(String position_id) {
		this.position_id = position_id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the telephone
	 */
	public String getTelephone() {
		return telephone;
	}
	/**
	 * @param telephone the telephone to set
	 */
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
	 * @return the country
	 */
	public String getCountry() {
		return country;
	}
	/**
	 * @param country the country to set
	 */
	public void setCountry(String country) {
		this.country = country;
	}
	/**
	 * @return the salary
	 */
	public String getSalary() {
		return salary;
	}
	/**
	 * @param salary the salary to set
	 */
	public void setSalary(String salary) {
		this.salary = salary;
	}
	/**
	 * @return the user_price
	 */
	public String getUser_price() {
		return user_price;
	}
	/**
	 * @param user_price the user_price to set
	 */
	public void setUser_price(String user_price) {
		this.user_price = user_price;
	}
	/**
	 * @return the blacklist
	 */
	public String getBlacklist() {
		return blacklist;
	}
	/**
	 * @param blacklist the blacklist to set
	 */
	public void setBlacklist(String blacklist) {
		this.blacklist = blacklist;
	}
	/**
	 * @return the virtual_money
	 */
	public String getVirtual_money() {
		return virtual_money;
	}
	/**
	 * @param virtual_money the virtual_money to set
	 */
	public void setVirtual_money(String virtual_money) {
		this.virtual_money = virtual_money;
	}
	/**
	 * @return the activation_key
	 */
	public String getActivation_key() {
		return activation_key;
	}
	/**
	 * @param activation_key the activation_key to set
	 */
	public void setActivation_key(String activation_key) {
		this.activation_key = activation_key;
	}
	/**
	 * @return the date
	 */
	public String getDate() {
		return date;
	}
	/**
	 * @param date the date to set
	 */
	public void setDate(String date) {
		this.date = date;
	}
	/**
	 * @return the date_modifed
	 */
	public String getDate_modifed() {
		return date_modifed;
	}
	/**
	 * @param date_modifed the date_modifed to set
	 */
	public void setDate_modifed(String date_modifed) {
		this.date_modifed = date_modifed;
	}
	/**
	 * @return the valid_flag
	 */
	public String getValid_flag() {
		return valid_flag;
	}
	/**
	 * @param valid_flag the valid_flag to set
	 */
	public void setValid_flag(String valid_flag) {
		this.valid_flag = valid_flag;
	}
	
	/**
	 * @return the search_email
	 */
	public String getSearch_email() {
		return search_email;
	}
	/**
	 * @param search_email the search_email to set
	 */
	public void setSearch_email(String search_email) {
		this.search_email = search_email;
	}
	/**
	 * @return the search_price
	 */
	public String getSearch_price() {
		return search_price;
	}
	/**
	 * @param search_price the search_price to set
	 */
	public void setSearch_price(String search_price) {
		this.search_price = search_price;
	}
	/**
	 * @return the user_total_order
	 */
	public String getUser_total_order() {
		return user_total_order;
	}
	/**
	 * @param user_total_order the user_total_order to set
	 */
	public void setUser_total_order(String user_total_order) {
		this.user_total_order = user_total_order;
	}
	/**
	 * @return the user_total_payment
	 */
	public String getUser_total_payment() {
		return user_total_payment;
	}
	/**
	 * @param user_total_payment the user_total_payment to set
	 */
	public void setUser_total_payment(String user_total_payment) {
		this.user_total_payment = user_total_payment;
	}
	
}