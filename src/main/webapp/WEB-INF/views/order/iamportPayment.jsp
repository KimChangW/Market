<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/viewConfiguration.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 페이지</title>
<link rel="stylesheet" href="https://unpkg.com/swiper@7/swiper-bundle.min.css">
<link rel="stylesheet" href="${path}/css/swiper.css">
<!-- jQuery --> 
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> 
<!-- iamport.payment.js --> 
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

</head>
<body>

<header>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
</header>

<script>

 $(document).ready(function(){
	 payment();
 });
 
	// iamport API
	function payment(data) {
		var o_no = ${orderNo};
		
		IMP.init('imp45689700');               //아임포트 관리자 콘솔에서 확인한 '가맹점 식별코드' 입력
	    IMP.request_pay({                      // param
	        pg: "${otd.o_pay_type}",                //pg사명 or pg사명.CID (잘못 입력할 경우, 기본 PG사가 띄워짐)
	        pay_method: "${otd.o_pay_type}",     //지불 방법
	        merchant_uid: "${orderNo}",     //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
	        name: "과채마켓", 
	        seller: "${otd.s_no}", 
	        amount: "${otd.o_pay_price}", //금액
	        buyer_email : "${sessionScope.m_email}", 
	        buyer_name : "${ml.m_name}",
	        buyer_tel : "${ml.m_tel}",
	        buyer_postcode : "${di.d_post}",
	        buyer_addr : "${di.d_address} ${di.d_detail_address}"
	       
	    }, function (rsp) {         // callback
	        if (rsp.success) {     // 결제 성공 시 
	        	$.ajax({
	        		url : 'orderInsert.do',
	        		type : 'post',
	        		dataType : 'json',
	        		data :{"o_no":o_no},
	        		success : function(result){
	        			if(result == 2){
	        				var msg = "결제가 완료되었습니다.";
	        			    alert(msg);
	        			    location.href="orderMail.do";
	        			}
	        		}
	        	}); // ajax() end
	        

	        } else {               // 결제 실패 시
	        	$.ajax({
	        		url : 'orderDelete.do',
	        		type : 'post',
	        		dataType : 'json',
	        		data : {"o_no":o_no},
	        		success : function(result){
	        			if(result == 1){
	        				var msg = "결제에 실패하였습니다.";
	        	        	msg += ' 원인 : '+rsp.error_msg;
	        				alert(msg);
	        		        location.href="main.do";
	        			}
	        		}
	        	}); // ajax() end
	        	
	        }
	   });
    }

	
	
</script>	


<c:forEach begin="1" end="30">
	<br>
</c:forEach>

<footer>
	<%@ include file="/WEB-INF/views/common/footer.jsp"%>	
</footer>
	      
</body>
</html>