package stm.com.generic.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import stm.com.generic.service.GenericService;
import stm.com.generic.web.GenericCommand;
import stm.com.generic.web.GenericUtils;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@SuppressWarnings("rawtypes")
public class GenericServiceImpl<D extends GenericDao, C extends GenericCommand> extends EgovAbstractServiceImpl implements GenericService<C> {

	@Autowired
	protected SqlSession sqlSession;
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	protected void logging(C cmd) {
		logger.debug("		:: Service : " + getClass().getName());
		logger.debug("		:: DaoClass : " + getDao().getClass().getName());
		logger.debug("		:: CommandClass : " + cmd.getClass().getName());
	}

	public LoginVO getUser() {
		LoginVO vo = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		if (vo != null) {
			return vo;
		}
		return null;
	}

	public C setUser(C cmd) {
		LoginVO vo = getUser();
		if (vo != null) {
			cmd.setFrst_register_id(vo.getId());
			cmd.setFrst_register_nm(vo.getName());
			cmd.setLast_updusr_id(vo.getId());
			cmd.setLast_updusr_nm(vo.getName());
		} else {
			cmd.setFrst_register_id("SYSTEM");
			cmd.setFrst_register_nm("SYSTEM");
			cmd.setLast_updusr_id("SYSTEM");
			cmd.setLast_updusr_nm("SYSTEM");
		}
		return cmd;
	}

	@SuppressWarnings("unchecked")
	public C getList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();

		cmd.setList(dao.getList(cmd));

		if ("Y".equals(StringUtils.defaultIfEmpty(cmd.getPage_use_at(), "N")) && "Y".equals(StringUtils.defaultIfEmpty(cmd.getPage_count_use_at(), "N"))) {
			cmd.setTotal_record_count(dao.getListCount(cmd));
		} else {
			cmd.setTotal_record_count(cmd.getList().size());
		}
		return cmd;
	}

	@SuppressWarnings("unchecked")
	public C getView(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();

		return (C) dao.getView(cmd);
	}

	@SuppressWarnings("unchecked")
	public int insert(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();
		setUser(cmd);

		return dao.insert(cmd);
	}

	@SuppressWarnings("unchecked")
	public int update(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();
		setUser(cmd);

		return dao.update(cmd);
	}

	@SuppressWarnings("unchecked")
	public int updateList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();
		setUser(cmd);

		return dao.updateList(cmd);
	}

	public int updateListForAll(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		return 1;
	}

	@SuppressWarnings("unchecked")
	public int delete(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();
		setUser(cmd);

		return dao.delete(cmd);
	}

	@SuppressWarnings("unchecked")
	public int deleteList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		D dao = getDao();
		setUser(cmd);

		return dao.deleteList(cmd);
	}

	@SuppressWarnings("unchecked")
	protected D getDao() {
		return (D) sqlSession.getMapper(GenericUtils.getClassOfGenericTypeIn(getClass(), 0));
	}

}