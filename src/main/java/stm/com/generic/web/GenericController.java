package stm.com.generic.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import stm.com.generic.service.GenericService;
import stm.com.support.excel.web.ExcelCommand;
import stm.com.support.util.Functions;
import stm.com.sys.Configs;
import stm.com.sys.Constants;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovFileDownloadController;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * Generic Controller
 * 
 * @author Park sung hyun
 * 
 * @param <S>
 * @param <C>
 */
public class GenericController<S extends GenericService<C>, C extends GenericCommand> {

	@Autowired
	private ApplicationContext applicationContext;
	@Qualifier
	private S service;
	@Autowired
	private EgovFileMngService fileMngService; // 첨부파일 Service
	@Autowired
	private EgovPropertyService propertyService;
	@Autowired
	private EgovFileMngUtil fileUtil;
	@Autowired
	private DefaultBeanValidator beanValidator;

	private Class<S> serviceClass;
	private String base_url; // 호출된 URL
	private String params; // QueryString을 담을 변수
	private String add_sep; // 각종 프로그램을 다중으로 사용하기 위한 프로그램 분기를 위한 변수
	private String view; // Tiles의 ID와 매핑하기 위한 변수
	private String thumb_at; // 첨부시 썸네일 생성 여부
	private String thumb_size; // 첨부시 썸네일 사이즈
	private Map<String, Object> excelBeans; // 엑셀 내용 빈 (다운로드시)
	private static final Logger logger = LoggerFactory.getLogger(GenericController.class);

	@SuppressWarnings("unchecked")
	public GenericController() {
		RequestMapping rm = this.getClass().getAnnotation(RequestMapping.class);
		this.serviceClass = (Class<S>) GenericUtils.getClassOfGenericTypeIn(getClass(), 0);
		this.base_url = rm.value()[0];
		this.params = "";
		this.add_sep = "";
		this.view = "";
		this.excelBeans = new HashMap<String, Object>();
		this.thumb_at = "N";
		this.thumb_size = "80;100"; // ;로 구분한다
	}

	@PostConstruct
	public void setUp() {
		this.service = applicationContext.getBean(serviceClass);

	}

	/**
	 * 로그 찍기
	 * 
	 * @param cmd
	 */
	protected void logging(C cmd) {
		logger.debug("		:: Controller : " + getClass().getName());
		logger.debug("		:: ServiceClass : " + service.getClass().getName());
		logger.debug("		:: CommandClass : " + cmd.getClass().getName());
		logger.debug("		:: Base Url : " + this.base_url);
		logger.debug("		:: Tiles View : " + this.view);
		logger.debug("		:: Add Separator : " + this.add_sep);
		logger.debug("		:: QueryString : " + this.params);
	}

	/**
	 * Generic 함수 전처리 전 필터역할 함수
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @throws Exception
	 */
	protected void wrapper(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		logging(cmd);
	}

	/**
	 * 사용자 정보 얻기
	 * 
	 * @return
	 */
	public LoginVO getUser() {
		LoginVO vo = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (vo != null) {
			return vo;
		}
		return null;
	}

	/**
	 * 비어있는 ModelAndView 호출 함수
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	protected ModelAndView mav() throws Exception {
		ModelAndView mav = new ModelAndView();
		GenericCommand cmd = new GenericCommand();
		return mav(mav, (C) cmd);
	}

	/**
	 * ModelAndView 호출 함수
	 * 
	 * @param cmd
	 * @return
	 * @throws Exception
	 */
	protected ModelAndView mav(C cmd) throws Exception {
		ModelAndView mav = new ModelAndView();
		return mav(mav, cmd);
	}

	/**
	 * ModelAndView 호출 함수
	 * 
	 * @param mav
	 * @param cmd
	 * @return
	 * @throws Exception
	 */
	protected ModelAndView mav(ModelAndView mav, C cmd) throws Exception {
		String vm = base_url + view + add_sep;

		mav.addObject(Constants.PARAMS, Functions.getQueryString() + params);
		mav.setViewName(vm);
		logger.debug("		:: Call Tiles View : " + vm);
		return mav;
	}

