package stm.com.program.ordunconfirm.service.impl;

import org.springframework.stereotype.Service;

import stm.com.generic.service.impl.GenericServiceImpl;
import stm.com.program.ordunconfirm.service.OrderUnconfirmService;
import stm.com.program.ordunconfirm.web.OrderUnconfirmCommand;

@Service("orderunconfirmService")
public class OrderUnconfirmServiceImpl extends GenericServiceImpl<OrderUnconfirmDao, OrderUnconfirmCommand> implements OrderUnconfirmService {


}
