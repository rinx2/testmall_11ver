<%@ page contentType="text/html; charset=EUC-KR"%>

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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
 	<link rel="stylesheet" href="/resources/demos/style.css">
  	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
		body {
            padding-top : 50px;
        }
 
    </style>

	<!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	function fncAddPurchase(){
		//Form 유효성 검증		
		var name=$("input[name='receiverName']").val();

		if(name == null || name.length<1){
			alert("구매자 이름은 반드시 입력하여야 합니다.");
			return;
		}
		
		$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();

	}

	function resetData(){
		document.detailForm.reset();
	}

	$(function() {
		
		$( "#divyDate" ).datepicker({
			dateFormat: "yy-mm-dd",
			showOn: "button",
		    buttonImage: "../images/ct_icon_date.gif",
		    buttonImageOnly: true,
		    buttonText: "배송희망일자를 선택하세요."
		});
		
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddPurchase();
		});

		$( "a[href='#']" ).on("click" , function() {
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
	       <h3 class=" text-info">상품구매</h3>
	    </div>
	
	<!-- form Start /////////////////////////////////////-->
	<form class="form-horizontal" enctype="text">
	
		<div class="form-group">
		    <label for="prodNo" class="col-sm-offset-1 col-sm-3 control-label">상품번호</label>
		    <div class="col-sm-4">
		    	${ product.prodNo }
		      <input type="hidden" class="form-control" id="prodNo" name="prodNo" value=${ product.prodNo }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		    	${ product.prodName }
		      <input type="hidden" class="form-control" id="prodName" name="prodName" value=${ product.prodName }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-2">
		    	${ product.prodDetail }
		      <input type="hidden" class="form-control" id="prodDetail" name="prodDetail" value=${ product.prodDetail }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-2">
		    	${ product.manuDate }
		      <input type="hidden" class="form-control" id="manuDate" name="manuDate" value=${ product.manuDate }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-2" >
		    	${ product.price }
		      <input type="hidden" class="form-control" id="price" name="price" value=${ product.price }>원
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">구매자ID</label>
		    <div class="col-sm-2">
		    	${ user.userId }
		      <input type="hidden" class="form-control" id="buyerId" name="buyerId" value=${ user.userId }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="paymentOption" class="col-sm-offset-1 col-sm-3 control-label">구매방법</label>
		    <div class="col-sm-2">
		    	<select name="paymentOption" id="paymentOption">
		    		<option value="1" selected="selected">현금구매</option>
		    		<option value="2">신용구매</option>
		    	</select>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="receiverName" class="col-sm-offset-1 col-sm-3 control-label">구매자이름</label>
		    <div class="col-sm-2" >
		      <input type="text" class="form-control" id="receiverName" name="receiverName" placeholder=${ user.userName }>
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="receiverPhone" class="col-sm-offset-1 col-sm-3 control-label">구매자연락처</label>
		    <div class="col-sm-2" >
		      <input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="divyAddr" class="col-sm-offset-1 col-sm-3 control-label">구매자주소</label>
		    <div class="col-sm-2" >
		      <input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="구매자주소">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="divyRequest" class="col-sm-offset-1 col-sm-3 control-label">구매요청사항</label>
		    <div class="col-sm-2" >
		      <input type="text" class="form-control" id="divyRequest" name="divyRequesst" placeholder="구매요청사항">
		    </div>
		</div>
		
		<div class="form-group">
		    <label for="divyDate" class="col-sm-offset-1 col-sm-3 control-label">배송희망일자</label>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="divyDate" name="divyDate" placeholder="배송희망일자">
		    </div>
		</div>
		
		<div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">구&nbsp;매</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		</div>
	</form>

</body>
</html>