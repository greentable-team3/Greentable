<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 레시피 관리 시스템</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    :root {
        --gt-bright-green: #8bc34a;
        --gt-dark-green: #76a336;
        --gt-soft-bg: #f8fbef;
        --gt-active-white: #ffffff;
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
        min-width: 260px;
        max-width: 260px;
        min-height: 100vh;
        background: linear-gradient(135deg, #a2d149 0%, #8bc34a 100%);
        color: white;
        position: fixed;
        box-shadow: 2px 0 10px rgba(0,0,0,0.05);
        z-index: 1000;
    }

    #sidebar .sidebar-header {
        padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2);
    }

    #sidebar ul li a {
        padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; font-weight: 500; transition: 0.3s;
    }

    #sidebar ul li a:hover {
        background: rgba(255, 255, 255, 0.1); padding-left: 40px; color: white;
    }

    #sidebar ul li.active > a {
        background: var(--gt-active-white); color: var(--gt-dark-green); font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
        box-shadow: -5px 5px 15px rgba(0,0,0,0.05);
    }

    /* 메인 영역 */
    #main-content {
        margin-left: 260px;
        width: calc(100% - 260px);
    }

    .navbar-admin {
        background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1;
    }

    .admin-card {
        background: white; padding: 35px; border-radius: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 35px; border: 1px solid #f0f3e8;
    }

    /* 필터 탭 스타일 */
    .filter-tab {
        text-decoration: none; padding: 10px 25px; border-radius: 30px;
        font-size: 0.9rem; font-weight: 600; color: #888; background: #f5f5f5;
        transition: 0.2s; margin-right: 10px; border: 1px solid transparent;
    }
    .filter-tab:hover { background: #eeeeee; color: #555; }
    .filter-tab.active { 
        background: var(--gt-soft-bg); color: var(--gt-dark-green); 
        border-color: var(--gt-bright-green);
    }

    /* 레시피 카드 디자인 */
    .recipe-card {
        border: none; border-radius: 20px; overflow: hidden;
        transition: 0.3s; border: 1px solid #f0f0f0; background: #fff;
    }
    .recipe-card:hover { 
        transform: translateY(-8px); 
        box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        border-color: var(--gt-bright-green);
    }
    
    .card-img-wrapper { 
        position: relative; height: 200px; overflow: hidden; 
    }
    .card-img-top { 
        width: 100%; height: 100%; object-fit: cover; transition: 0.5s;
    }
    .recipe-card:hover .card-img-top { transform: scale(1.1); }
    
    .kind-badge {
        position: absolute; top: 15px; left: 15px; z-index: 10;
        padding: 5px 15px; border-radius: 50px; font-size: 0.75rem; font-weight: bold;
        background: rgba(255,255,255,0.9); color: var(--gt-dark-green);
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .card-body { padding: 20px; }
    .recipe-title {
        font-weight: 700; color: var(--gt-text-main); font-size: 1.05rem;
        margin-bottom: 12px; height: 1.5em; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
    }

    .love-badge {
        color: #ff4757; background: #fff1f2; padding: 4px 10px; border-radius: 8px; font-size: 0.85rem; font-weight: bold;
    }

    .btn-add {
        background-color: var(--gt-bright-green); color: white; border: none;
        padding: 12px 25px; border-radius: 15px; font-weight: bold; transition: 0.3s;
    }
    .btn-add:hover { background-color: var(--gt-dark-green); color: white; transform: scale(1.05); }

</style>
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
        <nav class="navbar navbar-admin d-flex justify-content-between">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-journal-text me-2"></i> 레시피 콘텐츠 관리
            </div>
            <div class="small fw-bold">
                <span class="text-muted me-3">현재 접속자: <strong>Admin</strong></span>
                <a href="/myinfo" class="btn btn-sm btn-outline-success border-0"><i class="bi bi-person-circle"></i> 정보수정</a>
            </div>
        </nav>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-start mb-4">
                <div>
                    <h2 class="fw-bold mb-1" style="color: #4a6d1a;">
                        <c:choose>
                            <c:when test="${selectedKind == 'diet'}">🥗 다이어트 레시피 목록</c:when>
                            <c:when test="${selectedKind == 'protein'}">💪 단백질 식단 목록</c:when>
                            <c:otherwise>📋 전체 레시피 DB 관리</c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="text-muted small mb-4">사용자에게 노출되는 레시피 정보를 최신으로 유지하고 식단 태그를 관리합니다.</p>
                    
                    <div class="d-flex">
                        <a href="/foodlist" class="filter-tab ${empty selectedKind ? 'active' : ''}">전체보기</a>
                        <a href="/foodlist?f_kind=diet" class="filter-tab ${selectedKind == 'diet' ? 'active' : ''}">다이어트</a>
                        <a href="/foodlist?f_kind=protein" class="filter-tab ${selectedKind == 'protein' ? 'active' : ''}">단백질</a>
                    </div>
                </div>
                
                <c:if test="${sessionScope.m_no == 1}">
                    <a href="/finsertForm" class="btn btn-add shadow-sm">
                        <i class="bi bi-plus-circle me-2"></i>새 레시피 등록
                    </a>
                </c:if>
            </div>

            <div class="row mt-2">
                <c:forEach var="dto" items="${list}">
                    <div class="col-xl-3 col-lg-4 col-sm-6 mb-4">
                        <div class="card recipe-card h-100">
                            <div class="card-img-wrapper">
                                <span class="kind-badge">
                                    <c:choose>
                                        <c:when test="${dto.f_kind == 'diet'}">Diet</c:when>
                                        <c:otherwise>Protein</c:otherwise>
                                    </c:choose>
                                </span>
                                <a href="/fdetail?f_no=${dto.f_no}">
                                    <img src="/image/${dto.f_imgfilename}" class="card-img-top" alt="${dto.f_name}">
                                </a>
                            </div>
                            <div class="card-body">
                                <div class="recipe-title">${dto.f_name}</div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="love-badge"><i class="bi bi-heart-fill me-1"></i> ${dto.f_love}</span>
                                    <a href="/fdetail?f_no=${dto.f_no}" class="btn btn-sm btn-outline-success rounded-pill px-3">
                                        상세/수정
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty list}">
                <div class="text-center py-5">
                    <i class="bi bi-folder2-open fs-1 text-muted opacity-25"></i>
                    <p class="mt-3 text-muted fw-bold">등록된 레시피 데이터가 없습니다.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>