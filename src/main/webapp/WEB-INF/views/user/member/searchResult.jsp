<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Greentable - 검색 결과</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        /* [공통 스타일] 메인과 동일하게 유지 */
        .card, .card-img-top, .btn, .form-control, .form-select { border-radius: 0 !important; }
        .card { transition: transform 0.3s; border: 0; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .card:hover { transform: translateY(-5px); }
        .card-img-top { height: 220px; object-fit: cover; }

        /* [1단: 상단 헤더 - 로고 확대 버전] */
        .top-header { padding: 30px 0; background-color: #fff; border-bottom: 1px solid #eee; }
        .brand-logo { height: 90px; width: auto; object-fit: contain; }
        
        .search-container { max-width: 650px; width: 100%; margin: 0 40px; }
        .search-bar { 
            border: 2px solid #198754; 
            height: 52px; 
            display: flex; 
            align-items: center; 
            background: #fff;
        }
        .search-bar .form-select { 
            width: 110px; border: none; font-weight: bold; font-size: 0.9rem; 
            background-color: #f8f9fa; height: 100%; border-right: 1px solid #eee !important;
        }
        .search-bar .form-control { border: none; box-shadow: none; font-size: 1.05rem; padding-left: 20px; height: 100%; }
        .search-bar .btn-search { background: transparent; color: #198754; border: none; font-size: 1.6rem; padding: 0 20px; height: 100%; }

        /* 유저 메뉴 */
        .user-nav { display: flex; align-items: center; gap: 25px; font-size: 0.85rem; color: #555; min-width: 220px; justify-content: flex-end; }
        .user-nav a { text-decoration: none; color: inherit; display: flex; flex-direction: column; align-items: center; gap: 3px; }
        .user-nav i { font-size: 1.6rem; color: #333; }

        /* [2단: 네비게이션 바] */
        .gnb-wrap { border-bottom: 2px solid #198754; background: #fff; z-index: 1000; }
        .gnb-container { display: flex; align-items: center; height: 60px; }
        .nav-links { display: flex; align-items: center; gap: 45px; } 
        .nav-links a { text-decoration: none; color: #333; font-weight: 700; font-size: 1.05rem; transition: 0.2s; }
        .nav-links a:hover { color: #198754; }

        /* [배너] 검색 전용 배너 */
        .search-banner {
            background: linear-gradient(135deg, #f1f8e9 0%, #c8e6c9 100%);
            padding: 60px 0; text-align: center;
        }
        .search-banner h1 { font-size: 3rem; font-weight: 900; color: #1b5e20; }
        
        .category-header { margin: 50px 0 25px 0; padding-bottom: 12px; border-bottom: 2px solid #198754; color: #198754; font-weight: 800; display: inline-block; }
    </style>
</head>
<body>

<header class="top-header">
    <div class="container d-flex align-items-center justify-content-between">
        <a href="/main">
            <img src="/profile_images/green_table.png" alt="Greentable Logo" class="brand-logo">
        </a>

        <div class="search-container">
            <form action="/searchResult" method="get" class="search-bar">
                <select name="searchType" class="form-select">
                    <option value="f_name" ${searchType == 'f_name' ? 'selected' : ''}>음식명</option>
                    <option value="f_recipe" ${searchType == 'f_recipe' ? 'selected' : ''}>레시피</option>
                </select>
                <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력해주세요." value="${keyword}">
                <button type="submit" class="btn-search">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>

        <div class="user-nav">
            <c:choose>
                <c:when test="${empty pageContext.request.userPrincipal}">
                    <a href="/login"><i class="bi bi-person"></i>로그인</a>
                    <a href="/signup"><i class="bi bi-person-plus"></i>회원가입</a>
                </c:when>
                <c:otherwise>
                	<a href="/olist"><i class="bi bi-truck"></i>주문내역</a>
                    <a href="/myinfo"><i class="bi bi-person-check"></i>마이페이지</a>
                    <a href="#" onclick="handleLogout()"><i class="bi bi-door-open"></i>로그아웃</a>
                </c:otherwise>
            </c:choose>
            <a href="/cartlist" class="position-relative">
                <i class="bi bi-bag-heart"></i>장바구니
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    ${not empty cartCount ? cartCount : 0}
                </span>
            </a>
        </div>
    </div>
</header>

<nav class="gnb-wrap sticky-top shadow-sm">
    <div class="container gnb-container">
        <div class="nav-links">
            <a href="/searchResult">전체식단</a>
            <a href="/searchResult?searchType=f_kind&keyword=diet">다이어트</a>
            <a href="/searchResult?searchType=f_kind&keyword=protein">단백질</a>
            <a href="/searchResult?searchType=f_category&keyword=식사류">식사</a>
            <a href="/searchResult?searchType=f_category&keyword=디저트류">디저트</a>
            <a href="/communitylistform">커뮤니티</a>
            <a href="/questionlistform">1:1 문의</a>
        </div>
    </div>
</nav>

<main class="container my-5">
    <c:choose>
        <c:when test="${not empty list}">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-5">
                <c:forEach items="${list}" var="food">
                    <div class="col">
                        <div class="card h-100 shadow-sm">
                            <a href="/fdetail?f_no=${food.f_no}">
                                <img src="/image/${food.f_imgfilename}" class="card-img-top" alt="${food.f_name}">
                            </a>
                            <div class="card-body">
                                <h5 class="card-title fw-bold">${food.f_name}</h5>
                                <p class="card-text text-secondary small">${food.f_add}</p>
                            </div>
                            <div class="card-footer bg-white border-0 pb-3">
                                <a href="/fdetail?f_no=${food.f_no}" class="btn btn-sm btn-outline-success w-100 fw-bold">레시피 상세보기</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-5">
                <i class="bi bi-exclamation-circle text-muted" style="font-size: 4rem;"></i>
                <h3 class="mt-4 fw-bold">검색 결과가 없습니다.</h3>
                <p class="text-muted">다른 검색어를 입력하시거나 카테고리 메뉴를 이용해 보세요.</p>
                <a href="/main" class="btn btn-success px-5 mt-3 py-2 fw-bold">메인으로 돌아가기</a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<footer class="py-5 bg-light border-top mt-5">
    <div class="container text-center">
        <p class="text-muted mb-0">&copy; 2026 Greentable. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script>
function handleLogout() {
    const auth = "${sessionScope.m_authority}"; 
    if (auth === "KAKAO") {
        const restApiKey = "2d3fdb24faa5714d6045ec8a349c7b57";
        const redirectUri = encodeURIComponent("http://localhost:8080/logout"); 
        location.href = "https://kauth.kakao.com/oauth/logout?client_id=" + restApiKey + "&logout_redirect_uri=" + redirectUri;
    } else {
        location.href = "/logout";
    }
}
</script>
</body>
</html>