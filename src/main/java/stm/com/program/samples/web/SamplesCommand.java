package stm.com.program.samples.web;

import stm.com.generic.web.GenericCommand;

public class SamplesCommand extends GenericCommand {

	private static final long serialVersionUID = 1L;
	
	private String[] sample_ids;
	private String sample_id;
	private String type;
	private String title;
	private String file;
	private String file_type;
	private String cdate;
	private String udate;
	/**
	 * @return the sample_ids
	 */
	public String[] getSample_ids() {
		return sample_ids;
	}
	/**
	 * @param sample_ids the sample_ids to set
	 */
	public void setSample_ids(String[] sample_ids) {
		this.sample_ids = sample_ids;
	}
	/**
	 * @return the sample_id
	 */
	public String getSample_id() {
		return sample_id;
	}
	/**
	 * @param sample_id the sample_id to set
	 */
	public void setSample_id(String sample_id) {
		this.sample_id = sample_id;
	}
	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
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
	 * @return the file_type
	 */
	public String getFile_type() {
		return file_type;
	}
	/**
	 * @param file_type the file_type to set
	 */
	public void setFile_type(String file_type) {
		this.file_type = file_type;
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