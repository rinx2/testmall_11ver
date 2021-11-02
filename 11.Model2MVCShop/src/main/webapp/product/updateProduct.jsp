<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="EUC-KR">
	
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
   
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
    </style>
    
	<script type="text/javascript">
	
		function fncUpdateProduct(){
			//Form 유효성 검증
			var name=$("input[name='prodName']").val();
			var detail=$("input[name='prodDetail']").val();
			var fileName=$("input[name='fileName']").val();
			
			if(name == null || name.length<1){
				alert("상품명은 반드시 입력하여야 합니다.");
				return;
			}
			if(detail == null || detail.length<1){
				alert("상품소개는 반드시 입력하여야 합니다.");
				return;
			}
			
			$("form").attr("method" , "POST").attr("action" , "/product/updateProduct").submit();
		}
		
		$(function() {
			
			$( "#calendar").on("click" , function() {
				show_calendar($("input[name='manuDate']"), $("input[name='manuDate']").val());
			});
			
			$( "button.btn.btn-primary").on("click" , function() {
				fncUpdateProduct();
				alert("수정이 완료되었습니다.")
			});
			
			$( "a[href='#' ]").on("click" , function() {
				$("form")[0].reset();
			});
			
		});
		
	</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">상품정보수정</h3>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
		
		  <div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodNo" name="prodNo" value="${ product.prodNo }" readonly>
		       <span id="helpBlock" class="help-block">
		      	<strong class="text-danger">상품번호 수정불가</strong>
		      </span>		  
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" value="${ product.prodName }" placeholder="상품명 입력">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetial" class="col-sm-offset-1 col-sm-3 control-label">상품소개</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail"  value="${ product.prodDetail }" placeholder="상품소개 입력">
		    </div>
		  </div>
		
		 <div class="form-group">
		    <label for="file" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4" >
		      <input type="file" class="form-control" id="file" name="file" placeholder="상품이미지">
		    </div>
		</div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
	</div>
	
</body>
</html>