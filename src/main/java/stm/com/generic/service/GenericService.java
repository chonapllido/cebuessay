package stm.com.generic.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.web.GenericCommand;

public interface GenericService<C extends GenericCommand> {

	public C getList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public C getView(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int insert(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int update(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int updateList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public int updateListForAll(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int delete(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public int deleteList(C cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
