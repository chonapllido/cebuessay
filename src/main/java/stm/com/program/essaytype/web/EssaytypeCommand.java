package stm.com.program.essaytype.web;

import stm.com.generic.web.GenericCommand;

public class EssaytypeCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;
	
	private String[] type_ids;
	private String type_id;
	private String name;
	private String description;
	private String valid_flag;
	private String cdate;
	private String udate;
	/**
	 * @return the type_ids
	 */
	public String[] getType_ids() {
		return type_ids;
	}
	/**
	 * @param type_ids the type_ids to set
	 */
	public void setType_ids(String[] type_ids) {
		this.type_ids = type_ids;
	}
	
	/**
	 * @return the type_id
	 */
	public String getType_id() {
		return type_id;
	}
	/**
	 * @param type_id the type_id to set
	 */
	public void setType_id(String type_id) {
		this.type_id = type_id;
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