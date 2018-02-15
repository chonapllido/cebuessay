package stm.com.program.order.revision.web;

import stm.com.generic.web.GenericCommand;

public class OrderRevisionCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] revision_ids;
	private String revision_id;
	private String order_id;
	private String manager_id;
	private String writer_id;
	private String topic;
	private String no_pages;
	private String pay_method;
	private String file;
	private String file_upload;
	private String file_upload_tmp;
	private String status;
	private String total_payment;
	private String days;
	private String result;
	private String level;
	private String start_date;
	private String end_date;
	private String date_modified;
	private String valid_flag;
	/**
	 * @return the revision_ids
	 */
	public String[] getRevision_ids() {
		return revision_ids;
	}
	/**
	 * @param revision_ids the revision_ids to set
	 */
	public void setRevision_ids(String[] revision_ids) {
		this.revision_ids = revision_ids;
	}
	/**
	 * @return the revision_id
	 */
	public String getRevision_id() {
		return revision_id;
	}
	/**
	 * @param revision_id the revision_id to set
	 */
	public void setRevision_id(String revision_id) {
		this.revision_id = revision_id;
	}
	/**
	 * @return the order_id
	 */
	public String getOrder_id() {
		return order_id;
	}
	/**
	 * @param order_id the order_id to set
	 */
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	/**
	 * @return the manager_id
	 */
	public String getManager_id() {
		return manager_id;
	}
	/**
	 * @param manager_id the manager_id to set
	 */
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	/**
	 * @return the writer_id
	 */
	public String getWriter_id() {
		return writer_id;
	}
	/**
	 * @param writer_id the writer_id to set
	 */
	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}
	/**
	 * @return the topic
	 */
	public String getTopic() {
		return topic;
	}
	/**
	 * @param topic the topic to set
	 */
	public void setTopic(String topic) {
		this.topic = topic;
	}
	/**
	 * @return the no_pages
	 */
	public String getNo_pages() {
		return no_pages;
	}
	/**
	 * @param no_pages the no_pages to set
	 */
	public void setNo_pages(String no_pages) {
		this.no_pages = no_pages;
	}
	/**
	 * @return the pay_method
	 */
	public String getPay_method() {
		return pay_method;
	}
	/**
	 * @param pay_method the pay_method to set
	 */
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	/**
	 * @return the file
	 */
	public String getFile() {
		return file;
	}
	/**
	 * @param file the file to set
	 */
	public void setFile(String file) {
		this.file = file;
	}
	/**
	 * @return the file_upload
	 */
	public String getFile_upload() {
		return file_upload;
	}
	/**
	 * @param file_upload the file_upload to set
	 */
	public void setFile_upload(String file_upload) {
		this.file_upload = file_upload;
	}
	/**
	 * @return the file_upload_tmp
	 */
	public String getFile_upload_tmp() {
		return file_upload_tmp;
	}
	/**
	 * @param file_upload_tmp the file_upload_tmp to set
	 */
	public void setFile_upload_tmp(String file_upload_tmp) {
		this.file_upload_tmp = file_upload_tmp;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return the total_payment
	 */
	public String getTotal_payment() {
		return total_payment;
	}
	/**
	 * @param total_payment the total_payment to set
	 */
	public void setTotal_payment(String total_payment) {
		this.total_payment = total_payment;
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
	 * @return the result
	 */
	public String getResult() {
		return result;
	}
	/**
	 * @param result the result to set
	 */
	public void setResult(String result) {
		this.result = result;
	}
	/**
	 * @return the level
	 */
	public String getLevel() {
		return level;
	}
	/**
	 * @param level the level to set
	 */
	public void setLevel(String level) {
		this.level = level;
	}
	/**
	 * @return the start_date
	 */
	public String getStart_date() {
		return start_date;
	}
	/**
	 * @param start_date the start_date to set
	 */
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	/**
	 * @return the end_date
	 */
	public String getEnd_date() {
		return end_date;
	}
	/**
	 * @param end_date the end_date to set
	 */
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	/**
	 * @return the date_modified
	 */
	public String getDate_modified() {
		return date_modified;
	}
	/**
	 * @param date_modified the date_modified to set
	 */
	public void setDate_modified(String date_modified) {
		this.date_modified = date_modified;
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

}