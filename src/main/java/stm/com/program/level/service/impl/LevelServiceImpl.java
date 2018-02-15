package stm.com.program.level.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.level.service.LevelService;
import stm.com.program.level.web.LevelCommand;

@Service("levelService")
public class LevelServiceImpl extends GenericServiceImpl<LevelDao, LevelCommand> implements LevelService {

}
