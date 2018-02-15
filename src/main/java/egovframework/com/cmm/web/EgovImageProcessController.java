package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovResourceCloseHelper;
import egovframework.rte.ptl.mvc.bind.annotation.CommandMap;

/**
 * @Class Name : EgovImageProcessController.java
 * @Description :
 * @Modification Information
 *
 *               수정일 수정자 수정내용 ---------- --------- ------------------- 2009.04.02 이삼섭 최초생성 2014.03.31 유지보수 fileSn 오류수정
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
@Controller
public class EgovImageProcessController extends HttpServlet {

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	private static final Logger LOGGER = LoggerFactory.getLogger(EgovImageProcessController.class);

	/**
	 * 미리보기 화면 추가
	 * 
	 * @param sessionVO
	 * @param model
	 * @param commandMap
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/getImagePreview.do")
	public String getImagePreview(SessionVO sessionVO, ModelMap model, @CommandMap Map<String, Object> commandMap, HttpServletResponse response) throws Exception {
		return "egovframework/com/cmm/fms/EgovImagePreview";
	}

	/**
	 * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
	 *
	 * @param atchFileId
	 * @param fileSn
	 * @param sessionVO
	 * @param model
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/cmm/fms/getImage.do")
	public void getImageInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		// @RequestParam("atchFileId") String atchFileId,
		// @RequestParam("fileSn") String fileSn,
		String atchFileId = (String) commandMap.get("atchFileId");
		String fileSn = (String) commandMap.get("fileSn");
		String thumbSize = (String) commandMap.get("thumbSize");
		String data = (String) commandMap.get("data");
		String sepCode = (String) commandMap.get("sepCode");
		String recDiv = (String) commandMap.get("recDiv");

		FileVO vo = new FileVO();

		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);

		// ------------------------------------------------------------
		// fileSn이 없는 경우 마지막 파일 참조
		// ------------------------------------------------------------
		if (fileSn == null || fileSn.equals("")) {
			int newMaxFileSN = fileService.getMaxFileSN(vo);
			vo.setFileSn(Integer.toString(newMaxFileSN - 1));
		}
		// ------------------------------------------------------------

		FileVO fvo = fileService.selectFileInf(vo);

		if (fvo == null && !StringUtils.isEmpty(data)) {
			if ("A".equals(sepCode) || "C".equals(sepCode)) {
				// 교직원 사진가져오기
				String imgPath = "/kuis/photo/ngen/nper04/COMMIT";
				if (data.indexOf(".") != -1 && data.indexOf("@") == -1) {
					int idx = data.lastIndexOf(".");
					data = URLEncoder.encode(data.substring(0, idx), "UTF-8") + data.substring(idx);
				}

				if (data.indexOf("@") != -1) {
					imgPath = "/kuis/photo/ngen/nper99/COMMIT";
				} else {
					imgPath = "/kuis/photo/ngen/nper04/COMMIT";
				}

				ModelAndView mav = new ModelAndView();
				mav.setViewName("redirect:http://gms.korea.ac.kr:8050/jsp/imageDownload.jsp?type=photo&file_path=" + imgPath + "&Reg_file_nm=" + data);
				throw new ModelAndViewDefiningException(mav);
			} else if ("D".equals(sepCode)) {
				// 학생사진 가져오기
				vo.setRecDiv(recDiv);
				vo.setStdId(data);

				fvo = new FileVO();
				fvo = fileService.selectStdPicture(vo);

				byte[] b = null;
				try {
					b = (byte[]) fvo.getBlobData();
				} catch (Exception e) {
					return;
				}

				response.setContentType("Content-type: image/jpeg");
				response.setHeader("Content-disposition", "attachment; filename=Picture.jpg");
				OutputStream out = response.getOutputStream();

				out.write(b);
				out.flush();
			}
			return;
		}

		// 썸네일을 호출한 경우
		if (!StringUtils.isEmpty(thumbSize)) {
			fvo.setStreFileNm(fvo.getStreFileNm() + "_" + thumbSize);
			fvo.setFileExtsn("jpg");
		}

		// String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		try {
			file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
			// 썸네일을 호출했는데 파일이 없다면 원본 이미지를 선택한다
			if (!StringUtils.isEmpty(thumbSize)) {
				if (!file.exists()) {
					file = new File(fvo.getFileStreCours(), fvo.getStreFileNm().replaceAll("_" + thumbSize, ""));
				}
			}
			fis = new FileInputStream(file);

			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();

			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}

			String type = "";

			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
				if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
					type = "image/jpeg";
				} else {
					type = "image/" + fvo.getFileExtsn().toLowerCase();
				}
				type = "image/" + fvo.getFileExtsn().toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}

			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();

		} finally {
			EgovResourceCloseHelper.close(bStream, in, fis);
		}
	}
}
