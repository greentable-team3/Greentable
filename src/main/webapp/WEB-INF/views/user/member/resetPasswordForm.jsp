<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 재설정 - Greentable</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .reset-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; width: 100%; max-width: 480px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
        .brand-logo { text-align: center; margin-bottom: 25px; }
        .brand-logo img { width: 160px; }
        .form-label { font-weight: 700; font-size: 13px; color: #555; }
        .form-control { padding: 11px; border-radius: 6px; font-size: 14px; }
        .btn-green { background: #198754; color: #fff; border: none; font-weight: 700; transition: 0.2s; white-space: nowrap; }
        .btn-green:hover { background: #146c43; }
        .input-group { gap: 5px; margin-bottom: 15px; }
        #auth-msg { font-size: 12px; font-weight: 600; display: block; margin-top: 5px; }
        .pw-section { background: #fcfdfc; padding: 20px; border-radius: 8px; border: 1px dashed #198754; margin-top: 20px; }
    </style>
</head>
<body>
<div class="reset-card">
    <div class="brand-logo">
        <a href="/main"><img src="/profile_images/green_table.png" alt="Greentable"></a>
        <h5 class="mt-3 fw-bold">비밀번호 재설정</h5>
    </div>
    <form id="resetPwForm">
        <div class="mb-3">
            <label class="form-label">아이디</label>
            <input type="text" id="m_id" name="m_id" class="form-control" placeholder="아이디를 입력하세요" required>
        </div>
        <label class="form-label">이메일 인증</label>
        <div class="input-group">
            <input type="email" id="m_email" name="m_email" class="form-control" placeholder="example@email.com" required>
            <button type="button" id="send-btn" class="btn btn-green rounded" onclick="sendFindPwEmail();">인증발송</button>
        </div>

        <div id="auth-section" style="display:none;">
            <label class="form-label">인증번호</label>
            <div class="input-group">
                <input type="text" id="auth_code" class="form-control" placeholder="6자리 숫자">
                <button type="button" id="verify-btn" class="btn btn-green rounded" onclick="verifyEmailCode();">인증확인</button>
            </div>
            <span id="auth-msg"></span>
        </div>

        <div id="password-reset-section" class="pw-section" style="display:none;">
            <div class="mb-3">
                <label class="form-label">새 비밀번호</label>
                <input type="password" id="new_pw" class="form-control" placeholder="8자 이상 입력">
            </div>
            <div class="mb-3">
                <label class="form-label">새 비밀번호 확인</label>
                <input type="password" id="new_pw2" class="form-control" placeholder="비밀번호 재입력">
            </div>
            <button type="button" class="btn btn-green w-100 py-3 mt-2" onclick="changePassword();">비밀번호 변경 완료</button>
        </div>
    </form>
    <div class="text-center mt-4 border-top pt-3">
        <a href="/login" class="text-muted small text-decoration-none">로그인으로 돌아가기</a>
    </div>
</div>
<script src="/js/member.js"></script>
</body>
</html>