package stm.com.program.essaytype.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.essaytype.service.EssaytypeService;
import stm.com.program.essaytype.web.EssaytypeCommand;

@Service("essaytypeService")
public class EssaytypeServiceImpl extends GenericServiceImpl<EssaytypeDao, EssaytypeCommand> implements EssaytypeService {

}
