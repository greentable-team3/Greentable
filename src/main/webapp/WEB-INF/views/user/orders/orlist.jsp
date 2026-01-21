<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Greentable - 주문내역</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="/css/common.css">

    <style>
        /* 주문내역 전용 스타일: 메인 페이지의 카드 느낌 이식 */
        .order-content-wrap { margin: 60px auto; max-width: 1200px; padding: 0 20px; }
        .category-header { 
            margin-bottom: 30px; font-weight: 800; border-bottom: 2px solid #198754; 
            display: inline-block; padding-bottom: 5px; color: #1b5e20;
        }
        .order-card {
            background: #fff; border: 0; border-radius: 0;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08); padding: 30px;
        }
        .order-table { width: 100%; border-collapse: collapse; }
        .order-table thead th {
            background-color: #f1f8e9; color: #1b5e20; padding: 15px;
            font-size: 14px; font-weight: 700; border-bottom: 2px solid #198754; text-align: center;
        }
        .order-table tbody td {
            padding: 20px 15px; border-bottom: 1px solid #eee;
            vertical-align: middle; font-size: 14px; text-align: center;
        }
        .price-text { color: #198754; font-weight: 800; }
        .btn-detail {
            border: 1px solid #198754; color: #198754; background: #fff;
            font-weight: bold; padding: 6px 15px; transition: 0.3s; text-decoration: none;
        }
        .btn-detail:hover { background: #198754; color: #fff; }
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
        </div>
    </div>
</nav>

<div class="order-content-wrap">
    <h3 class="category-header">MY ORDER LIST</h3>
    
    <div class="order-card">
        <table class="order-table">
            <thead>
                <tr>
                    <th>주문번호</th>
                    <th>수신인</th>
                    <th>총 결제금액</th>
                    <th>배송지</th>
                    <th>요청사항</th>
                    <th>상세보기</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${list}">	
                    <tr>
                        <td><span class="text-secondary">#${dto.o_no}</span></td>
                        <td><strong>${dto.o_name}</strong></td>
                        <td><span class="price-text"><fmt:formatNumber value="${dto.o_total}" pattern="#,###"/>원</span></td>
                        <td class="text-start">
                            <div class="small fw-bold">${dto.o_tel}</div>
                            <div class="text-secondary small">${dto.o_addr}</div>
                        </td>
                        <td class="small text-secondary text-start">${dto.o_detail}</td>
                        <td><a href="/odetail?o_no=${dto.o_no}" class="btn-detail">조회</a></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr>
                        <td colspan="6" class="py-5 text-muted">주문 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="text-center mt-5">
            <a href="/main" class="btn btn-success px-5 py-2 fw-bold" style="border-radius:0;">홈으로 돌아가기</a>
        </div>
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