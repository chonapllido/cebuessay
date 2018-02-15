package stm.com.program.priceresearch.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import stm.com.generic.web.GenericController;
import stm.com.program.priceresearch.service.PriceResearchService;

@Controller
@RequestMapping("/price/research")
public class PriceResearchController extends GenericController<PriceResearchService, PriceResearchCommand> {

	
}