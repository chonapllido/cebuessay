package stm.com.generic.web;

import java.io.Serializable;
import java.util.List;

public class GenericCommand implements Serializable {

	private static final long serialVersionUID = 1L;

	private String user_id;
	private String user_nm;
	private String user_sep;
	private String email;
	private String atch_file_id;
	private String use_at;
	private String del_at;
	private String frst_regist_pnttm;
	private String frst_register_id;
	private String frst_register_nm;
	private String last_updt_pnttm;
	private String last_updusr_id;
	private String last_updusr_nm;
	private String[] ids;
	private String[] id_checks;

	private String language;
	private String lang;
	private String search_use_at;
	private String search_field;
	private String search_keyword;
	private String file_sn;
	private String[] file_sns;
	private String thumb_at;
	private String thumb_size;

	private int ordr;
	private int current_page_no;
	private int record_count_per_page;
	private int first_index;
	private int last_index;
	private int total_record_count;
	private int page_size;
	private String page_use_at;
	private String page_count_use_at;
	private int news;
	private List<?> list;
	private List<?> sub_list;

	/**
	 * @return the user_id
	 */
	public final String getUser_id() {
		return user_id;
	}

	/**
	 * @param user_id
	 *            the user_id to set
	 */
	public final void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	/**
	 * @return the user_nm
	 */
	public final String getUser_nm() {
		return user_nm;
	}

