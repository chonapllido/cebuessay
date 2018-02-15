package stm.com.program.ordcomplete.web;

import stm.com.generic.web.GenericCommand;

public class OrderCompleteCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] order_ids;
	private String order_id;
	private String user_email;
	private String user_name;
	private String type_id;
	private String manager_id;
	private String essay_id;
	private String writer_id;
	private String subtotal;
	private String discount;
	private String total_payment;
	private String pay_method;
	private String topic;
	private String days;
	private String date;
	private String start_date;
	private String end_date;
	private String date_modified;
	private String status;
	private String view_time;
	private String upload_time;
	private String refunded;
	private String result;
	private String paid_but_cancelled;
	private String valid_flag;
	private String delete_flag;
	private String blacklist;
	
	/**
	 * @return the order_ids
	 */
	public String[] getOrder_ids() {
		return order_ids;
	}
	/**
	 * @param order_ids the order_ids to set
	 */
	public void setOrder_ids(String[] order_ids) {
		this.order_ids = order_ids;
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
	 * @return the user_email
	 */
	public String getUser_email() {
		return user_email;
	}
	/**
	 * @param user_email the user_email to set
	 */
	public void setUser_email(String user_email) {
		this.user_email = user_email;
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
	 * @return the essay_id
	 */
	public String getEssay_id() {
		return essay_id;
	}
	/**
	 * @param essay_id the essay_id to set
	 */
	public void setEssay_id(String essay_id) {
		this.essay_id = essay_id;
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
	 * @return the subtotal
	 */
	public String getSubtotal() {
		return subtotal;
	}
	/**
	 * @param subtotal the subtotal to set
	 */
	public void setSubtotal(String subtotal) {
		this.subtotal = subtotal;
	}
	/**
	 * @return the discount
	 */
	public String getDiscount() {
		return discount;
	}
	/**
	 * @param discount the discount to set
	 */
	public void setDiscount(String discount) {
		this.discount = discount;
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
	 * @return the view_time
	 */
	public String getView_time() {
		return view_time;
	}
	/**
	 * @param view_time the view_time to set
	 */
	public void setView_time(String view_time) {
		this.view_time = view_time;
	}
	/**
	 * @return the upload_time
	 */
	public String getUpload_time() {
		return upload_time;
	}
	/**
	 * @param upload_time the upload_time to set
	 */
	public void setUpload_time(String upload_time) {
		this.upload_time = upload_time;
	}
	/**
	 * @return the refunded
	 */
	public String getRefunded() {
		return refunded;
	}
	/**
	 * @param refunded the refunded to set
	 */
	public void setRefunded(String refunded) {
		this.refunded = refunded;
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
	 * @return the paid_but_cancelled
	 */
	public String getPaid_but_cancelled() {
		return paid_but_cancelled;
	}
	/**
	 * @param paid_but_cancelled the paid_but_cancelled to set
	 */
	public void setPaid_but_cancelled(String paid_but_cancelled) {
		this.paid_but_cancelled = paid_but_cancelled;
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
	 * @return the delete_flag
	 */
	public String getDelete_flag() {
		return delete_flag;
	}
	/**
	 * @param delete_flag the delete_flag to set
	 */
	public void setDelete_flag(String delete_flag) {
		this.delete_flag = delete_flag;
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
	
}