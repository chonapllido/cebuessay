package stm.com.program.readmaterial.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.readmaterial.service.ReadMaterialService;
import stm.com.program.readmaterial.web.ReadMaterialCommand;

@Service("readmaterialService")
public class ReadMaterialServiceImpl extends GenericServiceImpl<ReadMaterialDao, ReadMaterialCommand> implements ReadMaterialService {

}
