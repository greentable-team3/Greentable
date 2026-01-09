<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- 로그인 페이지 부트스트랩 link -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<header class="pb-3 mb-4 border-bottom d-flex justify-content-between align-items-center px-4">
    <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
        <svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
            <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5z"/>
            <path d="M8 3.293l6 6V13.5A1.5 1.5 0 0 1 12.5 15h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6z"/>
        </svg>
        <span class="fs-4 ms-2">Home</span>
    </a>
</header>

<div class="container d-flex justify-content-center mt-5">
    <div class="card shadow p-4" style="max-width: 400px; width: 100%;">
        <h3 class="text-center mb-4">로그인</h3>

        <form name="login" method="post" action="/j_spring_security_check">

            <div class="mb-3">
                <label class="form-label">아이디</label>
                <input type="text" name="j_username" class="form-control">
            </div>
            <div class="mb-3">
                <label class="form-label">비밀번호</label>
                <input type="password" name="j_password" class="form-control">
            </div>     
             <c:if test="${param.error eq 'true'}"> <%--로그인 에러 메시지--%>
				<!-- 로그인 오류창 배경 -->
				<div class="alert alert-danger" style = "color:red;font-weight:bold;text-align:center" role="alert">
					아이디 또는 비밀번호를 확인하세요!
				</div>
			</c:if>
            <div class="d-grid gap-2 mt-4">
                <input type="submit" value="로그인" class="btn btn-primary">
                <button type="button" class="btn btn-secondary" onclick="location.href='/signup'">회원가입</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
