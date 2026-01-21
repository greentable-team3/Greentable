<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 레시피 신규 등록</title>
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
        margin: 40px auto; border: 1px solid #f0f3e8; max-width: 850px;
    }

    /* 폼 스타일 */
    .form-label { font-weight: 600; color: #444; margin-bottom: 8px; margin-top: 15px; }
    .form-control, .form-select {
        border-radius: 12px; padding: 12px; border: 1px solid #e2e8f0; transition: 0.3s;
    }
    .form-control:focus { border-color: var(--gt-bright-green); box-shadow: 0 0 0 4px rgba(139, 195, 74, 0.1); }

    /* 라디오 버튼 커스텀 */
    .form-check-input:checked { background-color: var(--gt-bright-green); border-color: var(--gt-bright-green); }

    .btn-submit {
        background-color: var(--gt-bright-green); color: white; border: none; padding: 15px 40px;
        border-radius: 15px; font-weight: 700; transition: 0.3s; width: 200px;
    }
    .btn-submit:hover { background-color: #76a336; transform: translateY(-3px); box-shadow: 0 8px 20px rgba(139, 195, 74, 0.3); color: white; }
</style>

<script>
function check(){
    let f = document.food;
    
    if(!f.f_name.value){ alert("음식명을 입력하세요."); f.f_name.focus(); return false; }
    if(!f.f_kind.value){ alert("음식분류를 선택하세요."); return false; }
    if(!f.f_category.value){ alert("카테고리를 선택하세요."); return false; }
    if(!f.f_add.value){ alert("메뉴 소개를 입력하세요."); f.f_add.focus(); return false; }
    if(!f.f_ingredient.value){ alert("재료를 입력하세요."); f.f_ingredient.focus(); return false; }
    if(!f.f_recipe.value){ alert("레시피를 입력하세요."); f.f_recipe.focus(); return false; }
    if(!f.f_img.value){ alert("음식 사진을 첨부하세요."); return false; }
    if(!f.f_kcal.value){ alert("영양성분 사진을 첨부하세요."); return false; }

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
            <li class="active"><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-plus-circle me-2"></i> 새로운 레시피 등록
            </div>
        </nav>

        <div class="admin-card">
            <div class="text-center mb-5">
                <h2 class="fw-bold" style="color: #4a6d1a;">신규 레시피 작성</h2>
                <p class="text-muted">사용자에게 보여질 음식 정보와 조리법을 상세히 입력해 주세요.</p>
            </div>

            <form name="food" method="post" action="/finsert" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">레시피명</label>
                        <input type="text" name="f_name" class="form-control" placeholder="예: 닭가슴살 샐러드">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label d-block">식단 분류</label>
                        <div class="mt-2">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="f_kind" id="diet" value="diet">
                                <label class="form-check-label" for="diet">다이어트</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="f_kind" id="protein" value="protein">
                                <label class="form-check-label" for="protein">단백질</label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label class="form-label d-block">카테고리</label>
                        <div class="mt-2">
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="f_category" id="meal" value="식사류">
                                <label class="form-check-label" for="meal">식사류</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="f_category" id="dessert" value="디저트류">
                                <label class="form-check-label" for="dessert">디저트</label>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label">메뉴 한줄 소개</label>
                        <textarea class="form-control" rows="2" name="f_add" placeholder="메뉴에 대한 간단한 설명을 적어주세요."></textarea>
                    </div>

                    <div class="col-12 mb-3">
                        <label class="form-label">필요 재료</label>
                        <textarea class="form-control" rows="3" name="f_ingredient" placeholder="필요한 재료들을 입력하세요."></textarea>
                    </div>

                    <div class="col-12 mb-4">
                        <label class="form-label">조리법(레시피)</label>
                        <textarea class="form-control" rows="6" name="f_recipe" placeholder="단계별 조리 과정을 상세히 입력하세요."></textarea>
                    </div>

                    <div class="col-md-6 mb-4">
                        <label class="form-label"><i class="bi bi-image me-1"></i> 음식 대표 이미지</label>
                        <input type="file" name="f_img" class="form-control">
                    </div>
                    <div class="col-md-6 mb-4">
                        <label class="form-label"><i class="bi bi-graph-up-arrow me-1"></i> 영양성분(칼로리) 표</label>
                        <input type="file" name="f_kcal" class="form-control">
                    </div>
                </div>

                <hr class="my-4 opacity-25">

                <div class="text-center mt-4">
                    <button type="button" class="btn-submit shadow-sm me-2" onclick="check()">
                        <i class="bi bi-check-lg me-1"></i> 레시피 등록
                    </button>
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-4 py-2" onclick="history.back()">
                        등록 취소
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>