<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>chat.jsp(채팅화면)</title>
  <jsp:include page="/include/bs4.jsp" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="./css/chat.css">
  <link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
  <script src="./js/bootstrap.js"></script>
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <style>
    @charset "UTF-8";

		 .portlet {
		    margin-bottom: 15px;
		}
		
		.btn-white {
		    border-color: #cccccc;
		    color: #333333;
		    background-color: #ffffff;
		}
		
		.portlet {
		    border: 1px solid;
		}
		
		.portlet .portlet-heading {
		    padding: 0 15px;
		}
		
		.portlet .portlet-heading h4 {
		    padding: 1px 0;
		    font-size: 16px;
		}
		
		.portlet .portlet-heading a {
		    color: #fff;
		}
		
		.portlet .portlet-heading a:hover,
		.portlet .portlet-heading a:active,
		.portlet .portlet-heading a:focus {
		    outline: none;
		}
		
		.portlet .portlet-widgets .dropdown-menu a {
		    color: #333;
		}
		
		.portlet .portlet-widgets ul.dropdown-menu {
		    min-width: 0;
		}
		
		.portlet .portlet-heading .portlet-title {
		    float: left;
		}
		
		.portlet .portlet-heading .portlet-title h4 {
		    margin: 10px 0;
		}
		
		.portlet .portlet-heading .portlet-widgets {
		    float: right;
		    margin: 8px 0;
		}
		
		.portlet .portlet-heading .portlet-widgets .tabbed-portlets {
		    display: inline;
		}
		
		.portlet .portlet-heading .portlet-widgets .divider {
		    margin: 0 5px;
		}
		
		.portlet .portlet-body {
		    padding: 15px;
		    background: #fff;
		}
		
		.portlet .portlet-footer {
		    padding: 10px 15px;
		    background: #e0e7e8;
		}
		
		.portlet .portlet-footer ul {
		    margin: 0;
		}
		
		.portlet-green,
		.portlet-green>.portlet-heading {
		    border-color: #16a085;
		}
		
		.portlet-green>.portlet-heading {
		    color: #fff;
		    background-color: #16a085;
		}
		
		.portlet-orange,
		.portlet-orange>.portlet-heading {
		    border-color: #f39c12;
		}
		
		.portlet-orange>.portlet-heading {
		    color: #fff;
		    background-color: #f39c12;
		}
		
		.portlet-blue,
		.portlet-blue>.portlet-heading {
		    border-color: #2980b9;
		}
		
		.portlet-blue>.portlet-heading {
		    color: #fff;
		    background-color: #2980b9;
		}
		
		.portlet-red,
		.portlet-red>.portlet-heading {
		    border-color: #e74c3c;
		}
		
		.portlet-red>.portlet-heading {
		    color: #fff;
		    background-color: #e74c3c;
		}
		
		.portlet-purple,
		.portlet-purple>.portlet-heading {
		    border-color: #8e44ad;
		}
		
		.portlet-purple>.portlet-heading {
		    color: #fff;
		    background-color: #8e44ad;
		}
		
		.portlet-default,
		.portlet-dark-blue,
		.portlet-default>.portlet-heading,
		.portlet-dark-blue>.portlet-heading {
		    border-color: #34495e;
		}
		
		.portlet-default>.portlet-heading,
		.portlet-dark-blue>.portlet-heading {
		    color: #fff;
		    background-color: #34495e;
		}
		
		.portlet-basic,
		.portlet-basic>.portlet-heading {
		    border-color: #333;
		}
		
		.portlet-basic>.portlet-heading {
		    border-bottom: 1px solid #333;
		    color: #333;
		    background-color: #fff;
		}
		
		@media(min-width:768px) {
		    .portlet {
		        margin-bottom: 30px;
		    }
		}
		
		.img-chat{
		width:40px;
		height:40px;
		}
		
		.text-green {
		    color: #16a085;
		}
		
		.text-orange {
		    color: #f39c12;
		}
		
		.text-red {
		    color: #e74c3c;
		}
    
  </style>
  <script>
    'use strict';
    let lastIdx = 0;	// 마지막에 출력하는 메세지의 고유번호
    
    $(document).ready(function() {
    	chatListFunction("ten");	// 처음 chatting창에 접속시에 기존 10개의 대화내용을 출력해 주기위해 함수 호출
    	
    	
    });
    
    // 메세지 내용을 출력하기위한 함수
    function chatListFunction(listType) {
    	$.ajax({
    		url  : "${ctp}/chatList",
    		type : "post",
    		data : {listType : listType},
    		success:function(data) {
    			if(data == "") return;
    			let testData =  data.replace(/\r/gi, '\\r').replace(/\n/gi, '\\n').replace(/\t/gi, '\\t').replace(/\f/gi, '\\f');
    			let parsed = JSON.parse(testData);
    			let res = parsed.res;
    			for(var i=0; i<res.length; i++) {
    	    	addChar(res[i][1].value,res[i][2].value,res[i][3].value,res[i][4].value);
    	    }
    	    lastIdx = Number(parsed.last);
    		}
    	});
    }
    
    function addChar(name, content, cdate, avatar) {
    	$("#chatList").append("<div class='row'>"
        		+ "<div class='col-lg-12'>"
        		+ "<div class='media'>"
        		+ "<a class='pull-left' href='#'>"
        		+ "<img class='media-object img-circle' src='./images/avatar"+avatar+".png' width='50px' alt=''/>"
        		+ "</a>"
        		+ "<div class='media-body'>"
        		+ "<h4 class='media-heading'>"+name
        		+ "<span class='small pull-right'>"+cdate+"&nbsp; </span></h4>"
        		+ "<p>"+content+"</p>"
        		+ "</div>"
        		+ "</div>"
        		+ "</div>"
    	+ "</div><hr/>");
    	$("#chatList").scrollTop($("#chatList")[0].scrollHeight);
    }
  </script>
