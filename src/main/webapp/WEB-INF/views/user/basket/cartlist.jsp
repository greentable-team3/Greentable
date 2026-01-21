<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Greentable - 장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="/css/common.css">

    <style>
        /* 장바구니 전용 보정 스타일 */
        .cart-content-wrap { margin: 60px auto; max-width: 1100px; padding: 0 20px; }
        .cart-card {
            background: #fff; border: 0; 
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); padding: 30px;
        }
        .cart-table { width: 100%; border-collapse: collapse; }
        .cart-table thead th {
            background-color: #f1f8e9; color: #1b5e20; padding: 15px;
            font-size: 14px; font-weight: 700; border-bottom: 2px solid #198754; text-align: center;
        }
        .cart-table tbody td {
            padding: 20px 15px; border-bottom: 1px solid #eee;
            vertical-align: middle; text-align: center; font-size: 15px;
        }
        .item-name { font-weight: bold; color: #333; text-align: left; }
        .price-text { color: #198754; font-weight: 800; }
        
        /* 수량 뱃지 스타일 */
        .qty-display {
            background: #f8f9fa; border: 1px solid #ddd; padding: 4px 12px;
            font-weight: bold; min-width: 40px; display: inline-block;
        }
        
        /* 버튼 스타일 커스텀 */
        .btn-action { font-size: 13px; font-weight: bold; border-radius: 0; }
        .btn-order-main {
            background-color: #198754; color: white; border: none;
            padding: 15px 60px; font-size: 18px; font-weight: bold; transition: 0.2s;
        }
        .btn-order-main:hover { background-color: #146c43; color: white; }
    </style>
</head>
<body>

<header class="top-header">
    <div class="container d-flex align-items-center justify-content-between">
        <a href="/main"><img src="/profile_images/green_table.png" alt="Logo" class="brand-logo"></a>
        <div class="search-container">
            <form action="/searchResult" method="get" class="search-bar">
                <select name="searchType" class="form-select">
                    <option value="f_name">음식명</option>
                </select>
                <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력해주세요.">
                <button type="submit" class="btn-search"><i class="bi bi-search"></i></button>
            </form>
        </div>
        <div class="user-nav">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
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
            <a href="/communitylistform">커뮤니티</a>
            <a href="/questionlistform">1:1 문의</a>
        </div>
    </div>
</nav>

<div class="cart-content-wrap">
    <h3 class="category-header">SHOPPING CART</h3>
    
    <div class="cart-card">
        <c:choose>
            <c:when test="${empty list}">
                <div class="text-center py-5">
                    <i class="bi bi-cart-x text-muted" style="font-size: 4rem;"></i>
                    <p class="mt-3 text-secondary fs-5">장바구니에 담긴 상품이 없습니다.</p>
                    <a href="/main" class="btn btn-outline-success mt-2 px-4 fw-bold" style="border-radius:0;">메뉴 보러가기</a>
                </div>
            </c:when>
            <c:otherwise>
                <form action="/oinsertForm" method="post">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th width="70">선택</th>
                                <th>상품 정보</th>
                                <th width="120">단가</th>
                                <th width="120">수량</th>
                                <th width="150">합계</th>
                                <th width="180">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="b" items="${list}">
                                <tr>
                                    <td>
                                        <input type="checkbox" name="b_no" value="${b.b_no}" class="form-check-input" checked>
                                    </td>
                                    <td class="item-name">${b.i_name}</td>
                                    <td><fmt:formatNumber value="${b.i_price}" pattern="#,###"/>원</td>
                                    <td><span class="qty-display">${b.b_count}</span></td>
                                    <td>
                                        <span class="price-text">
                                            <fmt:formatNumber value="${b.i_price * b.b_count}" pattern="#,###"/>원
                                        </span>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1 justify-content-center">
                                            <a href="/bedit?b_no=${b.b_no}" class="btn btn-sm btn-light border btn-action">수정</a>
                                            <a href="/bdelete?b_no=${b.b_no}" class="btn btn-sm btn-outline-danger btn-action" onclick="return confirm('삭제하시겠습니까?')">삭제</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between align-items-center mt-5">
                        <a href="/main" class="text-success fw-bold text-decoration-none">
                            <i class="bi bi-chevron-left"></i> 쇼핑 계속하기
                        </a>
                        <button type="submit" class="btn-order-main shadow-sm">주문하기</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

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