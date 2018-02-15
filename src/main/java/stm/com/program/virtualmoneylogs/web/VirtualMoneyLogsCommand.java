package stm.com.program.virtualmoneylogs.web;

import stm.com.generic.web.GenericCommand;

public class VirtualMoneyLogsCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] log_ids;
	private String log_id;
	private String user_name;
	private String date_from;
	private String date_end;
	private String date_performed;
	/**
	 * @return the log_ids
	 */
	public String[] getLog_ids() {
		return log_ids;
	}
	/**
	 * @param log_ids the log_ids to set
	 */
	public void setLog_ids(String[] log_ids) {
		this.log_ids = log_ids;
	}
	/**
	 * @return the log_id
	 */
	public String getLog_id() {
		return log_id;
	}
	/**
	 * @param log_id the log_id to set
	 */
	public void setLog_id(String log_id) {
		this.log_id = log_id;
	}
	/**
	 * @return the user_name
	 */
	public String getUser_name() {
		return user_name;
	}
	/**
	 * @param user_name the user_name to set
	 */
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	/**
	 * @return the date_from
	 */
	public String getDate_from() {
		return date_from;
	}
	/**
	 * @param date_from the date_from to set
	 */
	public void setDate_from(String date_from) {
		this.date_from = date_from;
	}
	/**
	 * @return the date_end
	 */
	public String getDate_end() {
		return date_end;
	}
	/**
	 * @param date_end the date_end to set
	 */
	public void setDate_end(String date_end) {
		this.date_end = date_end;
	}
	/**
	 * @return the date_performed
	 */
	public String getDate_performed() {
		return date_performed;
	}
	/**
	 * @param date_performed the date_performed to set
	 */
	public void setDate_performed(String date_performed) {
		this.date_performed = date_performed;
	}
	
	
}