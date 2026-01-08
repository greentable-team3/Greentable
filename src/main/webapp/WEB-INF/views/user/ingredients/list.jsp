<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료목록</title>
</head>
<body>
	<h1>재료목록</h1>
	<table border="1" width="500">
		<tr>
			<td>재료 번호</td>
			<td>재료명</td>
			<td>재료가격</td>
			<td>원산지</td>
			<td></td>
		</tr>
	<c:forEach var="dto" items="${list}">	
		<tr>
			<td>${dto.i_no}</td>
			<td>${dto.i_name}</td>
			<td>${dto.i_price}</td>
			<td>${dto.i_origin}</td>
			<td><a href="/iupdateForm?i_no=${dto.i_no}">재료수정</a> / <a href="/idelete?i_no=${dto.i_no}">재료삭제</a></td>
		</tr>
	</c:forEach>
	</table>
	<a href="/iinsertForm">재료등록</a>
</body>
</html>