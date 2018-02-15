package stm.com.program.etorder.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import stm.com.generic.web.GenericController;
import stm.com.program.etorder.service.EtOrderService;

@Controller
@RequestMapping("/back/etorder")
public class EtOrderController extends GenericController<EtOrderService, EtOrderCommand> {

}