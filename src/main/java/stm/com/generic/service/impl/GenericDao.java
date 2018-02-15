package stm.com.generic.service.impl;

import java.util.List;

import org.apache.ibatis.session.RowBounds;

import stm.com.generic.web.GenericCommand;

public interface GenericDao<C extends GenericCommand> {

	public int getListCount(C cmd);

	public List<C> getList(C cmd, RowBounds row);

	public List<C> getList(C cmd);

	public C getView(C cmd);

	public int insert(C cmd);

	public int update(C cmd);

	public int updateList(C cmd);
	
	public int updateListForCheck(C cmd);

	public int delete(C cmd);

	public int deleteList(C cmd);
}
