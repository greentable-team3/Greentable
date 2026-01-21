<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Greentable - Healthy Choice</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/common.css">
    
    <style>
        /* 2. common.css에 넣지 않은 '메인 전용' 스타일만 남깁니다 */
        .main-banner { position: relative; background: linear-gradient(135deg, #f1f8e9 0%, #c8e6c9 100%); height: 520px; overflow: hidden; display: flex; align-items: center; }
        .banner-content { position: relative; z-index: 30; padding-left: 8%; }
        .banner-content h1 { font-size: 3.8rem; font-weight: 900; color: #1b5e20; letter-spacing: -2px; line-height: 1.1; }
        .banner-item { position: absolute; z-index: 5; animation: floatAnim 10s infinite ease-in-out; }
        .item-img { width: 380px; height: 380px; background-size: cover; background-position: center; border: 12px solid #fff; box-shadow: 0 20px 40px rgba(0,0,0,0.12); border-radius: 50%; }
        .pos-1 { right: 8%; top: 10%; }
        @keyframes floatAnim { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-30px); } }
        .category-header { margin: 60px 0 30px 0; font-weight: 800; border-bottom: 2px solid #198754; display: inline-block; padding-bottom: 5px; }
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
                    <option value="f_name">음식명</option>
                    <option value="f_recipe">레시피</option>
                </select>
                <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력해주세요.">
                <button type="submit" class="btn-search"><i class="bi bi-search"></i></button>
            </form>
        </div>
        <div class="user-nav">
            <c:choose>
                <c:when test="${empty pageContext.request.userPrincipal}">
                    <a href="/login"><i class="bi bi-person"></i>로그인</a>
                    <a href="/signup"><i class="bi bi-person-plus"></i>회원가입</a>
                </c:when>
                <c:otherwise>
                    <c:if test="${sessionScope.user.m_authority eq 'ADMIN'}">
                        <a href="/admin/olist" style="color: #198754; font-weight: bold;">
                            <i class="bi bi-shield-lock-fill"></i>관리자센터
                        </a>
                    </c:if>
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
            <a href="/communitylistform">커뮤니티</a>
            <a href="/questionlistform">1:1 문의</a>
            
            <c:if test="${sessionScope.user.m_authority eq 'ADMIN'}">
                <a href="/admin/olist" style="color: #198754; border-left: 1px solid #ddd; padding-left: 20px;">
                    <i class="bi bi-gear-fill"></i> 통합 관리 시스템
                </a>
            </c:if>
        </div>
    </div>
</nav>

<section class="main-banner">
    <div class="banner-content">
        <h1>Fresh Choice,<br>Green Table Life.</h1>
        <p class="mt-3 fs-5 text-secondary">건강한 일상을 위한 가장 쉬운 선택,<br>매번 새로운 추천 메뉴를 만나보세요.</p>
        <a href="#menu-start" class="btn btn-success mt-4 px-5 py-3 fw-bold shadow-sm">추천 메뉴 보기</a>
    </div>
    <c:if test="${not empty proteinList && proteinList.size() > 0}">
        <div class="banner-item pos-1">
            <a href="/fdetail?f_no=${proteinList[0].f_no}">
                <div class="item-img" style="background-image: url('/image/${proteinList[0].f_imgfilename}');"></div>
            </a>
            <div class="text-center mt-3 fw-bold fs-5">${proteinList[0].f_name}</div>
        </div>
    </c:if>
</section>

<main class="container" id="menu-start">
    <h3 class="category-header">PROTEIN MENU</h3>
    <div class="masonry-grid mb-5">
        <c:forEach items="${proteinList}" var="food">
            <div class="menu-item shadow-sm">
                <div class="menu-img-box">
                    <a href="/fdetail?f_no=${food.f_no}">
                        <img src="/image/${food.f_imgfilename}" alt="${food.f_name}">
                    </a>
                </div>
                <div class="menu-info-box">
                    <h5 class="fw-bold">${food.f_name}</h5>
                    <p class="text-secondary small">${food.f_add}</p>
                    <a href="/fdetail?f_no=${food.f_no}" class="btn btn-sm btn-outline-success w-100 fw-bold">레시피 보기</a>
                </div>
            </div>
        </c:forEach>
    </div>

    <h3 class="category-header">DIET MENU</h3>
    <div class="masonry-grid mb-5">
        <c:forEach items="${dietList}" var="food">
            <div class="menu-item shadow-sm">
                <div class="menu-img-box">
                    <a href="/fdetail?f_no=${food.f_no}">
                        <img src="/image/${food.f_imgfilename}" alt="${food.f_name}">
                    </a>
                </div>
                <div class="menu-info-box">
                    <h5 class="fw-bold">${food.f_name}</h5>
                    <p class="text-secondary small">${food.f_add}</p>
                    <a href="/fdetail?f_no=${food.f_no}" class="btn btn-sm btn-outline-success w-100 fw-bold">레시피 보기</a>
                </div>
            </div>
        </c:forEach>
    </div>
</main>

<footer class="py-5 bg-light border-top mt-5">
    <div class="container text-center">
        <p class="text-muted mb-0">&copy; 2026 Greentable. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>


<c:if test="${not empty mainNotice}">
    <div id="notice-popup" style="display:none; position: fixed; top: 120px; left: 50px; z-index: 9999; background: white; border: 2px solid #198754; box-shadow: 0 10px 30px rgba(0,0,0,0.3); width: 380px; border-radius: 12px; overflow: hidden;">
        <div style="background: #198754; color: white; padding: 12px 15px; font-weight: bold; display: flex; justify-content: space-between; align-items: center;">
            <span>📢 공지사항</span>
            <button type="button" onclick="closePopup()" style="background:none; border:none; color:white; cursor:pointer; font-size: 20px;">&times;</button>
        </div>
        <div style="padding: 20px; max-height: 400px; overflow-y: auto;">
            <h5 style="font-weight: 800; color: #333; margin-bottom: 15px;">${mainNotice.c_title}</h5>
            <c:if test="${not empty mainNotice.c_img}">
                <div style="text-align:center; margin-bottom:15px;">
                    <img src="/upload/${mainNotice.c_img}" style="width: 100%; border-radius: 8px;">
                </div>
            </c:if>
            <p style="font-size: 14px; color: #666; line-height: 1.6; white-space: pre-wrap;">${mainNotice.c_content}</p>
        </div>
        <div style="background: #f8f9fa; padding: 12px; text-align: right; border-top: 1px solid #eee; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <input type="checkbox" id="today-check" style="cursor:pointer;"> 
                <label for="today-check" style="font-size: 12px; cursor:pointer; color: #555; user-select: none;">오늘 하루 보지 않기</label>
            </div>
            <button type="button" onclick="closePopupWithCookie()" class="btn btn-sm btn-dark px-3" style="font-size:12px;">닫기</button>
        </div>
    </div>
</c:if>

<script>

document.addEventListener("DOMContentLoaded", function() {
    // 1. 쿠키 값이 "true"가 아닐 때만 팝업을 보여줌
    if (getCookie("hideNotice") !== "true") {
        const popup = document.getElementById("notice-popup");
        if (popup) {
            popup.style.display = "block"; // 숨겨진 팝업을 화면에 표시
        }
    }
});

function closePopup() {
	const popup = document.getElementById("notice-popup");
	if (popup) popup.style.display = "none";
	}


	function closePopupWithCookie() {
	if (document.getElementById("today-check").checked) {
	setCookie("hideNotice", "true", 1);
	}
	closePopup();
	}



function setCookie(name, value, days) {
let date = new Date();
date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
document.cookie = name + "=" + value + ";expires=" + date.toUTCString() + ";path=/";
}



function getCookie(name) {
let value = "; " + document.cookie;
let parts = value.split("; " + name + "=");
if (parts.length === 2) return parts.pop().split(";").shift();
}

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