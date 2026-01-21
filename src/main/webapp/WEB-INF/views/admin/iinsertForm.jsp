<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 신규 재료 등록</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    :root {
        --gt-bright-green: #8bc34a;
        --gt-soft-bg: #f8fbef;
        --gt-text-main: #2c3e50;
    }
    
    body {
        background-color: #fcfdfc;
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
        color: var(--gt-text-main);
    }

    /* 사이드바 스타일 통일 */
    #sidebar {
        min-width: 260px; max-width: 260px; min-height: 100vh;
        background: linear-gradient(135deg, #a2d149 0%, #8bc34a 100%);
        color: white; position: fixed; z-index: 1000;
    }

    #sidebar .sidebar-header { padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }

    #sidebar ul li a { padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; font-weight: 500; transition: 0.3s; }

    #sidebar ul li a:hover { background: rgba(255, 255, 255, 0.1); padding-left: 40px; color: white; }

    #sidebar ul li.active > a {
        background: white; color: #76a336; font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
    }

    /* 메인 컨텐츠 영역 */
    #main-content { margin-left: 260px; width: calc(100% - 260px); }

    .navbar-admin { background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1; }

    .admin-card {
        background: white; padding: 45px; border-radius: 30px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 60px auto; border: 1px solid #f0f3e8; max-width: 600px; /* 입력창이 적으므로 너비를 좁힘 */
    }

    /* 폼 스타일 */
    .form-label { font-weight: 600; color: #444; margin-bottom: 8px; }
    .form-control {
        border-radius: 12px; padding: 14px; border: 1px solid #e2e8f0; transition: 0.3s;
    }
    .form-control:focus { border-color: var(--gt-bright-green); box-shadow: 0 0 0 4px rgba(139, 195, 74, 0.1); outline: none; }

    .btn-submit {
        background-color: var(--gt-bright-green); color: white; border: none; padding: 14px 40px;
        border-radius: 15px; font-weight: 700; transition: 0.3s;
    }
    .btn-submit:hover { background-color: #76a336; transform: translateY(-3px); box-shadow: 0 8px 20px rgba(139, 195, 74, 0.3); color: white; }

    .btn-cancel {
        background-color: #f8fafc; color: #64748b; border: 1px solid #e2e8f0; padding: 14px 30px;
        border-radius: 15px; font-weight: 600; text-decoration: none; transition: 0.3s;
    }
</style>

<script>
function check(){
    const f = document.ingredients;
    if(!f.i_name.value) { alert("재료명을 입력하세요."); f.i_name.focus(); return; }
    if(!f.i_price.value) { alert("가격을 입력하세요."); f.i_price.focus(); return; }
    if(!f.i_origin.value) { alert("원산지를 입력하세요."); f.i_origin.focus(); return; }
    
    f.submit();
}
</script>
</head>
<body>

<div class="d-flex">
    <nav id="sidebar">
        <div class="sidebar-header">
            <h3 class="fw-bold mb-0"><i class="bi bi-flower1"></i> GREEN</h3>
            <span class="small" style="opacity: 0.8;">Admin Management</span>
        </div>
        <ul class="list-unstyled mt-4">
            <li><a href="/main"><i class="bi bi-house me-2"></i> 쇼핑몰 홈</a></li>
            <li><a href="/admin/olist"><i class="bi bi-box-seam me-2"></i> 주문 배송 관리</a></li>
            <li><a href="/admincommunityList"><i class="bi bi-chat-left-dots me-2"></i> 커뮤니티 관리</a></li>
            <li><a href="/adminquestionManage"><i class="bi bi-headset me-2"></i> 1:1 문의 관리</a></li>
            <li><hr class="mx-4 opacity-25"></li>
            <li><a href="/alist"><i class="bi bi-people me-2"></i> 회원 관리</a></li>
            <li><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li class="active"><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-basket-fill me-2"></i> 신규 식재료 시스템 등록
            </div>
        </nav>

        <div class="admin-card">
            <div class="text-center mb-5">
                <div class="display-6 text-success mb-3"><i class="bi bi-plus-circle-dotted"></i></div>
                <h2 class="fw-bold" style="color: #4a6d1a;">재료 정보 입력</h2>
                <p class="text-muted">재고 관리에 사용될 정확한 재료 정보를 입력해 주세요.</p>
            </div>

            <form name="ingredients" method="post" action="/iinsert">
                <div class="mb-4">
                    <label class="form-label">재료명</label>
                    <input type="text" name="i_name" class="form-control" placeholder="예: 무농약 닭가슴살">
                </div>

                <div class="mb-4">
                    <label class="form-label">재료 가격 (원)</label>
                    <input type="number" name="i_price" class="form-control" placeholder="숫자만 입력해 주세요">
                </div>

                <div class="mb-5">
                    <label class="form-label">원산지</label>
                    <input type="text" name="i_origin" class="form-control" placeholder="예: 국내산 (전남 나주)">
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <a href="/inlist" class="btn-cancel text-center">
                        취소
                    </a>
                    <button type="button" class="btn-submit shadow-sm" onclick="check()">
                        <i class="bi bi-check-lg me-1"></i> 재료 등록 완료
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>