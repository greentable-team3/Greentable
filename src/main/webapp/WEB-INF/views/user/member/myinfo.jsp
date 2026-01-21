<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>마이페이지 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/common.css">

    <style>
        /* 마이페이지 전용 보정 스타일 */
        .my-content-wrap { margin: 60px auto; max-width: 800px; padding: 0 20px; }
        
        .my-card {
            background: #fff; border: 0; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.08); padding: 40px;
        }

        /* 프로필 섹션 */
        .profile-section {
            text-align: center; margin-bottom: 40px; padding-bottom: 30px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .profile-img {
            width: 140px; height: 140px; object-fit: cover;
            border-radius: 50%; border: 4px solid #f1f8e9;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1); margin-bottom: 15px;
        }

        /* 정보 테이블 */
        .info-table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
        .info-table th {
            width: 30%; background-color: #fcfdfc; color: #555;
            padding: 18px 20px; border-bottom: 1px solid #eee; text-align: left;
            font-size: 15px; font-weight: 700;
        }
        .info-table td {
            padding: 18px 20px; border-bottom: 1px solid #eee;
            font-size: 15px; color: #333;
        }

        /* 버튼 그룹 */
        .btn-group-custom { display: flex; gap: 10px; justify-content: center; margin-top: 30px; }
        .btn-custom {
            padding: 12px 30px; font-weight: bold; border-radius: 0; font-size: 14px;
            transition: 0.2s; text-decoration: none; display: inline-block;
        }
        
        .btn-edit { background: #198754; color: #fff; border: 1px solid #198754; }
        .btn-edit:hover { background: #146c43; }
        
        .btn-resign { background: #fff; color: #999; border: 1px solid #ddd; }
        .btn-resign:hover { background: #fff1f1; color: #ff4757; border-color: #ff4757; }

        .btn-back { background: #666; color: #fff; border: 1px solid #555; }
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

<div class="my-content-wrap">
    <h3 class="category-header">MY PAGE</h3>
    
    <div class="my-card">
        <div class="profile-section">
            <c:choose>
                <c:when test="${member.m_image eq 'default.png' or empty member.m_image}">
                    <img src="/profile_images/default.png" class="profile-img">
                </c:when>
                <c:otherwise>
                    <img src="/upload/${member.m_image}" class="profile-img">
                </c:otherwise>
            </c:choose>
            <div class="mt-2">
                <span class="badge bg-success">MEMBER</span>
                <h4 class="mt-2 fw-bold">${member.m_name}님, 환영합니다!</h4>
            </div>
        </div>

        <table class="info-table">
            <tr>
                <th>회원번호</th>
                <td># ${member.m_no}</td>
            </tr>
            <tr>
                <th>아이디</th>
                <td><strong>${member.m_id}</strong></td>
            </tr>
            <tr>
                <th>이름</th>
                <td>${member.m_name}</td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td>${member.m_tel}</td>
            </tr>
        </table>

        <sec:authorize access="hasAnyAuthority('ADMIN','USER')">
            <div class="btn-group-custom">
                <a href="/passwordCheckForm?m_no=${m_no}&mode=update" class="btn-custom btn-edit">회원 정보 수정</a>
                <a href="/passwordCheckForm?m_no=${m_no}&mode=delete" class="btn-custom btn-resign">회원 탈퇴</a>
            </div>
        </sec:authorize>

        <div class="text-center mt-5">
            <a href="/main" class="btn-custom btn-back">홈으로 돌아가기</a>
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