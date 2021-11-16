<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="EUC-KR">
<title>판매목록조회</title>

	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<!-- ////////////////////////////////JavaScript///////////////////////////////////// -->
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/purchase/listSale").submit();	
	}
  
	$(function() {
		
		$( ".btn.btn-default").on("click" , function() {
			fncGetUserList(1);
		});
	});
	
	$(function() {
			/* $( "td:nth-child(6) > i" ).on("click" , function() { */
			$( "#updateTranCode" ).on("click" , function() {
				//self.location ="/product/getProduct?prodNo="+$("#prodNo").text().trim();
				var tranCode = $(this).siblings("#tranCode").val();
				var tranNo = $(this).siblings("#tranNo").val();

				$.ajax(
						{
							url : "/purchase/json/updateTranCode/"+tranCode+"/"+tranNo,
							method : "GET",
							dataType : "json",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData, status){								
								if(JSONData.tranCode == '002'){
									$('#updateTranCode').html('물건도착');
								} else if(JSONData.tranCode == '003'){
									$('#updateTranCode').html('배송완료');
								}
							}
						});
			});
	});
 
	$(function(){
		
		$( "td:nth-child(2)" ).on("click" , function() {
			var prodNo = $(this).siblings("td:nth-child(5)").children("#prodNo").val();

			self.location ="/product/getProduct?prodNo="+prodNo;
		});

	});
	
	$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "whitesmoke");
</script>
</head>

	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>판매목록</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>주문번호</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품번호</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>배송현황</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->

     <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">상품명</th>
            <th align="left">가격</th>
            <th align="left">구매일</th>
            <th align="left">현재상태</th>
            <th align="left">판매관리</th>
          </tr>
        </thead>
        
        <c:set var="i" value="0" />
		  <c:forEach var="purchase" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td align="left">${ purchase.prodName }</td>
			  <td align="left">${ purchase.price }</td>
			  <td align="left">${ purchase.orderDate }</td>
			  <td align="left">현재		
				<c:if test = "${purchase.tranCode=='000'}">
					판매중
				</c:if>
				<c:if test = "${purchase.tranCode=='001'}">
					구매 완료
				</c:if>	
				<c:if test = "${purchase.tranCode=='002'}">
					배송중
				</c:if>
				<c:if test = "${purchase.tranCode=='003'}">
					배송 완료
				</c:if>
				상태 입니다.</td>
			  <td align="left" id="updateTranCode">
				<c:if test = "${purchase.tranCode=='002'}">
					배송시작
				</c:if>
 				<c:if test = "${purchase.tranCode=='003'}">
 					배송완료
 				</c:if>
			  	<input type="hidden" id="tranCode" value="${ purchase.tranCode }">
			  	<input type="hidden" id="tranNo" value="${ purchase.tranNo }">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

	<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>