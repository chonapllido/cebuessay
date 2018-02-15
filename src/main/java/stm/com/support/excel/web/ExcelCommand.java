package stm.com.support.excel.web;

import org.springframework.web.multipart.MultipartFile;

public class ExcelCommand {

	private MultipartFile excel_file;
	private String base_file_nm;
	private String des_file_nm;
	private String base_dir;
	private String des_dir;

	/**
	 * @return the excel_file
	 */
	public MultipartFile getExcel_file() {
		return excel_file;
	}

	/**
	 * @param excel_file
	 *            the excel_file to set
	 */
	public void setExcel_file(MultipartFile excel_file) {
		this.excel_file = excel_file;
	}

	/**
	 * @return the base_file_nm
	 */
	public String getBase_file_nm() {
		return base_file_nm;
	}

	/**
	 * @param base_file_nm
	 *            the base_file_nm to set
	 */
	public void setBase_file_nm(String base_file_nm) {
		this.base_file_nm = base_file_nm;
	}

	/**
	 * @return the des_file_nm
	 */
	public String getDes_file_nm() {
		return des_file_nm;
	}

	/**
	 * @param des_file_nm
	 *            the des_file_nm to set
	 */
	public void setDes_file_nm(String des_file_nm) {
		this.des_file_nm = des_file_nm;
	}

	/**
	 * @return the base_dir
	 */
	public String getBase_dir() {
		return base_dir;
	}

	/**
	 * @param base_dir
	 *            the base_dir to set
	 */
	public void setBase_dir(String base_dir) {
		this.base_dir = base_dir;
	}

	/**
	 * @return the des_dir
	 */
	public String getDes_dir() {
		return des_dir;
	}

	/**
	 * @param des_dir
	 *            the des_dir to set
	 */
	public void setDes_dir(String des_dir) {
		this.des_dir = des_dir;
	}
}
