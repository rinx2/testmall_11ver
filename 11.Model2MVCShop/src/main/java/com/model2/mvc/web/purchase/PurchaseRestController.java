package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	///Constructor
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="json/updateTranCodeByProd/{tranCode}/{tranNo}", method=RequestMethod.GET)
	public Purchase updateTranCodeByProd(@PathVariable String tranCode, @PathVariable int tranNo) throws Exception {
		
		System.out.println("purchase/json/updateTranCodeByProd : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		if( purchase.getTranCode() != null && !(purchase.getTranCode().equals("003")) ) {
			if(purchase.getTranCode().equals("001")) {
				purchase.setTranCode("002");
			} else if(purchase.getTranCode().equals("002")) {
				purchase.setTranCode("003");
			}	
			purchaseService.updateTranCode(purchase);
		}
		
		purchase = purchaseService.getPurchase(tranNo);
		
		return purchase;
	}

	@RequestMapping(value="json/updateTranCode/{tranCode}/{tranNo}", method=RequestMethod.GET)
	public Purchase updateTranCode(@PathVariable String tranCode, @PathVariable int tranNo) throws Exception {
		
		System.out.println("purchase/json/updateTranCode : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		if( purchase.getTranCode() != null && purchase.getTranCode().equals("002") ) {
			purchase.setTranCode("003");
			purchaseService.updateTranCode(purchase);
		}

		purchase = purchaseService.getPurchase(tranNo);
	
		return purchase;
	}
}