	/**
	 * callback.jsp 호출
	 * 
	 * @param callbackValue
	 * @return
	 * @throws Exception
	 */
	protected ModelAndView callback(Object callbackValue) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.addObject(Constants.PARAMS, Functions.getQueryString() + params);
		mav.addObject(Constants.CALLBACK_VALUE, callbackValue);
		mav.setViewName(Constants.CALLBACK_VIEW);
		logger.debug("		:: Call Callback Tiles View : " + Constants.CALLBACK_VIEW);
		return mav;
	}

	/**
	 * callback.jsp 호출
	 * 
	 * @param callbackValue
	 * @return
	 * @throws Exception
	 */
	protected String redirectCallback(String callbackValue) throws Exception {
		String url = "redirect:callback.do";
		url += (url.contains("?") ? "&" : "?") + Functions.getQueryString() + params;
		url += (url.contains("?") ? "&" : "?") + Constants.CALLBACK_VALUE + "=" + callbackValue;
		logger.debug("		:: Call Callback URL : " + url);
		return url;
	}

	/**
	 * Generic 함수 전처리
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @throws Exception
	 */
	protected void preControl(C cmd, HttpServletRequest req, HttpServletResponse res, ModelAndView mav) throws Exception {
		if (StringUtils.isEmpty(cmd.getLanguage())) {
			cmd.setLanguage(Functions.getLanguage());
		}

		logger.debug("		:: Call Pre Control ");
	}

	/**
	 * Generic 함수 후처리
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @param mav
	 * @throws Exception
	 */
	protected void postControl(C cmd, HttpServletRequest req, HttpServletResponse res, ModelAndView mav) throws Exception {
		logger.debug("		:: Call Post Control ");
	}

	/**
	 * 중복 Submit 방지를 위한 설정
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @param mav
	 * @param key
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	@SuppressWarnings("unchecked")
	protected void setProtectSubmit(C cmd, HttpServletRequest req, HttpServletResponse res, ModelAndView mav, String key) throws InstantiationException, IllegalAccessException {
		String token_key = key;

		C _cmd = (C) cmd.getClass().newInstance();
		mav.addObject(Constants.TOKEN, _cmd);
		if (StringUtils.isEmpty(token_key)) {
			token_key = req.getRequestURI();
		}
		// Key 값에 업무별로 고유한 키를 사용하여 여러 업무에 서로 간섭되지 않기 위함
		req.getSession().setAttribute(Constants.TOKEN + "_" + token_key, cmd);
		logger.debug("		:: Set Protected Submit : " + Constants.TOKEN + "_" + token_key + "=" + cmd);
	}

	/**
	 * 중복 Submit 인지 확인
	 * 
	 * @param req
	 * @param key
	 * @return
	 */
	protected boolean isProtectSubmit(HttpServletRequest req, String key) {
		String token_key = key;

		if (StringUtils.isEmpty(token_key)) {
			token_key = req.getRequestURI();
		}

		if (req.getSession().getAttribute(Constants.TOKEN + "_" + token_key) == null) {
			logger.debug("		:: [!!!] Double Submit Prevented.");
			return false;
		}

		req.getSession().removeAttribute(Constants.TOKEN + "_" + token_key);
		logger.debug("		:: Remove Protected Submit : " + Constants.TOKEN + "_" + token_key);
		return true;
	}

	/**
	 * 모든 파라메터를 포함한 redirect
	 * 
	 * @return
	 * @throws Exception
	 */
	protected String redirect() throws Exception {
		return redirect(null);
	}

	/**
	 * 특정 파라메터를 제외한 redirect
	 * 
	 * @param queryStringException
	 * @return
	 * @throws Exception
	 */
	protected String redirect(String queryStringException) throws Exception {
		String redirect = "redirect:" + base_url + view + ".do?" + Functions.getQueryString(queryStringException) + params;
		logger.debug("		:: " + redirect);
		return redirect;
	}

	/**
	 * Generic List
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/list.do")
	public ModelAndView list(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		preControl(cmd, req, res, mav);
		wrapper(cmd, req, res);
		view = "/list";

		cmd.setPage_use_at(StringUtils.defaultIfEmpty(cmd.getPage_use_at(), "Y"));
		cmd.setPage_count_use_at(StringUtils.defaultIfEmpty(cmd.getPage_count_use_at(), "Y"));

		/** pageing setting */
		if (cmd.getCurrent_page_no() <= 0) {
			cmd.setCurrent_page_no(1);
		}
		if (cmd.getRecord_count_per_page() <= 0) {
			cmd.setRecord_count_per_page(propertyService.getInt("pageUnit"));
		}
		if (cmd.getPage_size() <= 0) {
			cmd.setPage_size(propertyService.getInt("pageSize"));
		}

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(cmd.getCurrent_page_no());
		paginationInfo.setRecordCountPerPage(cmd.getRecord_count_per_page());
		paginationInfo.setPageSize(cmd.getPage_size());

		cmd.setFirst_index(paginationInfo.getFirstRecordIndex());
		cmd.setLast_index(paginationInfo.getLastRecordIndex());
		cmd.setRecord_count_per_page(paginationInfo.getRecordCountPerPage());

		mav.addObject(Constants.CMD_VALUE, service.getList(cmd, req, res));

		paginationInfo.setTotalRecordCount(cmd.getTotal_record_count());
		mav.addObject("paginationInfo", paginationInfo);

		postControl(cmd, req, res, mav);
		return mav(mav, cmd);
	}

	/**
	 * Callback URL 직접 호출..
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/callback.do")
	public ModelAndView callback(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		return callback(req.getParameter(Constants.CALLBACK_VALUE));
	}

	/**
	 * Generic View
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/view.do")
	public ModelAndView view(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		preControl(cmd, req, res, mav);
		wrapper(cmd, req, res);
		view = "/view";

		cmd = service.getView(cmd, req, res);
		mav.addObject(Constants.CMD_VALUE, cmd);

		postControl(cmd, req, res, mav);
		return mav(mav, cmd);
	}

	/**
	 * Generic Insert (Get)
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert.do", method = RequestMethod.GET)
	public ModelAndView insert(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		preControl(cmd, req, res, mav);
		wrapper(cmd, req, res);
		view = "/write";

		setProtectSubmit(cmd, req, res, mav, null);
		postControl(cmd, req, res, mav);
		return mav(mav, cmd);
	}

	/**
	 * Generic Update (Get)
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.GET)
	public ModelAndView update(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mav = new ModelAndView();
		preControl(cmd, req, res, mav);
		wrapper(cmd, req, res);
		view = "/write";

		mav.addObject(service.getView(cmd, req, res));

		setProtectSubmit(cmd, req, res, mav, null);
		postControl(cmd, req, res, mav);
		return mav(mav, cmd);
	}

	/**
	 * Generic Insert (Post)
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @param status
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "/insert.do", method = RequestMethod.POST)
	public String insert(@ModelAttribute(Constants.TOKEN) C cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status, BindingResult bindingResult) throws FileNotFoundException, IOException, Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		beanValidator.validate(cmd, bindingResult); // validation 수행
		if (bindingResult.hasErrors()) { // 만일 validation 에러가 있으면...
			return redirectCallback("validator");
		}

		if (isProtectSubmit(req, null)) {
			
			List<FileVO> _result = new ArrayList<FileVO>(); // 2012.11 KISA 보안조치
			String _atchFileId = null;
			final Map<String, MultipartFile> files = multireq.getFileMap();
			if (!files.isEmpty()) {
				_result = fileUtil.parseFileInf(files, "STM_", cmd.getFile_sns(), "", "", this.thumb_at, this.thumb_size);
				_atchFileId = fileMngService.insertFileInfs(_result); // 파일이 생성되고나면 생성된 첨부파일 ID를 리턴한다.
			}
			cmd.setAtch_file_id(_atchFileId);

			service.insert(cmd, req, res);
		}

		return redirect();
	}

	/**
	 * Generic Update (Post)
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @param status
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public String update(@ModelAttribute(Constants.TOKEN) C cmd, final MultipartHttpServletRequest multireq, HttpServletRequest req, HttpServletResponse res, SessionStatus status) throws FileNotFoundException, IOException, Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		if (isProtectSubmit(req, null)) {

			final Map<String, MultipartFile> files = multireq.getFileMap();
			if (!files.isEmpty()) {

				if ("".equals(cmd.getAtch_file_id())) {
					List<FileVO> result = fileUtil.parseFileInf(files, "STM_", cmd.getFile_sns(), "", "", this.thumb_at, this.thumb_size);
					String atchFileId = fileMngService.insertFileInfs(result);
					cmd.setAtch_file_id(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(cmd.getAtch_file_id());
					List<FileVO> _result = fileUtil.parseFileInf(files, "STM_", cmd.getFile_sns(), cmd.getAtch_file_id(), "", this.thumb_at, this.thumb_size);
					fileMngService.updateFileInfs(_result);
				}

			}

			service.update(cmd, req, res);
		}

		postControl(cmd, req, res, null);
		return redirect("*_seq");
	}

	/**
	 * Generic Update List
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateList.do")
	public String updateList(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		service.updateList(cmd, req, res);

		postControl(cmd, req, res, null);
		return redirect();
	}

	/**
	 * Generic Update List
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/updateListForAll.do")
	public String updateListForAll(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		service.updateListForAll(cmd, req, res);

		postControl(cmd, req, res, null);
		return redirect();
	}

	/**
	 * Generic Delete
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/delete.do")
	public String delete(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		service.delete(cmd, req, res);

		postControl(cmd, req, res, null);
		return redirect("*_seq");
	}

	/**
	 * Generic Delete List
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteList.do")
	public String deleteList(@ModelAttribute C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		preControl(cmd, req, res, null);
		wrapper(cmd, req, res);
		view = "/list";

		service.deleteList(cmd, req, res);

		postControl(cmd, req, res, null);
		return redirect();
	}

	/**
	 * 엑셀 작업
	 * 
	 * @param cmd
	 * @param req
	 * @param res
	 * @param excelCmd
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/excel.do")
	public void excel(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		ExcelCommand excelCmd = new ExcelCommand();

		excelCmd.setBase_file_nm("template");
		excelCmd.setDes_file_nm("리스트");

		cmd.setPage_use_at("N");
		cmd = getService().getList(cmd, req, res);

		excelBeans.put(Constants.CMD_VALUE, cmd);

		excel(excelCmd, req, res);
	}

	protected void excel(ExcelCommand excelCmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		if (excelCmd == null || StringUtils.isEmpty(excelCmd.getBase_file_nm())) {
			logger.error("		:: Excel File Name is not be NULL");
		}
		String key = UUID.randomUUID().toString();

		excelCmd.setBase_dir("" + Configs.DOC_PATH);
		excelCmd.setDes_dir("" + Configs.TEMP_PATH);

		String of = excelCmd.getBase_dir() + File.separator + excelCmd.getBase_file_nm() + ".xlsx";
		String df = excelCmd.getDes_dir() + File.separator + key + ".xlsx";

		if (StringUtils.isEmpty(excelCmd.getDes_file_nm())) {
			excelCmd.setDes_file_nm(key);
		}

		File dir = new File(excelCmd.getDes_dir());
		if (false == dir.exists()) {
			dir.mkdirs();
		}

		// 엑셀 작업
		XLSTransformer transformer = new XLSTransformer();
		transformer.transformXLS(of, excelBeans, df);

		// 다운로드
		// fileUtil.downFile(res, of, excelCmd.getDes_file_nm());

		FileVO fileVO = new FileVO();
		fileVO.setFileStreCours(excelCmd.getDes_dir());
		fileVO.setStreFileNm(key + ".xlsx");
		fileVO.setOrignlFileNm(excelCmd.getDes_file_nm() + ".xlsx");

		EgovFileDownloadController dc = new EgovFileDownloadController();
		dc.download(fileVO, req, res);
	}

	/**
	 * Service 얻기
	 * 
	 * @return the service
	 */
	public S getService() {
		return service;
	}

	/**
	 * Service 대입
	 * 
	 * @param service
	 *            the service to set
	 */
	public void setService(S service) {
		this.service = service;
	}

	/**
	 * 첨부를 위한 Service 얻기
	 * 
	 * @return the fileMngService
	 */
	public EgovFileMngService getEgovFileMngService() {
		return fileMngService;
	}

	/**
	 * 첨부를 위한 Service 대입
	 * 
	 * @param fileMngService
	 *            the fileMngService to set
	 */
	public void setEgovFileMngService(EgovFileMngService fileMngService) {
		this.fileMngService = fileMngService;
	}

	/**
	 * 호출된 URL
	 * 
	 * @return the base_url
	 */
	public String getBase_url() {
		return base_url;
	}

	/**
	 * 호출된 URL
	 * 
	 * @param base_url
	 *            the base_url to set
	 */
	public void setBase_url(String base_url) {
		this.base_url = base_url;
	}

	/**
	 * QueryString을 담을 변수
	 * 
	 * @return the params
	 */
	public String getParams() {
		return params;
	}

	/**
	 * QueryString을 담을 변수
	 * 
	 * @param params
	 *            the params to set
	 */
	public void setParams(String params) {
		this.params = params;
	}

	/**
	 * 각종 프로그램을 다중으로 사용하기 위한 프로그램 분기를 위한 변수
	 * 
	 * @return the add_sep
	 */
	public String getAdd_sep() {
		return add_sep;
	}

	/**
	 * 각종 프로그램을 다중으로 사용하기 위한 프로그램 분기를 위한 변수
	 * 
	 * @param add_sep
	 *            the add_sep to set
	 */
	public void setAdd_sep(String add_sep) {
		this.add_sep = add_sep;
	}

	/**
	 * Tiles의 ID와 매핑하기 위한 변수
	 * 
	 * @return the view
	 */
	public String getView() {
		return view;
	}

	/**
	 * Tiles의 ID와 매핑하기 위한 변수
	 * 
	 * @param view
	 *            the view to set
	 */
	public void setView(String view) {
		this.view = view;
	}

	/**
	 * @return the excelBeans
	 */
	public Map<String, Object> getExcelBeans() {
		return excelBeans;
	}

	/**
	 * @param excelBeans
	 *            the excelBeans to set
	 */
	public void setExcelBeans(Map<String, Object> excelBeans) {
		this.excelBeans = excelBeans;
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
}