</head>
<body onLoad="document.myform.content.focus()">
<jsp:include page="/include/header.jsp" />
<br/>
<div class="container bootstrap snippet">
  <div class="row">
    <div class="col-xs-12">
      <div class="portlet portlet-default">
        <div class="portlet-heading">
          <div class="portlet-title">
            <h4><i class="fa fa-circle text-green"></i>채팅방</h4>
          </div>
          <div class="clearfix"></div>
        </div>
        <div id="chat" class="panel-collapse collapse in">
					<!-- 실제로 채팅대화 내용을 주고 받는  메세지를 출력하는 부분(아이디 : chatList) -->
          <div id="chatList" class="portlet-body chat-widget" style="overflow-y: auto; width: auto; height: 600px;">
          </div>
          <!-- 대화내용 입력폼 -->
          <div class="portlet-footer">
            <form role="form" name="myform" id="myform" onSubmit="return false;">
              <div class="row">
                <div class="form-group col-xs-12">
                  <input type="text" style="height:30px;" id="name" value="${snickname}" readonly/>
                  <!-- 아바타 보여주기 -->
                  &nbsp;&nbsp;&nbsp;
                  <c:forEach var="i" begin="1" end="6">
                  	<input type="radio" id="avatar" name="avatar" value="${i}" checked/><img src="./images/avatar${i}.png" width="22px" class="img-circle"/> &nbsp;
                  </c:forEach>
                </div>
              </div>
              <div class="row" style="height:90px;">
                <div class="form-group col-xs-10">
                  <textarea style="height:80px;" id="content" class="form-control" placeholder="메세지 입력..." maxlength="200"></textarea>
                </div>
                <div class="form-group col-xs-2">
                  <button type="button" class="btn btn-default pull-right" onclick="submitFunction()">전송</button>
                  <div class="clearfix"></div>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>