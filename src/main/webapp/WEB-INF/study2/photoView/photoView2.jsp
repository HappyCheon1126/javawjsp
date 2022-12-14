<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery를 이용한 멀티이미지 미리보기</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
    'use strict';
    
    // 아이디가 fName인 객체의 변화가 생기면 multiImageCheck함수를 호출한다.
    $(document).ready(function() {
	    $("#btnView").hide();
	    $("#photoCloseBtn").hide();
	    
    	$("#fName").on("change", multiImageCheck);
    });
    
    // 파일 전송전 폼 체크후 전송하기
    function fCheck() {
    	let fName = myform.fName.value;
    	if(fName == "") {
    		alert("파일을 선택하세요");
    	}
    	else {
    		myform.submit();
    	}
    }
    
    // 멀티그림파일 미리보여주기
    function multiImageCheck(e) {
    	// 그림파일 체크
    	let files = e.target.files;
    	let filesArr = Array.prototype.slice.call(files);
    	let sw = 0;
    	filesArr.forEach(function(f) {
    		if(!f.type.match("image.*")) {
    			alert("업로드 파일은 이미지 파일만 가능합니다.");
    			sw = 1;
    		}
    	});
    	if(sw == 1) return false;
    	
    	// 멀티파일 이미지 미리보기
    	let i = e.target.files.length-1;
    	for(let image of event.target.files){
        let img = document.createElement("img");
        const reader = new FileReader();
        reader.onload = function(event){
            img.setAttribute("src", event.target.result);
            img.setAttribute("width", 200);
        }
        reader.readAsDataURL(event.target.files[i--]);  
        document.querySelector(".img_wrap").appendChild(img);
	    }
    }
    
    // 파일시스템의 사진 보여주기
    function photoView() {
    	$("#btnView").show();
    	$("#photoViewBtn").hide();
    	$("#photoCloseBtn").show();
    	$("#demo").show();
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/photoViewList.st",
    		success:function(data) {
    			let parsed = JSON.parse(data);	// JSON자료를 자바스크립트에서 사용하기 위해서 파싱처리한다.
    			let res = parsed.res;
    			for(let i=0; i<res.length; i++) {
    				addChar(res[i].value);
    			}
    			$("#demo2").html(data);
    		},
    		error  :function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 앞에서 가져온 내용을 출력시킬 준비처리.. demo에 출력한다.
    function addChar(fileName) {
    	$('#demo').append('<div class="row text-center">'
    		+ '<div class="col"><input type="checkbox" name="chk" class="chk" value="'+fileName+'"></div>'
    		+ '<div class="col">'+fileName+'</div>'
    		+ '<div class="col"><img src="${ctp}/data/photoView/'+fileName+'" width="150px"/></div>'
    		+ '<div class="col"><input type="button" value="삭제" onclick="fileDel(\''+fileName+'\')" class="btn btn-danger btn-sm"/></div>'
    		+ '</div><hr/>');
    }
    
    // 파일시스템의 사진 감추기
    function photoClose() {
    	$("#btnView").hide();
    	$("#photoViewBtn").show();
    	$("#photoCloseBtn").hide();
    	$("#demo").hide();
    }

    // 파일 삭제하기(1장씩 삭제처리)
    function fileDel(fileName) {
    	console.log(fileName);
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/photoViewDelete.st",
    		data  : {fileName : fileName},
    		success:function(res) {
    			if(res == "1") {
    				alert("삭제완료!");
    				location.reload();
    			}
    			else {
    				alert("삭제실패~~");
    			}
    		},
    		error  :function() {
    			alert("전송오류!");
    		}
    	});
    }

    // 전체선택
    $(function(){
    	$(".checkAll").click(function(){
    		if($(".checkAll").prop("checked")) {
	    		$(".chk").prop("checked", true);
    		}
    		else {
	    		$(".chk").prop("checked", false);
    		}
    	});
    });
    
    // 선택항목 반전
    $(function(){
    	$("#reverseAll").click(function(){
    		$(".chk").prop("checked", function(){
    			return !$(this).prop("checked");
    		});
    	});
    });
    
    // 선택항목 삭제하기(ajax처리하기)
    function selectDelCheck() {
    	if(photoForm.chk.length == 0) {
    		alert('삭제할 게시물을 선택하세요.');
    		return false;
    	}
    	
    	let ans = confirm("선택된 모든 게시물을 삭제 하시겠습니까?");
    	if(!ans) return false;
    	let delItems = "";
    	for(let i=0; i<photoForm.chk.length; i++) {
    		if(photoForm.chk[i].checked == true) delItems += photoForm.chk[i].value + "/";
    	}
  		
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/photoViewDeleteAll.st",
    		data : {delItems : delItems},
    		success:function(res) {
    			if(res == "1") {
    				alert("삭제완료");
    			  location.reload();
    			}
    		},
    		error  :function() {
    			alert("전송오류!!");
    		}
    	});
    }

    // 선택 삭제처리
    function delCheck() {
    	let ans = confirm("선택된 파일을 삭제하시겠습니까?");
    	if(!ans) return false;
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2>업로드 사진 미리보기2</h2>
  <form name="myform" id="myform" method="post" action="${ctp}/photoViewOk2.st" enctype="multipart/form-data">
		<hr/>
		<div>
			<input type="file" name="fName" id="fName" class="form-control-file border mb-2"  multiple />
		</div>
		<!-- <div class="demo"></div> -->
		<div class="img_wrap"></div>
		<br/>
		<div>
			사진 설명
			<textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 작성해주세요."></textarea>
		</div>
		<div class="row">
		  <div class="col"><input type="button" value="Submit" onclick="fCheck()" class="btn btn-success form-control mb-2"></div>
			<div class="col"><input type="button" value="Reset" onclick="location.reload()" class="btn btn-warning form-control mb-2"></div>
			<div class="col">
			  <input type="button" value="PhotoView" onclick="photoView()" id="photoViewBtn" class="btn btn-primary form-control mb-2">
			  <input type="button" value="PhotoClose" onclick="photoClose()" id="photoCloseBtn" class="btn btn-info form-control mb-2">
			</div>
		</div>
		<hr/>
	</form>
	<hr/>
	<div id="btnView" class="row text-center bg-light p-2">
	  <div class="col custom-control custom-switch">
		  <input type="checkbox" class="custom-control-input checkAll" id="switch1">
		  <label class="custom-control-label btn btn-success btn-sm" for="switch1">전체선택/해제</label>
		</div>
	  <div class="col"><input type="button" value="선택반전" id="reverseAll" class="btn btn-primary btn-sm"/></div>
	  <div class="col"><input type="button" value="선택삭제" onclick="selectDelCheck()" class="btn btn-danger btn-sm"/></div>
	</div>
	<hr/>
	<form name="photoForm">
		<div id="demo"></div>
	</form>
	<h4>전송자료값</h4>
	<div id="demo2"></div>
	<hr/>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>