<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원검색</title>
<script>
	function decoTest() {
		console.log("test");
	}
</script>
</head>
<body> 
<h3>검색!</h3>
<a href="${pageContext.request.contextPath}/memberList.do">회원조회</a> <!-- /frontWeb/memberList.do 또는 ../memberList.do -->
<form action="${pageContext.request.contextPath}/memberSearch.do"> <!-- http://localhost/memberSearch.do -->
	<input type="hidden" name="job" value="search">
	id : <input name="id">
	<button>검색</button>
</form>
</body>
</html>