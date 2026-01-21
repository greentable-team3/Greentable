<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 레시피 데이터 수정</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    :root {
        --gt-bright-green: #8bc34a;
        --gt-dark-green: #76a336;
        --gt-soft-bg: #f8fbef;
        --gt-text-main: #2c3e50;
    }
    
    body {
        background-color: #fcfdfc;
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
        color: var(--gt-text-main);
    }

    /* 사이드바 스타일 유지 */
    #sidebar {
        min-width: 260px; max-width: 260px; min-height: 100vh;
        background: linear-gradient(135deg, #a2d149 0%, #8bc34a 100%);
        color: white; position: fixed; z-index: 1000;
    }
    #sidebar .sidebar-header { padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }
    #sidebar ul li a { padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; transition: 0.3s; }
    #sidebar ul li.active > a {
        background: white; color: var(--gt-dark-green); font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
    }

    #main-content { margin-left: 260px; width: calc(100% - 260px); }
    
    .navbar-admin { background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1; }
    
    .admin-card {
        background: white; padding: 40px; border-radius: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 35px; border: 1px solid #f0f3e8;
    }

    /* 폼 스타일 커스텀 */
    .form-label { font-weight: 700; color: var(--gt-dark-green); margin-bottom: 10px; display: flex; align-items: center; }
    .form-label i { margin-right: 8px; font-size: 1.1rem; }
    
    .form-control {
        border-radius: 12px; border: 1px solid #e0e6d8; padding: 12px 15px; transition: 0.3s;
    }
    .form-control:focus {
        border-color: var(--gt-bright-green); box-shadow: 0 0 0 0.25 margin-left: 260px;rem rgba(139, 195, 74, 0.15);
    }

    .info-readonly {
        background-color: #f9f9f9; border-radius: 12px; padding: 12px 15px; border: 1px solid #eee; color: #777; font-weight: 600;
    }

    .btn-update {
        background-color: var(--gt-bright-green); color: white; border: none;
        padding: 12px 35px; border-radius: 12px; font-weight: bold; transition: 0.3s;
    }
    .btn-update:hover { background-color: var(--gt-dark-green); transform: translateY(-2px); }
    
    .btn-reset {
        background-color: #f5f5f5; color: #666; border: none;
        padding: 12px 35px; border-radius: 12px; font-weight: bold; margin-left: 10px;
    }
</style>

<script>
function check(){
    let f_add = document.food.f_add;
    let f_ingredient = document.food.f_ingredient;
    let f_recipe = document.food.f_recipe;

    if(!f_add.value.trim()){
        alert("메뉴 소개를 입력하세요.");
        f_add.focus();
        return false;
    }
    if(!f_ingredient.value.trim()){
        alert("재료 정보를 입력하세요.");
        f_ingredient.focus();
        return false;
    }
    if(!f_recipe.value.trim()){
        alert("레시피 상세 내용을 입력하세요.");
        f_recipe.focus();
        return false;
    }

    if(confirm("입력하신 정보로 레시피를 수정하시겠습니까?")){
        document.food.submit();
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
            <li class="active"><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-pencil-square me-2"></i> 레시피 정보 수정
            </div>
        </nav>

        <div class="admin-card">
            <div class="mb-5">
                <h2 class="fw-bold mb-1" style="color: #4a6d1a;">콘텐츠 편집</h2>
                <p class="text-muted small">레시피의 설명, 필수 재료, 조리 순서를 업데이트합니다.</p>
            </div>

            <form name="food" method="post" action="/fupdate">
                <input type="hidden" name="f_no" value="${edit.f_no}">
                
                <div class="row mb-4">
                    <div class="col-md-4">
                        <label class="form-label"><i class="bi bi-hash"></i> 음식 번호</label>
                        <div class="info-readonly">${edit.f_no}</div>
                    </div>
                    <div class="col-md-8">
                        <label class="form-label"><i class="bi bi-tag"></i> 레시피 명칭</label>
                        <div class="info-readonly">${edit.f_name}</div>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label"><i class="bi bi-chat-quote"></i> 메뉴 소개</label>
                    <textarea name="f_add" class="form-control" rows="2" placeholder="간략한 메뉴 설명을 입력하세요">${edit.f_add}</textarea>
                </div>

                <div class="mb-4">
                    <label class="form-label"><i class="bi bi-egg-fried"></i> 필요 재료</label>
                    <textarea name="f_ingredient" class="form-control" rows="4" placeholder="예: 닭가슴살 200g, 고구마 1개, 브로콜리...">${edit.f_ingredient}</textarea>
                    <div class="form-text mt-2 text-muted">재료는 콤마(,)로 구분하여 입력하면 가독성이 좋습니다.</div>
                </div>

                <div class="mb-5">
                    <label class="form-label"><i class="bi bi-list-ol"></i> 조리법 (Recipe Steps)</label>
                    <textarea name="f_recipe" class="form-control" rows="8" placeholder="상세한 조리 순서를 입력하세요">${edit.f_recipe}</textarea>
                </div>

                <div class="text-center pt-4 border-top">
                    <button type="button" class="btn btn-update shadow-sm" onclick="check()">
                        <i class="bi bi-check-circle me-2"></i>레시피 수정 완료
                    </button>
                    <button type="reset" class="btn btn-reset">
                        다시 작성
                    </button>
                    <a href="/foodlist" class="btn btn-link text-muted text-decoration-none ms-3">취소하고 돌아가기</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>