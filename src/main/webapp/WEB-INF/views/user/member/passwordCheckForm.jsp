<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인 페이지</title>
</head>
<body>
	<h3>비밀번호 확인</h3>
	* 회원정보 수정과 회원 탈퇴를 위해 비밀번호를 입력하세요. <br>
		<form name = "passwordCheckForm" method = "post" action = "passwordCheck">
			<input type = "hidden" name = "m_no" value="${m_no}" > 
			<input type = "hidden" name = "mode" value="${mode}">  
			비밀번호 : <input type = "password" name = "m_passwd">
		<input type = "submit" value = "전송"><br>
		<input type = "button" value = "뒤로 가기" onclick = "history.back();">
	</form>
	<c:if test="${not empty msg}">
		<p style = "color:red;font-weight:bold">${msg}</p>
	</c:if>
</body>
</html>

