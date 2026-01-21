<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${detail.f_name} - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/common.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        /* 상세페이지 전용 커스텀 스타일 */
        body { background-color: #f8f9f8; }
        .detail-wrap { margin: 60px auto; max-width: 1200px; padding: 0 20px; }
        
        /* 메인 박스 레이아웃 */
        .detail-main-card {
            background: #fff; border: 0; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            display: flex; flex-wrap: wrap; margin-bottom: 40px;
        }

        /* 왼쪽: 레시피 정보 */
        .recipe-section { flex: 1.4; padding: 40px; border-right: 1px solid #f0f0f0; }
        .recipe-img {
            width: 100%; height: 500px; object-fit: cover;
            border-radius: 4px; margin-bottom: 30px;
        }
        .recipe-title { font-size: 32px; font-weight: 800; color: #1b5e20; margin-bottom: 15px; }
        .recipe-category { 
            display: inline-block; padding: 4px 15px; background: #e8f5e9; 
            color: #2e7d32; border-radius: 20px; font-size: 13px; font-weight: bold; margin-bottom: 20px;
        }

        /* 오른쪽: 재료 구매 사이드바 */
        .purchase-section { flex: 1; padding: 40px; background-color: #fcfdfc; }
        .sidebar-title { font-size: 20px; font-weight: 800; border-bottom: 2px solid #198754; padding-bottom: 10px; margin-bottom: 25px; }
        
        .ingre-item { 
            display: flex; align-items: center; justify-content: space-between; 
            padding: 15px 0; border-bottom: 1px solid #eee; 
        }
        .ingre-info strong { font-size: 16px; display: block; }
        .ingre-price { color: #198754; font-weight: 800; font-size: 16px; }

        /* 레시피 및 재료 텍스트 박스 수정 */
        .recipe-box {
            background: #f9fbf9; 
            padding: 30px; 
            border-left: 5px solid #198754;
            font-size: 16px; 
            line-height: 2.0; /* 줄 간격을 넓혀 가독성 향상 */
            color: #444; 
            white-space: pre-line; /* pre-wrap 대신 pre-line을 쓰면 연속된 공백을 하나로 합쳐줍니다 */
		    text-align: left; 
		    word-break: keep-all; /* 단어 단위로 줄바꿈되어 더 깔끔합니다 */
		    margin: 15px 0 30px 0;
		    display: block; /* 영역 확실히 지정 */
		    width: 100%;
        }

        .kcal-img { width: 100%; height: auto; margin-top: 20px; border: 1px solid #eee; }

        /* 버튼 스타일 */
        .cart-btn-big {
            width: 100%; padding: 18px; background: #198754; color: #fff;
            border: none; font-size: 18px; font-weight: 800; margin-top: 20px; transition: 0.3s;
        }
        .cart-btn-big:hover { background: #146c43; }

        .btn-love {
            border: 1px solid #ff4757; color: #ff4757; background: #fff;
            padding: 10px 20px; font-weight: bold; transition: 0.2s;
        }
        .btn-love:hover { background: #ff4757; color: #fff; }
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
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="cartCountBadge">
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

<div class="detail-wrap">
    <div class="detail-main-card">
        <div class="recipe-section">
            <div class="recipe-category">${detail.f_category}</div>
            <h1 class="recipe-title">${detail.f_name}</h1>
            <p class="text-secondary mb-4">${detail.f_add}</p>
            
            <img src="/image/${detail.f_imgfilename}" class="recipe-img shadow-sm">
            
            <h5 class="fw-bold mb-3"><i class="bi bi-basket2-fill text-success"></i> 준비 재료</h5>
			<div class="recipe-box" style="background-color: #f0f7f0; border-left-color: #8bc34a;"><c:out value="${detail.f_ingredient}" /></div>
			
			<h5 class="fw-bold mb-3"><i class="bi bi-egg-fried text-success"></i> 요리 레시피</h5>
			<div class="recipe-box"><c:out value="${detail.f_recipe}" /></div>
            
            <h5 class="fw-bold mt-5 mb-3"><i class="bi bi-graph-up-arrow text-success"></i> 영양 성분 가이드</h5>
            <img src="/image/${detail.f_kcalfilename}" class="kcal-img rounded">
            
            <div class="d-flex justify-content-between align-items-center mt-5">
                <button class="btn btn-love" onclick="addLove('${detail.f_no}')">
                    <i class="bi bi-heart-fill"></i> 추천 <span id="loveCountText">${detail.f_love}</span>
                </button>
                <div class="btn-group">
                    <a href="/main" class="btn btn-outline-secondary px-4">목록으로</a>
                    <c:if test="${sessionScope.user.m_authority eq 'ADMIN'}">
                        <a href="/fedit?f_no=${detail.f_no}" class="btn btn-outline-success">수정</a>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="purchase-section">
            <div class="sidebar-title">식재료 바로구매</div>
            <div class="ingre-list mb-4">
                <c:forEach var="i" items="${ingrelist}">
                    <div class="ingre-item">
                        <div class="ingre-info">
                            <strong>${i.i_name}</strong>
                            <small class="text-muted">${i.i_origin}</small>
                        </div>
                        <div class="d-flex align-items-center gap-3">
                            <span class="ingre-price"><fmt:formatNumber value="${i.i_price}" pattern="#,###"/>원</span>
                            <select name="b_count" class="form-select form-select-sm" style="width: 65px;">
                                <c:forEach var="num" begin="1" end="10">
                                    <option value="${num}">${num}</option>
                                </c:forEach>
                            </select>
                            <button class="btn btn-sm btn-success" onclick="addBasket(this, '${i.i_no}', '${detail.f_no}')">
                                <i class="bi bi-plus-lg"></i>
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            <a href="/cartlist" class="text-decoration-none">
                <button class="cart-btn-big shadow">
                    <i class="bi bi-cart-check"></i> 장바구니 가기
                </button>
            </a>
            <p class="small text-muted text-center mt-3">
                <i class="bi bi-info-circle"></i> 신선한 재료를 집 앞으로 배송해 드립니다.
            </p>
        </div>
    </div>
</div>

<footer class="py-5 bg-light border-top mt-5">
    <div class="container text-center">
        <p class="text-muted mb-0">&copy; 2026 Greentable. All rights reserved.</p>
    </div>
</footer>

<script>
    function addBasket(btn, i_no, f_no) {
        if (!"${sessionScope.user}") {
            alert("로그인 후 이용 가능합니다.");
            location.href = "/login";
            return;
        }
        const b_count = $(btn).siblings('select').val();
      
        $.ajax({
            url: '/binsertAjax',
            type: 'POST',
            data: { i_no: i_no, f_no: f_no, b_count: b_count },
            success: function(data) {
                if (!isNaN(data)) {
                    alert("🛒 장바구니에 상품을 담았습니다.");
                    $("#cartCountBadge").text(data);
                } else {
                    alert("장바구니 담기에 실패했습니다.");
                }
            }
        });
    }
    
    function addLove(f_no) {
        if (!"${sessionScope.user}") {
            alert("로그인이 필요한 기능입니다.");
            return;
        }
        $.ajax({
            url: '/loveUpdate',
            type: 'post',
            data: { "f_no": f_no },
            success: function() {
                let current = parseInt($("#loveCountText").text());
                $("#loveCountText").text(current + 1);
                alert("❤️ 이 레시피를 추천했습니다!");
            }
        });
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