package stm.com.support.mail;

public class MailCommand {
	
	private String sendFrom;
	private String sendTo;
	private String[] sendToM;
	private String fromName;
	private String subject;
	private String message;
	private String attachment;
	
	/**
	 * @return the sendFrom
	 */
	public String getSendFrom() {
		return sendFrom;
	}
	/**
	 * @param sendFrom the sendFrom to set
	 */
	public void setSendFrom(String sendFrom) {
		this.sendFrom = sendFrom;
	}
	/**
	 * @return the sendTo
	 */
	public String getSendTo() {
		return sendTo;
	}
	/**
	 * @param sendTo the sendTo to set
	 */
	public void setSendTo(String sendTo) {
		this.sendTo = sendTo;
	}
	
	/**
	 * @return the sendToM
	 */
	public String getSendToM() {
		return sendTo;
	}
	/**
	 * @param sendTo the sendTo to set
	 */
	public void setSendToM(String[] sendToM) {
		this.sendToM = sendToM;
	}
	
	/**
	 * @return the fromName
	 */
	public String getFromName() {
		return fromName;
	}
	/**
	 * @param fromName the fromName to set
	 */
	public void setFromName(String fromName) {
		this.fromName = fromName;
	}
	/**
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return the attachment
	 */
	public String getAttachment() {
		return attachment;
	}
	/**
	 * @param attachment the attachment to set
	 */
	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}
	
}
