package com.model2.mvc.service.purchase;

import java.util.List;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {
	
	//INSERT
	public void addPurchase(Purchase purchase);
	
	//SELECT ONE
	public Purchase getPurchase(int tranNo);
	
	//SELECT ONE
	public Purchase getPurchase2(int prodNo);
	
	//SELECT LIST
	public List<Purchase> getPurchaseList(Search search, String buyerId);

	//SELECT LIST
	public List<Purchase> getSaleList(Search search);
	
	//UPDATE
	public void updatePurchase(Purchase purchase);
	
	//UPDATE
	public void updateTranCode(Purchase purchase);
	
	//SELECT ONE 주문 조회
	public int getLatestTranNo(String buyerId);
	
	// 게시판 Page 처리를 위한 전체Row(totalCount) return
	public int getTotalCountForPurchaseList(Search search) throws Exception;

	public int getTotalCountForSaleList(Search search) throws Exception;

}
