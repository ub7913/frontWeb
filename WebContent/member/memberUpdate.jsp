<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script>
function inputCheck() {
	//id, pw �ʼ��Է� üũ
	if(frm.id.value == "") {
		window.alert("id �Է�");
		frm.id.focus();
		return false;
	}
	if(frm.pw.value == "") {
		alert("pw �Է�");
		frm.pw.focus();
		return false;
	}
	//job(select �±�) ���õǾ����� Ȯ��
	if(frm.job.value == "") {
	//if(frm.job.selectedIndex > 0) {}
		alert("job����");
		frm.job.focus();
		return false;
	}
	//radio, checkbox
	var gender =
		document.querySelectorAll("[name='gender']:checked").length;
	if(gender == 0) {
		alert("���� ��� �ϳ��� ����");
		return false;
	}
	//ȸ�������� ����
	//frm.submit();
	return true;
}
</script>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		//�ʱ�ȭ
		$("[name=gender]").val(["${member.gender}"]);//el�� �˾Ƽ� null üũ �ϱ� ������ null�̸� ���� ���� null���� ��� ����.
		$("[name=hobby]").val("${member.hobby}".replace("[","").replace("]","").split("/")); //read, ski, ..�̷��� ������ �ؾ� �� , �׷��� �迭�� �ٲ��ִ� �Լ� split�� ����.()�ȿ��� �迭 �ȿ��� ���� �� �� �ְԲ� �ϴ� �����ڸ� ����.
														  				//arr = "ski,read,ddd".replace("[","").replace("]","").split(",")  == arr = "ski,read,ddd".replace(/\[|\]/g,"").split(",")	
		$("[name=mailyn]").val(["${member.mailyn}"]);
		$("#frm [name=job]").val("${member.job}");
	});
</script>
</head>
<body>
<h3 class="page_title">ȸ������</h3>

${error}
<form action="${pageContext.request.contextPath}/memberSearch.do"> <!-- http://localhost/memberSearch.do -->
	<input type="hidden" name="job" value="update">
	id : <input name="id">
	<button>�˻�</button>	
</form>

<c:if test="${not empty member}">
<h3>�˻����</h3>
<div class="regist">
 	<!-- /frontWeb/memberInsert.do or ../memberInsert.do -->
	<form method="post" name="frm" id="frm" 
		  action="${pageContext.request.contextPath}/memberUpdate.do" 
		  onsubmit="return inputCheck()">
	<div>
		<label>ID </label>
		<input type="text" name="id" value="${member.id}" readonly="readonly">
	</div>
	<div>
		<label>PW </label>
		<input type="password" name="pw" value="${member.pw}">
	</div>
	<div>
		<label>����</label>
		<input type="radio" name="gender" value="male">��
		<input type="radio" name="gender" value="female">��
	</div>
	<div>
		<label>����</label>
		<select name="job" id="job" size="4">
			<option value="">����</option>
			<option value="professor">����</option>
			<option value="doctor">�ǻ�</option>
			<option value="salesperson">�Ǹſ�</option>
			<option value="student">�л�</option>
		</select>	
	</div>
	<div>
		<label for="reason">���Ե���</label>
		<textarea id="reason" name="reason">${member.reason}</textarea>
	</div>
	<div>
		<label>���ϼ��ſ���</label>
		<input type="checkbox" name="mailyn" value="y"></input>
	</div>
	<div>
		<label for="hobby">���</label>
		<input type="checkbox" name="hobby" value="read">����
		<input type="checkbox" name="hobby" value="game">����
		<input type="checkbox" name="hobby" value="ski">��Ű
	</div>
	<div>
		<button type="reset" name="reset">�ʱ�ȭ</button>
		<button>���</button>
		<!-- <button type="button" name="submit" onclick="inputCheck()">���</button> -->
	</div>
</form>
</div>
</c:if>
</body>
</html>