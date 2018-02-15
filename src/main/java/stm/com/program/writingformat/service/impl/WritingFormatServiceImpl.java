package stm.com.program.writingformat.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.writingformat.service.WritingFormatService;
import stm.com.program.writingformat.web.WritingFormatCommand;

@Service("writingformatService")
public class WritingFormatServiceImpl extends GenericServiceImpl<WritingFormatDao, WritingFormatCommand> implements WritingFormatService {

}
