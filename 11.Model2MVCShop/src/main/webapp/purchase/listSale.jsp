<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="EUC-KR">
<title>�ǸŸ����ȸ</title>

	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>

<!-- ////////////////////////////////JavaScript///////////////////////////////////// -->
<script type="text/javascript">
	// �˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScrpt �̿�  
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
									$('#updateTranCode').html('���ǵ���');
								} else if(JSONData.tranCode == '003'){
									$('#updateTranCode').html('��ۿϷ�');
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
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-info">
	       <h3>�ǸŸ��</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>�ֹ���ȣ</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>�����Ȳ</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->

     <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">��ǰ��</th>
            <th align="left">����</th>
            <th align="left">������</th>
            <th align="left">�������</th>
            <th align="left">�ǸŰ���</th>
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
			  <td align="left">����		
				<c:if test = "${purchase.tranCode=='000'}">
					�Ǹ���
				</c:if>
				<c:if test = "${purchase.tranCode=='001'}">
					���� �Ϸ�
				</c:if>	
				<c:if test = "${purchase.tranCode=='002'}">
					�����
				</c:if>
				<c:if test = "${purchase.tranCode=='003'}">
					��� �Ϸ�
				</c:if>
				���� �Դϴ�.</td>
			  <td align="left" id="updateTranCode">
				<c:if test = "${purchase.tranCode=='002'}">
					��۽���
				</c:if>
 				<c:if test = "${purchase.tranCode=='003'}">
 					��ۿϷ�
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
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->

	<!-- PageNavigation Start... -->
		<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>