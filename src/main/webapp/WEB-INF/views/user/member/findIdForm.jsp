<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기 - Greentable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .find-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; width: 100%; max-width: 420px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .brand-logo { text-align: center; margin-bottom: 25px; }
        .brand-logo img { width: 160px; }
        .form-control { padding: 12px; border-radius: 6px; margin-bottom: 12px; }
        .btn-green { background: #198754; color: #fff; border: none; padding: 12px; font-weight: 700; width: 100%; transition: 0.2s; }
        .btn-green:hover { background: #146c43; }
        .alert { border-radius: 6px; font-size: 14px; text-align: center; margin-top: 15px; font-weight: 700; }
        .btn-reset { background: #fff; border: 1px solid #ff4757; color: #ff4757; font-weight: 700; width: 100%; padding: 10px; margin-top: 10px; }
        .btn-reset:hover { background: #fff1f1; }
    </style>
</head>
<body>
<div class="find-card">
    <div class="brand-logo">
        <a href="/main"><img src="/profile_images/green_table.png" alt="Greentable"></a>
        <h5 class="mt-3 fw-bold">아이디 찾기</h5>
    </div>
    <form action="/findId" method="post">
        <p class="text-center text-muted small mb-4">가입 시 사용한 이메일을 입력하세요</p>
        <input type="email" name="m_email" class="form-control" placeholder="example@email.com" required>
        <button type="submit" class="btn btn-green">아이디 확인</button>
    </form>
    <c:if test="${not empty msg}">
        <div class="alert alert-danger"><i class="bi bi-exclamation-circle"></i> ${msg}</div>
    </c:if>
    <c:if test="${not empty foundId}"> 
        <c:forEach var="m" items="${idList}">
            <div class="alert alert-success"><i class="bi bi-check-circle"></i> 아이디: ${fn:substring(m.m_id, 0, 3)}***</div>
        </c:forEach>
        <button type="button" class="btn btn-reset" onclick="location.href='/resetPasswordForm'">비밀번호 재설정하기</button>
    </c:if>
    <div class="text-center mt-4">
        <a href="/login" class="text-muted small text-decoration-none"><i class="bi bi-arrow-left"></i> 로그인으로 돌아가기</a>
    </div>
</div>
</body>
</html>