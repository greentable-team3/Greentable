<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 재료 정보 수정</title>
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
        box-shadow: 2px 0 10px rgba(0,0,0,0.05);
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
        margin: 60px auto; border: 1px solid #f0f3e8; max-width: 600px;
    }

    /* 폼 스타일 */
    .form-label { font-weight: 600; color: #444; margin-bottom: 8px; }
    .form-control {
        border-radius: 12px; padding: 14px; border: 1px solid #e2e8f0; transition: 0.3s;
    }
    .form-control:focus { border-color: var(--gt-bright-green); box-shadow: 0 0 0 4px rgba(139, 195, 74, 0.1); outline: none; }
    .form-control[readonly] { background-color: #f8fafc; color: #94a3b8; border-color: #f1f5f9; cursor: not-allowed; }

    /* 버튼 스타일 */
    .btn-submit {
        background-color: var(--gt-bright-green); color: white; border: none; padding: 14px 40px;
        border-radius: 15px; font-weight: 700; transition: 0.3s; flex: 1;
    }
    .btn-submit:hover { background-color: #76a336; transform: translateY(-3px); box-shadow: 0 8px 20px rgba(139, 195, 74, 0.3); color: white; }

    .btn-cancel {
        background-color: #f8fafc; color: #64748b; border: 1px solid #e2e8f0; padding: 14px 30px;
        border-radius: 15px; font-weight: 600; text-decoration: none; transition: 0.3s; flex: 1; text-align: center;
    }
    .btn-cancel:hover { background-color: #f1f5f9; color: #334155; }
</style>

<script>
function check(){
    const f = document.ingredients;
    if(!f.i_price.value) { alert("가격을 입력하세요."); f.i_price.focus(); return; }
    if(!f.i_origin.value) { alert("원산지를 입력하세요."); f.i_origin.focus(); return; }
    
    if(confirm("수정된 내용을 저장하시겠습니까?")) {
        f.submit();
    }
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
                <i class="bi bi-pencil-square me-2"></i> 재료 데이터 수정
            </div>
        </nav>

        <div class="admin-card">
            <div class="text-center mb-5">
                <div class="display-6 text-success mb-3"><i class="bi bi-clipboard2-check"></i></div>
                <h2 class="fw-bold" style="color: #4a6d1a;">재료 정보 수정</h2>
                <p class="text-muted">재료 번호 #${update.i_no}의 데이터를 업데이트합니다.</p>
            </div>

            <form name="ingredients" method="post" action="/iupdate">
                <input type="hidden" name="i_no" value="${update.i_no}"> 

                <div class="mb-4">
                    <label class="form-label">재료명 <small class="text-muted text-decoration-none">(수정 불가)</small></label>
                    <input type="text" class="form-control" value="${update.i_name}" readonly>
                </div>

                <div class="mb-4">
                    <label class="form-label">재료 가격 (원)</label>
                    <input type="number" name="i_price" class="form-control" value="${update.i_price}" placeholder="수정할 가격을 입력하세요">
                </div>

                <div class="mb-5">
                    <label class="form-label">원산지</label>
                    <input type="text" name="i_origin" class="form-control" value="${update.i_origin}" placeholder="수정할 원산지를 입력하세요">
                </div>

                <div class="d-flex gap-3">
                    <button type="button" class="btn-cancel" onclick="history.back();">
                        수정 취소
                    </button>
                    <button type="button" class="btn-submit shadow-sm" onclick="check()">
                        <i class="bi bi-check-lg me-1"></i> 수정 완료
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>