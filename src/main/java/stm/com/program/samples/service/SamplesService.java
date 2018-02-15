package stm.com.program.samples.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import stm.com.generic.service.GenericService;
import stm.com.program.samples.web.SamplesCommand;

public interface SamplesService extends GenericService<SamplesCommand> {
	
	public SamplesCommand getListByType(SamplesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception;
}
