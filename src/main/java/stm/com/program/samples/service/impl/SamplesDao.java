package stm.com.program.samples.service.impl;

import java.util.List;

import stm.com.generic.service.impl.GenericDao;
import stm.com.program.samples.web.SamplesCommand;

public interface SamplesDao extends GenericDao<SamplesCommand> {

	public List<SamplesCommand> getListByType(SamplesCommand cmd);
}
