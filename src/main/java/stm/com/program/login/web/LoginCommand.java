package stm.com.program.login.web;

import stm.com.generic.web.GenericCommand;

public class LoginCommand extends GenericCommand{

	private static final long serialVersionUID = 1L;

	private String name;
	private String blacklist;
	private String user_price;
	private String virtual_money;
	private String position_id;

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
	
}