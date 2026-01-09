<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 완료</title>
</head>
<body>

<h2>비밀번호 재설정 완료</h2>

<p>임시 비밀번호가 발급되었습니다</p>
<p><strong>${sessionScope.tempPw}</strong></p>

<p>로그인 후 반드시 비밀번호를 변경하세요</p>

<br>
<a href="/login">로그인</a>

</body>
</html>