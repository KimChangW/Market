<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/viewConfiguration.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>
<%-- <script src="${path }/ckeditor/ckeditor.js"></script>  --%>

<script>
$(function(){
	
	$("#sel1").hide();
	$("input[name='p_group_price']").attr('value',0);
	$("#sel3").hide();
	$("input[name='p_follow_price']").attr('value',0);
	
	$("input[name='p_group_buying']:radio").change(function(){
		var c = this.value;
		if(c == 'N'){
			$("#sel1").hide();
			$("#sel2").show();
		}else{
			$("#sel1").show();
			$("#sel2").hide();
		}
	});
	
	$("input[name='p_follow_sale']:radio").change(function(){
		var d = this.value;
		if(d == 'N'){
			$("#sel3").hide();
			$("#sel4").show();
		}else{
			$("#sel3").show();
			$("#sel4").hide();
		}
	});
});
</script>

<script>
/**
 * 첨부파일로직
 */
$(function () {
    $('#btn-upload').click(function (e) {
        e.preventDefault();
        $('#input_file').click();
    });
    
    $("#input_file").on("change", fileCheck);
});

// 파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 5;
// 파일 고유넘버
var fileNum = 0;
// 첨부파일 배열
var content_files = new Array();

function fileCheck(e) {
    var files = e.target.files;
    
    // 파일 배열 담기
    var filesArr = Array.prototype.slice.call(files);
    
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > totalCount) {
      alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
      return false;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }
    console.log ("files:"+files);
    console.log ("filesArr:"+ filesArr.length);
    console.log ("fileCount:"+fileCount);
    console.log ("fileNum:"+fileNum);
    
    // 각각의 파일 배열담기 및 기타
    filesArr.forEach(function (f) {
      var reader = new FileReader();
      reader.onload = function (e) {
        content_files.push(f);
        $('#articlefileChange').append(
       		'<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')" style=" float: left; margin:2px; height:auto;">'
       		+ '<table><tr><td><img src="' + e.target.result + '" height=90px></td></tr>'
       		+ '<tr><td align=center><font style="font-size:12px">' + f.name + '</font></td></tr></table><div/>' 
		);
        fileNum ++;
      };
      reader.readAsDataURL(f);
    });
    console.log(content_files);
    //초기화 한다.
    $("#input_file").val("");
  }

// 파일 부분 삭제 함수
function fileDelete(fileNum){
    var no = fileNum.replace(/[^0-9]/g, "");
    content_files[no].is_delete = true;
	$('#' + fileNum).remove();
	fileCount --;
    console.log(content_files);
}

/*
 * 폼 submit 로직
 */
function registerAction(){
		
	var form = $("form")[0];        
 	var formData = new FormData(form);
		for (var x = 0; x < content_files.length; x++) {
			// 삭제 안한것만 담아 준다. 
			if(!content_files[x].is_delete){
				 formData.append("article_file", content_files[x]);
				console.log("formData 저장 성공")
			}
		}
 		formData.append("s_no", dataForm.s_no.value);
		formData.append("cate_no", dataForm.cate_no.value);
		formData.append("p_name", dataForm.p_name.value);
		formData.append("p_sell_price", dataForm.p_sell_price.value);
		formData.append("p_stock", dataForm.p_stock.value);
		formData.append("p_group_buying", dataForm.p_group_buying.value);
		formData.append("p_group_price", dataForm.p_group_price.value);
		formData.append("p_follow_sale", dataForm.p_follow_sale.value);
		formData.append("p_follow_price", dataForm.p_follow_price.value);
//		formData.append("p_detail", dataForm.p_detail.value);
		formData.set("p_detail", CKEDITOR.instances.p_detail.getData());


	console.log(dataForm.p_name.value)
   /*
   * 파일업로드 multiple ajax처리
   */    
	$.ajax({
   	      type: "POST",
   	   	  enctype: "multipart/form-data",
   	      url: "${path}/productInsert.do",
       	  data : formData,
       	  processData: false,
   	      contentType: false,
   	      success: function (data) {
   	    	if(JSON.parse(data)['result'] == "OK"){
   	    		alert("파일업로드 성공");
   	    		location.href="productList.do";
   	    	} else if(JSON.parse(data)['result'] == "BIGfile"){
	   	    	alert("상품은 등록되었으나 이미지 사이즈가 너무 커서 이미지 등록이 되지 않았습니다<br>상품수정에서 이미지를 추가등록 해주세요");
	   	    	location.href="productList.do";
			} else
				alert("서버내 오류로 처리가 지연되고있습니다. 잠시 후 다시 시도해주세요");
   	      },
   	      error: function (xhr, status, error) {
   	    	alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
   	     	return false;
   	      }
	});
	return false;
}
</script>

