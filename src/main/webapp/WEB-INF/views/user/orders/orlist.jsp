<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문목록</title>
</head>
<body>
	<h1>주문목록</h1>
	<table border="1" width="700">
		<tr>
			<td>주문 번호</td>
			<td>수신인</td>
			<td>총결제 금액</td>
			<td>배송비</td>
			<td>수신 전화번호</td>
			<td>배송지</td>
			<td>요청사항</td>
		</tr>
	<c:forEach var="dto" items="${list}">	
		<tr>
			<td>${dto.o_no}</td>
			<td>${dto.o_name}</td>
			<td>${dto.o_total}</td>
			<td>${dto.o_fee}</td>
			<td>${dto.o_tel}</td>
			<td>${dto.o_addr}</td>
			<td>${dto.o_detail}</td>
			<td><a href="/oupdateForm?o_no=${dto.o_no}">수정</a>
		</tr>
	</c:forEach>
	</table>
</body>
</html>