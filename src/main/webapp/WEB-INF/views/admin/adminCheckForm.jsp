<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 인증 페이지</title>
</head>
<body>
	<h3>관리자 인증 번호 확인</h3>
	* 관리자 인증 번호를 입력해 주세요. <br>
		<form name = "adminCheckForm" method = "post" action = "adminCheck">
			<input type = "hidden" name = "m_no" value="${m_no}" > 
			<input type = "hidden" name = "mode" value="${mode}">  
			관리자 인증 키 : <input type = "password" name = "adminCode">
			<c:if test="${not empty msg}">
				<p style = "color:red;font-weight:bold">${msg}</p>
			</c:if><br>
		<input type = "submit" value = "전송">
		<input type = "button" value = "뒤로 가기" onclick = "location.href='/list'">
	</form>
</body>
</html>