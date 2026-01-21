<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 관리자 보안 인증</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    :root {
        --gt-bright-green: #8bc34a;
        --gt-text-main: #2c3e50;
    }
    
    body {
        background-color: #f8fbef; /* 연한 초록빛 배경 */
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
    }

    .auth-card {
        background: white;
        padding: 50px 40px;
        border-radius: 30px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.08);
        width: 100%;
        max-width: 450px;
        text-align: center;
        border: 1px solid #e0eacc;
    }

    .auth-icon {
        font-size: 3.5rem;
        color: var(--gt-bright-green);
        margin-bottom: 20px;
    }

    .form-control {
        border-radius: 12px;
        padding: 15px;
        text-align: center;
        font-size: 1.2rem;
        letter-spacing: 5px;
        border: 2px solid #eee;
        transition: 0.3s;
    }

    .form-control:focus {
        border-color: var(--gt-bright-green);
        box-shadow: 0 0 0 4px rgba(139, 195, 74, 0.1);
        outline: none;
    }

    .btn-submit {
        background-color: var(--gt-bright-green);
        color: white;
        border: none;
        padding: 15px;
        border-radius: 12px;
        font-weight: 700;
        width: 100%;
        margin-top: 20px;
        transition: 0.3s;
    }

    .btn-submit:hover {
        background-color: #76a336;
        transform: translateY(-2px);
    }

    .btn-back {
        color: #888;
        text-decoration: none;
        font-size: 0.9rem;
        display: inline-block;
        margin-top: 20px;
        transition: 0.3s;
    }

    .btn-back:hover {
        color: #334155;
    }

    .error-msg {
        color: #e53935;
        font-weight: bold;
        font-size: 0.9rem;
        margin-top: 15px;
        background: #fff5f5;
        padding: 10px;
        border-radius: 8px;
    }
</style>
</head>
<body>

<div class="auth-card">
    <div class="auth-icon">
        <i class="bi bi-shield-lock-fill"></i>
    </div>
    
    <h3 class="fw-bold mb-2">관리자 인증</h3>
    <p class="text-muted small mb-4">
        보안을 위해 <strong>관리자 인증 번호</strong>를<br> 입력해 주시기 바랍니다.
    </p>

    <form name="adminCheckForm" method="post" action="/adminCheck">
        <input type="hidden" name="m_no" value="${m_no}"> 
        <input type="hidden" name="mode" value="${mode}">  

        <div class="mb-3">
            <input type="password" name="adminCode" class="form-control" placeholder="••••••" autofocus>
        </div>

        <c:if test="${not empty msg}">
            <div class="error-msg">
                <i class="bi bi-exclamation-circle me-1"></i> ${msg}
            </div>
        </c:if>

        <button type="submit" class="btn-submit shadow-sm">
            인증 및 진행하기
        </button>
    </form>

    <a href="/alist" class="btn-back">
        <i class="bi bi-arrow-left me-1"></i> 회원 목록으로 돌아가기
    </a>
</div>

</body>
</html>