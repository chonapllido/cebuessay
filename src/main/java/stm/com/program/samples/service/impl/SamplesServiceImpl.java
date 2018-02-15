package stm.com.program.samples.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.samples.service.SamplesService;
import stm.com.program.samples.web.SamplesCommand;

@Service("samplesService")
public class SamplesServiceImpl extends GenericServiceImpl<SamplesDao, SamplesCommand> implements SamplesService {

	public SamplesCommand getListByType(SamplesCommand cmd, HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		SamplesDao dao = getDao();
		cmd.setList(dao.getListByType(cmd));

		return cmd;
	}
}
