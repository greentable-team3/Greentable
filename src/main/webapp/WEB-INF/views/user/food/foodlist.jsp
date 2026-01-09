<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 목록</title>
<link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css">
</head>
<body>
	<h2>
	    <c:choose>
	        <c:when test="${selectedKind == 'diet'}">🥗 다이어트 레시피 목록</c:when>
	        <c:when test="${selectedKind == 'protein'}">💪 단백질 식단 목록</c:when>
	        <c:otherwise>📋 전체 레시피 목록</c:otherwise>
	    </c:choose>
	</h2>
	<a href="/foodlist" 
       style="text-decoration: none; padding: 5px 10px; 
              background-color: ${empty selectedKind ? 'yellow' : 'transparent'}; 
              border: 1px solid #ccc;">전체</a>
	<a href="/foodlist?f_kind=diet" 
	style="background-color: ${selectedKind == 'diet' ? 'yellow' : 'white'};">
	다이어트
	</a>
	
	<a href="/foodlist?f_kind=protein" 
	   style="background-color: ${selectedKind == 'protein' ? 'yellow' : 'white'};">
	   단백질
	</a>
	<table>
	<tr>
	<c:forEach var="dto" items="${list}">
		<td><a href="/fdetail?f_no=${dto.f_no}"><img src="/image/${dto.f_imgfilename}" style="width: 250px; height: 200px;"></a>
		<br>${dto.f_name}<br>❤️ ${dto.f_love}
		</td>
	</c:forEach>	
	</tr>
	</table>
	<a href ="/finsertForm" class="btn btn-primary">레시피등록</a> 
</body>
</html>
