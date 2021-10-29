package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() {
		
		System.out.println("/product/addProduct : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	//@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public String addProduct(@RequestBody Product product) throws Exception {
		
		System.out.println("/product/json/addProduct : POST");
		
		System.out.println("@RequestBody :: "+product);
		productService.addProduct(product);
		
		return "redirect:/getProduct?prodNo="+product.getProdNo();
	}
	
	@RequestMapping(value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		System.out.println(prodNo);
		Product product = productService.getProduct(prodNo);
		System.out.println(product);
		
		return product;
	}
	
	//@RequestMapping(value="updateProduct/{prodNo}", method=RequestMethod.GET)
	public String updateProduct(@PathVariable int prodNo, Model model) throws Exception {
		//���� getProduct�� ��� ���� �׷��� ���� ��δ� getProduct �ڿ� �ش� ��� ���� ����
		
		System.out.println("/product/updateProduct : GET");
		
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	//@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct(@ModelAttribute("product") Product product, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		
		productService.updateProduct(product);
		
		return "redirect:/getProduct?prodNo="+product.getProdNo();
	}
	
	@RequestMapping(value="json/listProduct")
	public String listProduct(@RequestBody Search search, Model model, HttpServletRequest request) throws Exception {
		
		System.out.println("/product/listProduct : GET / POST");

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}

}
