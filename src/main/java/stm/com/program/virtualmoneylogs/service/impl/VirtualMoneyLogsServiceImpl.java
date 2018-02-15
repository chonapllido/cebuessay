package stm.com.program.virtualmoneylogs.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.virtualmoneylogs.service.VirtualMoneyLogsService;
import stm.com.program.virtualmoneylogs.web.VirtualMoneyLogsCommand;

@Service("virtualmoneylogsService")
public class VirtualMoneyLogsServiceImpl extends GenericServiceImpl<VirtualMoneyLogsDao, VirtualMoneyLogsCommand> implements VirtualMoneyLogsService {

}
