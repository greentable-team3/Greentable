<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인 - Greentable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .login-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; width: 100%; max-width: 400px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .brand-logo { text-align: center; margin-bottom: 30px; }
        .brand-logo img { width: 180px; }
        .form-label { font-weight: 700; font-size: 13px; color: #555; }
        .form-control { padding: 12px; border-radius: 6px; font-size: 15px; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25,135,84,0.1); }
        .btn-green { background: #198754; color: #fff; border: none; padding: 12px; font-weight: 700; width: 100%; margin-bottom: 10px; transition: 0.2s; }
        .btn-green:hover { background: #146c43; }
        .btn-kakao { display: block; margin-top: 15px; }
        .btn-kakao img { width: 100%; border-radius: 6px; }
        .alert-error { background-color: #fff1f0; color: #f5222d; padding: 10px; border: 1px solid #ffa39e; font-size: 13px; text-align: center; border-radius: 6px; margin-bottom: 20px; }
        .login-footer { text-align: center; margin-top: 25px; font-size: 13px; color: #888; border-top: 1px solid #eee; padding-top: 20px; }
        .login-footer a { color: #198754; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
<div class="login-card">
    <div class="brand-logo">
        <a href="/main"><img src="/profile_images/green_table.png" alt="Greentable"></a>
        <h5 class="mt-3 fw-bold">로그인</h5>
    </div>
    <form name="login" method="post" action="/j_spring_security_check">
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" name="j_username" class="form-control" placeholder="아이디를 입력하세요" required>
        </div>
        <div class="mb-3">
            <label class="form-label">비밀번호</label>
            <input type="password" name="j_password" class="form-control" placeholder="비밀번호를 입력하세요" required>
        </div>     
        <c:if test="${param.error eq 'true'}">
            <div class="alert-error"><i class="bi bi-exclamation-circle"></i> 아이디 또는 비밀번호가 틀렸습니다.</div>
        </c:if>
        <button type="submit" class="btn btn-green">로그인</button>
        <button type="button" class="btn btn-outline-secondary w-100 fw-bold" onclick="location.href='/signup'">회원가입</button>
        <a href="/oauth2/authorization/kakao" class="btn-kakao">
            <img src="/profile_images/kakao_login_medium_wide.png" alt="카카오 로그인">
        </a>
        <div class="login-footer">
            <a href="/findIdForm">아이디/비밀번호 찾기</a>
        </div>
    </form>
</div>
</body>
</html>