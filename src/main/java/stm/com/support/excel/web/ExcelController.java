package stm.com.support.excel.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import stm.com.support.util.Functions;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;

@Controller
public class ExcelController {

	@Autowired
	private EgovFileMngUtil fileUtil;
	@Autowired
	private EgovFileMngService fileMngService; // 첨부파일 Service

	@RequestMapping(value = "/excel.do", method = RequestMethod.GET)
	public ModelAndView upload(@ModelAttribute ExcelCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("support.excel");

		return mav;
	}

	@RequestMapping(value = "/excel.do", method = RequestMethod.POST)
	public ModelAndView upload(@ModelAttribute ExcelCommand cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("support.callback");

		final Map<String, MultipartFile> files = multireq.getFileMap();
		InputStream fis = null; // 2011.11.1 보안점검 후속조치

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;

		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();

			file = entry.getValue();
			if (!"".equals(file.getOriginalFilename())) {
				// 2011.10.07 업로드 파일에 대한 확장자를 체크
				if (file.getOriginalFilename().endsWith(".xls") || file.getOriginalFilename().endsWith(".xlsx") || file.getOriginalFilename().endsWith(".XLS") || file.getOriginalFilename().endsWith(".XLSX")) {

					// 2011.10.21 보안점검 후속조치
					try {
						fis = file.getInputStream();
						/*String loc = req.getParameter("loc");
						if (loc.contains("/student/list")) {
							StudentService service = (StudentService) ApplicationHelper.getService("studentService", req.getSession().getServletContext());
							service.insertExcel(fis, req, excelUserService);
						} else if (loc.contains("/user/list")) {
							excelUserService.uploadExcel("stm.com.program.user.service.impl.UserDao.insert", file.getInputStream(), 2, (long) 5000, new XSSFWorkbook());
						} else if (loc.contains("/course/list")) {
							excelCourseService.uploadExcel("stm.com.program.extend.course.service.impl.CourseDao.insert", file.getInputStream(), 2, (long) 5000, new XSSFWorkbook());
						} else if (loc.contains("/subject/list")) {
							excelSubjectService.uploadExcel("stm.com.program.extend.subject.service.impl.SubjectDao.insert", file.getInputStream(), 2, (long) 5000, new XSSFWorkbook());
						}*/
					} catch (Exception e) {
						throw e;
					} finally {
						if (fis != null) // 2011.11.1 보안점검 후속조치
							fis.close();
					}

				} else {
					mav.setViewName("redirect:/excel.do?" + Functions.getQueryString() + "&message=엑셀만 업로드 가능합니다");
				}
			}
		}

		return mav;
	}

}
