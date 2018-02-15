package stm.com.support.taglib;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import stm.com.support.util.Functions;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class Paging1Tag extends SimpleTagSupport {

	private final Logger logger = LoggerFactory.getLogger(getClass());

	@Override
	public void doTag() throws JspException, IOException {
		// TODO Auto-generated method stub
		logger.debug("		:: Tag Library : Paging1");
		JspWriter out = getJspContext().getOut();
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String html = "";

		try {
			html = Functions.getComponents("paging1");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// Paging
		PaginationInfo cmd = new PaginationInfo();
		cmd = (PaginationInfo) req.getAttribute("paginationInfo");

		int total_page = ((cmd.getTotalRecordCount() % cmd.getRecordCountPerPage() == 0 ? cmd.getTotalRecordCount() : cmd.getTotalRecordCount() + cmd.getRecordCountPerPage()) / cmd.getRecordCountPerPage());
		int current_page = cmd.getCurrentPageNo();
		int page_start = 0;
		int page_end = 0;

		if (total_page - (current_page - 1) > 10) {
			page_start = current_page;
			page_end = current_page + 9;
			if (current_page > 1) {
				page_start = current_page - 1;
				page_end = current_page + 8;
			} else if (current_page > 2) {
				page_start = current_page - 2;
				page_end = current_page + 7;
			}
		} else {
			page_start = 1;
			page_end = total_page;
			if (current_page > 10) {
				page_start = total_page - 9;

				if (total_page - (current_page - 1) > 9) {
					page_start--;
					page_end--;
				}
			}
		}

		// Replace
		String loop = "";
		String loop_text = "";
		String uri = (String) req.getAttribute("javax.servlet.forward.request_uri");

		html = html.replace("[URL]", uri);
		html = html.replace("[PARAM]", Functions.getQueryString("current_page_no"));
		html = html.replace("[FIRST_TITLE]", "1 " + Functions.getMessage("페이지"));
		String prev = Integer.toString(current_page != 1 ? current_page - 1 : 1);
		html = html.replace("[PREV]", prev);
		html = html.replace("[PREV_TITLE]", prev + " " + Functions.getMessage("페이지"));
		String next = Integer.toString(total_page != current_page ? current_page + 1 : total_page);
		html = html.replace("[NEXT]", next);
		html = html.replace("[NEXT_TITLE]", next + " " + Functions.getMessage("페이지"));
		String last = Integer.toString(total_page);
		html = html.replace("[LAST]", last);
		html = html.replace("[LAST_TITLE]", last + " " + Functions.getMessage("페이지"));

		loop_text = html.substring(html.indexOf("[LOOP[") + 6, html.indexOf("]LOOP]"));
		for (int i = (page_start < 1 ? 1 : page_start); i < page_end + 1; i++) {
			loop += loop_text.replace("[PAGE]", Integer.toString(i)).replace("[PAGE_TITLE]", Integer.toString(i) + " " + Functions.getMessage("페이지")) + "\n";
			if (current_page == i) {
				loop = loop.replace("[ON]", "now-page");
			} else {
				loop = loop.replace("[ON]", "");
			}
		}
		
		if(page_end == 1){
			html = html.replace("[HIDE]", "");
		} else {
			html = html.replace("[HIDE]", "hide");
		}
		
		if(total_page == 0){
			html = html.replace("[HIDE]", "hide");
		}
		
		html = html.replace("[LOOP[" + loop_text + "]LOOP]", loop);
		html = html.replace("[PAGE]", "" + current_page);
		out.print(html);

		super.doTag();
	}
}