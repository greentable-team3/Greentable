<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
</head>
<body>

<h2>비밀번호 재설정</h2>

<form action="/resetPassword" method="post">
    <p>아이디를 입력하세요</p>
    <input type="text" name="m_id" required>
    <br><br>
    <button type="submit">임시 비밀번호 발급</button>
</form>

<c:if test="${not empty msg}">
    <p style="color:red">${msg}</p>
</c:if>

<br>
<a href="/login">로그인으로 돌아가기</a>

</body>
</html>