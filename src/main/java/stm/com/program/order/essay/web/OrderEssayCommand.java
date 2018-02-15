package stm.com.program.order.essay.web;

import stm.com.generic.web.GenericCommand;

public class OrderEssayCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;

	private String[] essay_ids;
	private String essay_id;
	private String order_id;
	private String manager_id;
	private String writer_id;
	private String topic;
	private String category;
	private String essay_type;
	private String format;
	private String no_pages;
	private String read_material;
	private String no_sources;
	private String preferred_writer;
	private String in_intro;
	private String in_body;
	private String in_conclusion;
	private String file;
	private String file_upload;
	private String subtotal;
	private String discount;
	private String total_payment;
	private String pay_method;
	private String days;
	private String status;
	private String start_date;
	private String end_date;
	private String date_modified;
	private String result;
	private String valid_flag;
	private String level;
	/**
	 * @return the essay_ids
	 */
	public String[] getEssay_ids() {
		return essay_ids;
	}
	/**
	 * @param essay_ids the essay_ids to set
	 */
	public void setEssay_ids(String[] essay_ids) {
		this.essay_ids = essay_ids;
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
	 * @return the topic_id
	 */
	public String getTopic() {
		return topic;
	}
	/**
	 * @param topic_id the topic_id to set
	 */
	public void setTopic(String topic) {
		this.topic = topic;
	}
	/**
	 * @return the category_id
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category_id the category_id to set
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return the essay_type
	 */
	public String getEssay_type() {
		return essay_type;
	}
	/**
	 * @param essay_type the essay_type to set
	 */
	public void setEssay_type(String essay_type) {
		this.essay_type = essay_type;
	}
	/**
	 * @return the format
	 */
	public String getFormat() {
		return format;
	}
	/**
	 * @param format the format to set
	 */
	public void setFormat(String format) {
		this.format = format;
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
	 * @return the read_material
	 */
	public String getRead_material() {
		return read_material;
	}
	/**
	 * @param read_material the read_material to set
	 */
	public void setRead_material(String read_material) {
		this.read_material = read_material;
	}
	/**
	 * @return the no_sources
	 */
	public String getNo_sources() {
		return no_sources;
	}
	/**
	 * @param no_sources the no_sources to set
	 */
	public void setNo_sources(String no_sources) {
		this.no_sources = no_sources;
	}
	/**
	 * @return the preferred_writer
	 */
	public String getPreferred_writer() {
		return preferred_writer;
	}
	/**
	 * @param preferred_writer the preferred_writer to set
	 */
	public void setPreferred_writer(String preferred_writer) {
		this.preferred_writer = preferred_writer;
	}
	/**
	 * @return the in_intro
	 */
	public String getIn_intro() {
		return in_intro;
	}
	/**
	 * @param in_intro the in_intro to set
	 */
	public void setIn_intro(String in_intro) {
		this.in_intro = in_intro;
	}
	/**
	 * @return the in_body
	 */
	public String getIn_body() {
		return in_body;
	}
	/**
	 * @param in_body the in_body to set
	 */
	public void setIn_body(String in_body) {
		this.in_body = in_body;
	}
	/**
	 * @return the in_conclusion
	 */
	public String getIn_conclusion() {
		return in_conclusion;
	}
	/**
	 * @param in_conclusion the in_conclusion to set
	 */
	public void setIn_conclusion(String in_conclusion) {
		this.in_conclusion = in_conclusion;
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
	
}