</head>
<body>
<%@ include file="../common/header.jsp"%>
<%@ include file="../common/menuShop.jsp"%>

	<div class="container" align="center">
	
		<h3 class="text-primary">상품 등록</h3>
		<div class="vf-card">
		<form name="dataForm" id="dataForm" onsubmit="return registerAction()">
        <input type="hidden" name="s_no" value="${sessionScope.s_no}">

			<table class="table">
				<tr>
					<td width=115px>상품이미지</td>
					<td>
						<table>
							<tr>
								<td><button id="btn-upload" type="button" class="btn btn-success" >파일 추가</button>
									<input id="input_file" multiple="multiple" type="file" accept="image/*,video/*" style="display: none;"></td>
								<td style="padding-left:5px"><font style="font-size: 10px; color: gray;">
										※첨부파일은 최대 5개까지 등록이 가능합니다.<br>
										※가능한 정사각형으로 등록해주시고 세로길이가 길지 않게 해주세요. </font></td>
							</tr>
						</table>
						<div class="data_file_txt" id="data_file_txt" style="margin: 5px;">
							<div id="articlefileChange" style="float: left; align:center; margin: 2px; border-style: dotted; border-width: 2px; border-radius: 5px; border-color: #bbb; height: auto; display: block;">
								<font style="font-size: 10px; color: gray;">등록을 취소하시려면 사진을 클릭하세요</font><br>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>카테고리코드</td>
					<td>
						<select id="cate_no" name="cate_no" style="width:180px; height:30px">
							<c:forEach var="c" items="${listCateNo}">
								<option value="${c.cate_no}">${c.cate_large}/${c.cate_small}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>상품명</td>
					<td><input type="text" name="p_name" width="400px" required="required"></td>
				</tr>
				<tr>
					<td>일반구매가격</td>
					<td><input type="text" name="p_sell_price" required="required"></td>
				</tr>
				<tr>
					<td>재고</td>
					<td><input type="text" name="p_stock" required="required"></td>
				</tr>
				<tr>
					<td>공동구매여부</td>
					<td>
						<input type="radio" name="p_group_buying" value="Y">Y
						<input type="radio" name="p_group_buying" value="N" checked="checked">N
					</td>
				</tr>
				<tr>
					<td>공동구매가</td>
					<td>
						<div id= "sel1">
							<input type="text" name="p_group_price" required="required">
						</div>
						<div id = "sel2" style="font-family:나눔고딕; font-size:12; color:darkred">
							※공동구매가는 공동구매여부가 'Y'일 경우에만 입력가능합니다.
						</div>	
					</td>
				</tr>
				<tr>
					<td style="padding-right:0px">팔로워할인여부</td>
					<td>
						<input type="radio" name="p_follow_sale" value="Y">Y
						<input type="radio" name="p_follow_sale" value="N" checked="checked">N
					</td>
				</tr>
				<tr>
					<td>팔로워할인가</td>
					<td>
						<div id= "sel3">
							<input type="text" name="p_follow_price" required="required">
						</div>
						<div id = "sel4" style="font-family:나눔고딕; font-size:12; color:darkred">
							※팔로워할인가는 팔로워할인여부가 'Y'일 경우에만 입력가능합니다.
						</div>
					</td>
				</tr>
				<tr>
					<td>상세설명</td>
					<td><textarea rows="5" cols="30" name="p_detail" required="required">상품설명을 예쁘게 편집해서 입력하세요<br>
									                                                                                                  사진폭을 390px이하로 맞춰서 올려주세요</textarea>
						<script>	// 글쓰기 editor 및 사진 업로드 기능
							CKEDITOR.replace('p_detail',{filebrowserUploadUrl:'${path}/market/fileUpload.do'});
						</script>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="submit" value="확인" class="btn btn-success"></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
<%@ include file="../common/footer.jsp"%>
</body>
</html>