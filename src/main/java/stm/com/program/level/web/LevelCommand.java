package stm.com.program.level.web;

import stm.com.generic.web.GenericCommand;

public class LevelCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] level_ids;
	private String level_id;
	private String title;
	private String cdate;
	private String udate;
	/**
	 * @return the level_ids
	 */
	public String[] getLevel_ids() {
		return level_ids;
	}
	/**
	 * @param level_ids the level_ids to set
	 */
	public void setLevel_ids(String[] level_ids) {
		this.level_ids = level_ids;
	}
	/**
	 * @return the level_id
	 */
	public String getLevel_id() {
		return level_id;
	}
	/**
	 * @param level_id the level_id to set
	 */
	public void setLevel_id(String level_id) {
		this.level_id = level_id;
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