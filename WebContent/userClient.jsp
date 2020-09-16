<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userClient.jsp</title>
<script>
$(function() {
	//조회
	userList();
	//등록버튼 이벤트
	userInsert();
	//조회버튼 이벤트
	userSelect();
	//수정버튼 이벤트
	userUpdate();
});
//사용자 조회 버튼 이벤트
function userSelect() {
	//조회 버튼 클릭
	$('body').on('click','#btnSelect',function(){
		var userId = $(this).closest('tr').find('#hidden_userId').val();
		//특정 사용자 조회
		$.ajax({
			url:'ajax/GetUsers.do',
			data : {id : userId},
			dataType:'json',
			error:function(xhr,status,msg){
				alert("상태값 :" + status + " Http에러메시지 :"+msg);
			},
			success:userSelectResult
		});
	}); //조회 버튼 클릭
}//userSelect

//사용자 조회 응답
function userSelectResult(user) {
	$('input:text[name="id"]').val(user.id);
	$('input:text[name="name"]').val(user.name);
	$('input:radio[name="gender"]').val([user.gender]);
	$('select[name="role"]').val(user.role).attr("selected", "selected");
}//userSelectResult

//사용자 수정 버튼 이벤트
function userUpdate() {
	//수정 버튼 클릭
	$('#btnUpdate').on('click',function(){
		var div = $(this).closest("tr");
		$.ajax({ 
		    url: "ajax/UpdateUsers.do", 
		    dataType: 'json', 
		    data: $("#form1").serialize(),
		    success: function(data) { 
		    	div.replaceWith( makeTr(item) ); //replaceWith원래있던 tr태그와 수정된 tr태그 교체
		    },
		    error:function(xhr, status, message) { 
		        alert(" status: "+status+" er:"+message);
		    }
		});
	});//수정 버튼 클릭
}//userUpdate

//사용자 등록 요청
function userInsert(){
	//등록 버튼 클릭
	$('#btnInsert').on('click',function(){
		$.ajax({ 
		    url: "ajax/InsertUsers.do",  
		    dataType: 'json', 
		    method : "POST",
		    data :  $("#form1").serialize(),
		    success: function(data) {
		    	$('tbody').append ( makeTr(data) );
		    }, 
		    error:function(xhr, status, message) { 
		        alert(" status: "+status+" er:"+message);
		    } 
		 });  
	});//등록 버튼 클릭
}//userInsert

//사용자 목록 조회 요청
function userList() {
	$.ajax({
		url:'ajax/GetUsersList.do',
		type:'GET', //method:'GET'과 같음
		dataType:'json',
		error:function(xhr,status,msg){
			alert("상태값 :" + status + " Http에러메시지 :"+msg);
		},//에러 생기면 이 핸들러 발동
		success:userListResult
	});
}//userList

//사용자 목록 조회 응답
function userListResult(data) {
	$("tbody").empty();
	$.each(data,function(idx,item){ // 데이터 개수만큼 forEach돌림
		$('tbody').append ( makeTr(item) );
	});//each
}//userListResult

function makeTr(item){
	return $('<tr>')
	.append($('<td>').html(item.id))
	.append($('<td>').html(item.name))
	.append($('<td>').html(item.gender))
	.append($('<td>').html(item.role))
	.append($('<td>').html('<button id=\'btnSelect\'>조회</button>'))
	.append($('<td>').html('<button id=\'btnDelete\'>삭제</button>'))
	.append($('<input type=\'hidden\' id=\'hidden_userId\'>').val(item.id));//데이터 방식으로 값을 넣어도 됨...하지만 어떻게 하는지 모르겠다..
	
}
</script>
</head>
<body>
<div class="container">
<div class="row">
	<div class="col-8">	
		<h2>사용자 목록</h2>
		<table class="table text-center">
			<thead>
			<tr>
				<th class="text-center">아이디</th>
				<th class="text-center">이름</th>
				<th class="text-center">성별</th>
				<th class="text-center">거주지</th>
				<th class="text-center">조회</th>
				<th class="text-center">삭제</th>
			</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<div class="col-4">
	<form id="form1"  class="form-horizontal">
		<h2>사용자 등록 및 수정</h2>
		<div class="form-group">		
			<label >아이디</label>
			<input type="text"  class="form-control" name="id" >
		</div>	
		<div class="form-group">
			<label>이름</label>
			<input type="text"  class="form-control"  name="name" >
		</div>				
		<div class="form-group">
			<label >성별</label>
			<div class="radio">
				<label><input type="radio"  name="gender"  value="M">남</label>
			</div>
			<div class="radio">
				<label><input type="radio"  name="gender"  value="F">여</label>
			</div>	
		</div>	    
		<div class="form-group">   
			<label>역할</label>
				<select class="form-control" name="role">
			   		<option value="Admin">관리자</option>
			   		<option value="User">사용자</option>
				</select>
		</div>  
		<div class="text-center">
			<div class="btn-group">      
					<input type="button"  class="btn btn-primary" value="등록"  id="btnInsert" /> 
					<input type="button"  class="btn btn-primary" value="수정"  id="btnUpdate" />
					<input type="button"  class="btn btn-primary" value="초기화" id="btnInit" />
			</div>
		</div>
	</form>
	</div>
</div>
</div>
		
	
</body>
</html>