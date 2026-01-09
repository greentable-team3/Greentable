<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<header class="pb-3 mb-4 border-bottom d-flex justify-content-between align-items-center px-4">
    <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
        <span class="fs-4">Home</span>
    </a>
</header>

<div class="container d-flex justify-content-center mt-5">
    <div class="card shadow p-4" style="max-width: 420px; width: 100%;">
        <h3 class="text-center mb-4">아이디 찾기</h3>

        <!-- 이메일 입력 -->
        <form action="/findId" method="post">
            <p class="mb-2">가입 시 사용한 이메일을 입력하세요</p>
            <input type="email" name="m_email" class="form-control" required>
            <button type="submit" class="btn btn-secondary w-100 mt-3">확인</button>
        </form>

        <!-- 에러 메시지 -->
        <c:if test="${not empty msg}">
            <div class="alert alert-danger mt-3">${msg}</div>
        </c:if>

		<c:if test="${not empty foundId}"> 
		    <c:forEach var="m" items="${idList}">
		        <div class="alert alert-success">
		            아이디: ${fn:substring(m.m_id, 0, 3)}***
		        </div>
		    </c:forEach>
		
		    <form action="/resetPassword" method="post">
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        
		        <input type="hidden" name="m_id" value="${realId}">
		        
		        <button type="submit" class="btn btn-danger w-100">
		            비밀번호 재설정
		        </button>
		    </form>
		</c:if>

        <button class="btn btn-primary w-100 mt-4"
                onclick="location.href='/login'">
            로그인으로 돌아가기
        </button>
    </div>
</div>
</body>
</html>

