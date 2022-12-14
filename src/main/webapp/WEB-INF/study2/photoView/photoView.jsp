<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>title</title>
  <jsp:include page="/include/bs4.jsp"/>
  <script>
    'use strict';
    
    // 이미지 1장 미리보기
		function readURL(input) {
			if (input.files && input.files[0]) {
				let reader = new FileReader();
				reader.onload = function(e) {		// 이미지가 로드된 경우에 실행한다.
					document.getElementById('demo').src = e.target.result;	// demo의 src속성에 이미지파일을 넣는다.
				}
				reader.readAsDataURL(input.files[0]);	// reader가 이미지를 읽도록 한다.
			}
			else {
				document.getElementById('demo').src = "";
			}
		}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2>업로드 사진 미리보기1</h2>
  <form name="myForm" id="myForm" method="post" action="${ctp}/photoViewOk.st" enctype="multipart/form-data">
		<hr/>
		<div class="form-group">
			<input type="file" name="fName" id="fName" onchange="readURL(this);" class="form-control-file border mb-2" />
			<img id="demo" width="150px"/>
		</div>
		<br/>
		<div>
			사진 설명
			<textarea rows="4" name="content" id="content" class="form-control mb-3" placeholder="사진설명을 작성해주세요."></textarea>
		</div>
		<div>
				<input type="submit" value="Submit" class="btn btn-success form-control mb-2">
		</div>
		<hr/>
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>