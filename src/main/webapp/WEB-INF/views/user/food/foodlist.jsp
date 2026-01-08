<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>
</head>
<body>
	<h1 class="fw-bold" >요리 레시피</h1>
	<table>
	<tr>
	<c:forEach var="dto" items="${list}">
		<td><a href="/fdetail?f_no=${dto.f_no}" ><img src="/image/${dto.f_imgfilename}" width="200"></a>
		<br>${dto.f_name}<br><img src="/image/heart.png" width="15"> ${dto.f_love} || ${dto.f_nolove}
		</td>
	</c:forEach>	
	</tr>
	</table>
	<a href ="/finsertForm">레시피등록</a> 
</body>
</html>