	/**
	 * @param user_nm
	 *            the user_nm to set
	 */
	public final void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}

	/**
	 * @return the email
	 */
	public final String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public final void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the atch_file_id
	 */
	public final String getAtch_file_id() {
		return atch_file_id;
	}

	/**
	 * @param atch_file_id
	 *            the atch_file_id to set
	 */
	public final void setAtch_file_id(String atch_file_id) {
		this.atch_file_id = atch_file_id;
	}

	/**
	 * @return the use_at
	 */
	public final String getUse_at() {
		return use_at;
	}

	/**
	 * @param use_at
	 *            the use_at to set
	 */
	public final void setUse_at(String use_at) {
		this.use_at = use_at;
	}

	/**
	 * @return the del_at
	 */
	public final String getDel_at() {
		return del_at;
	}

	/**
	 * @param del_at
	 *            the del_at to set
	 */
	public final void setDel_at(String del_at) {
		this.del_at = del_at;
	}

	/**
	 * @return the frst_regist_pnttm
	 */
	public final String getFrst_regist_pnttm() {
		return frst_regist_pnttm;
	}

	/**
	 * @param frst_regist_pnttm
	 *            the frst_regist_pnttm to set
	 */
	public final void setFrst_regist_pnttm(String frst_regist_pnttm) {
		this.frst_regist_pnttm = frst_regist_pnttm;
	}

	/**
	 * @return the frst_register_id
	 */
	public final String getFrst_register_id() {
		return frst_register_id;
	}

	/**
	 * @param frst_register_id
	 *            the frst_register_id to set
	 */
	public final void setFrst_register_id(String frst_register_id) {
		this.frst_register_id = frst_register_id;
	}

	/**
	 * @return the frst_register_nm
	 */
	public final String getFrst_register_nm() {
		return frst_register_nm;
	}

	/**
	 * @param frst_register_nm
	 *            the frst_register_nm to set
	 */
	public final void setFrst_register_nm(String frst_register_nm) {
		this.frst_register_nm = frst_register_nm;
	}

	/**
	 * @return the last_updt_pnttm
	 */
	public final String getLast_updt_pnttm() {
		return last_updt_pnttm;
	}

	/**
	 * @param last_updt_pnttm
	 *            the last_updt_pnttm to set
	 */
	public final void setLast_updt_pnttm(String last_updt_pnttm) {
		this.last_updt_pnttm = last_updt_pnttm;
	}

	/**
	 * @return the last_updusr_id
	 */
	public final String getLast_updusr_id() {
		return last_updusr_id;
	}

	/**
	 * @param last_updusr_id
	 *            the last_updusr_id to set
	 */
	public final void setLast_updusr_id(String last_updusr_id) {
		this.last_updusr_id = last_updusr_id;
	}

	/**
	 * @return the last_updusr_nm
	 */
	public final String getLast_updusr_nm() {
		return last_updusr_nm;
	}

	/**
	 * @param last_updusr_nm
	 *            the last_updusr_nm to set
	 */
	public final void setLast_updusr_nm(String last_updusr_nm) {
		this.last_updusr_nm = last_updusr_nm;
	}

	/**
	 * @return the ids
	 */
	public final String[] getIds() {
		return ids;
	}

	/**
	 * @param ids
	 *            the ids to set
	 */
	public final void setIds(String[] ids) {
		this.ids = ids;
	}

	/**
	 * @return the id_checks
	 */
	public final String[] getId_checks() {
		return id_checks;
	}

	/**
	 * @param id_checks
	 *            the id_checks to set
	 */
	public final void setId_checks(String[] id_checks) {
		this.id_checks = id_checks;
	}

	/**
	 * @return the language
	 */
	public final String getLanguage() {
		return language;
	}

	/**
	 * @param language
	 *            the language to set
	 */
	public final void setLanguage(String language) {
		this.language = language;
	}

	/**
	 * @return the lang
	 */
	public final String getLang() {
		return lang;
	}

	/**
	 * @param lang
	 *            the lang to set
	 */
	public final void setLang(String lang) {
		this.lang = lang;
	}

	/**
	 * @return the search_use_at
	 */
	public final String getSearch_use_at() {
		return search_use_at;
	}

	/**
	 * @param search_use_at
	 *            the search_use_at to set
	 */
	public final void setSearch_use_at(String search_use_at) {
		this.search_use_at = search_use_at;
	}

	/**
	 * @return the search_field
	 */
	public final String getSearch_field() {
		return search_field;
	}

	/**
	 * @param search_field
	 *            the search_field to set
	 */
	public final void setSearch_field(String search_field) {
		this.search_field = search_field;
	}

	/**
	 * @return the search_keyword
	 */
	public final String getSearch_keyword() {
		return search_keyword;
	}

	/**
	 * @param search_keyword
	 *            the search_keyword to set
	 */
	public final void setSearch_keyword(String search_keyword) {
		this.search_keyword = search_keyword;
	}

	/**
	 * @return the file_sn
	 */
	public final String getFile_sn() {
		return file_sn;
	}

	/**
	 * @param file_sn
	 *            the file_sn to set
	 */
	public final void setFile_sn(String file_sn) {
		this.file_sn = file_sn;
	}

	/**
	 * @return the file_sns
	 */
	public final String[] getFile_sns() {
		return file_sns;
	}

	/**
	 * @param file_sns
	 *            the file_sns to set
	 */
	public final void setFile_sns(String[] file_sns) {
		this.file_sns = file_sns;
	}

	/**
	 * @return the thumb_at
	 */
	public final String getThumb_at() {
		return thumb_at;
	}

	/**
	 * @param thumb_at
	 *            the thumb_at to set
	 */
	public final void setThumb_at(String thumb_at) {
		this.thumb_at = thumb_at;
	}

	/**
	 * @return the thumb_size
	 */
	public final String getThumb_size() {
		return thumb_size;
	}

	/**
	 * @param thumb_size
	 *            the thumb_size to set
	 */
	public final void setThumb_size(String thumb_size) {
		this.thumb_size = thumb_size;
	}

	/**
	 * @return the ordr
	 */
	public final int getOrdr() {
		return ordr;
	}

	/**
	 * @param ordr
	 *            the ordr to set
	 */
	public final void setOrdr(int ordr) {
		this.ordr = ordr;
	}

	/**
	 * @return the current_page_no
	 */
	public final int getCurrent_page_no() {
		return current_page_no;
	}

	/**
	 * @param current_page_no
	 *            the current_page_no to set
	 */
	public final void setCurrent_page_no(int current_page_no) {
		this.current_page_no = current_page_no;
	}

	/**
	 * @return the record_count_per_page
	 */
	public final int getRecord_count_per_page() {
		return record_count_per_page;
	}

	/**
	 * @param record_count_per_page
	 *            the record_count_per_page to set
	 */
	public final void setRecord_count_per_page(int record_count_per_page) {
		this.record_count_per_page = record_count_per_page;
	}

	/**
	 * @return the first_index
	 */
	public final int getFirst_index() {
		return first_index;
	}

	/**
	 * @param first_index
	 *            the first_index to set
	 */
	public final void setFirst_index(int first_index) {
		this.first_index = first_index;
	}

	/**
	 * @return the last_index
	 */
	public final int getLast_index() {
		return last_index;
	}

	/**
	 * @param last_index
	 *            the last_index to set
	 */
	public final void setLast_index(int last_index) {
		this.last_index = last_index;
	}

	/**
	 * @return the total_record_count
	 */
	public final int getTotal_record_count() {
		return total_record_count;
	}

	/**
	 * @param total_record_count
	 *            the total_record_count to set
	 */
	public final void setTotal_record_count(int total_record_count) {
		this.total_record_count = total_record_count;
	}

	/**
	 * @return the page_size
	 */
	public final int getPage_size() {
		return page_size;
	}

	/**
	 * @param page_size
	 *            the page_size to set
	 */
	public final void setPage_size(int page_size) {
		this.page_size = page_size;
	}

	/**
	 * @return the page_use_at
	 */
	public final String getPage_use_at() {
		return page_use_at;
	}

	/**
	 * @param page_use_at
	 *            the page_use_at to set
	 */
	public final void setPage_use_at(String page_use_at) {
		this.page_use_at = page_use_at;
	}

	/**
	 * @return the page_count_use_at
	 */
	public final String getPage_count_use_at() {
		return page_count_use_at;
	}

	/**
	 * @param page_count_use_at
	 *            the page_count_use_at to set
	 */
	public final void setPage_count_use_at(String page_count_use_at) {
		this.page_count_use_at = page_count_use_at;
	}

	/**
	 * @return the news
	 */
	public final int getNews() {
		return news;
	}

	/**
	 * @param news
	 *            the news to set
	 */
	public final void setNews(int news) {
		this.news = news;
	}

	/**
	 * @return the list
	 */
	public final List<?> getList() {
		return list;
	}

	/**
	 * @param list
	 *            the list to set
	 */
	public final void setList(List<?> list) {
		this.list = list;
	}

	/**
	 * @return the sub_list
	 */
	public final List<?> getSub_list() {
		return sub_list;
	}

	/**
	 * @param sub_list
	 *            the sub_list to set
	 */
	public final void setSub_list(List<?> sub_list) {
		this.sub_list = sub_list;
	}

	/**
	 * @return the user_sep
	 */
	public final String getUser_sep() {
		return user_sep;
	}

	/**
	 * @param user_sep
	 *            the user_sep to set
	 */
	public final void setUser_sep(String user_sep) {
		this.user_sep = user_sep;
	}
}
