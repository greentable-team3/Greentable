<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 게시판</title>
    <style>
        /* 1. 전역 스타일: 실무 커머스 고밀도 레이아웃 */
        body { 
            font-family: "Malgun Gothic", dotum, sans-serif; 
            background-color: #f8f9f8; 
            padding: 40px 0; 
            color: #333;
            margin: 0;
            line-height: 1.4;
        }
        
        .board-container { 
            width: 1000px; 
            margin: 0 auto; 
            background: #fff; 
            padding: 30px; 
            border: 1px solid #ddd;
            border-radius: 0; /* 라운드 제거 */
        }

        /* 2. 타이틀 & 상단 네비게이션: 촘촘한 배치 */
        h2 { 
            text-align: left; 
            margin-bottom: 25px; 
            color: #222; 
            font-weight: bold; 
            font-size: 24px;
            border-bottom: 2px solid #333;
            padding-bottom: 15px;
        }

        .top-nav {
            display: flex;
            justify-content: flex-start;
            gap: 5px;
            margin-bottom: 20px;
        }

        .nav-link {
            text-decoration: none;
            color: #666;
            font-weight: bold;
            font-size: 12px;
            padding: 6px 12px;
            border-radius: 2px;
            background: #fff;
            border: 1px solid #ccc;
            transition: 0.1s;
        }

        .nav-link:hover {
            background: #f4f4f4;
            color: #333;
        }

        /* 3. 검색 영역: 실무형 가로 정렬 바 */
        .search-section {
            background: #f9f9f9;
            padding: 15px;
            border: 1px solid #eee;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
        }

        .search-section select, .search-section input[type="text"] {
            padding: 6px 10px;
            border: 1px solid #ccc;
            border-radius: 0;
            margin-right: 5px;
            font-size: 13px;
            background: #fff;
        }

        .search-section button {
            background: #82cd47; /* 싱그러운 연두색 */
            color: white;
            border: 1px solid #71bb3a;
            padding: 6px 15px;
            border-radius: 2px;
            font-weight: bold;
            font-size: 13px;
            cursor: pointer;
        }

        /* 4. 테이블 스타일: 빽빽하고 명확한 구분 */
        .list-table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-bottom: 25px;
            border-top: 1px solid #333;
        }
        
        .list-table th { 
            background-color: #f9f9f9; 
            padding: 12px 8px; 
            border-bottom: 1px solid #ddd; 
            color: #555; 
            font-weight: bold;
            font-size: 13px;
        }
        
        .list-table td { 
            padding: 12px 8px; 
            border-bottom: 1px solid #eee; 
            text-align: center;
            font-size: 13px;
            color: #444;
        }

        /* 카테고리 뱃지: 2px 라운드 고정 */
        .category-tag {
            font-size: 11px;
            font-weight: bold;
            color: #82cd47;
            background: #f9fff2;
            padding: 2px 6px;
            border: 1px solid #eefae0;
            border-radius: 2px;
        }

        .notice-tag {
            background: #fff0f0;
            color: #ff4757;
            border: 1px solid #ffd1d1;
        }

        /* 제목 링크 */
        .title-link {
            text-decoration: none;
            color: #222;
            font-weight: normal;
            transition: 0.1s;
        }

        .title-link:hover {
            text-decoration: underline;
            color: #82cd47;
        }

        .img-icon {
            font-size: 12px;
            color: #999;
            margin-left: 5px;
        }

        .love-count {
            color: #ff4757;
            font-weight: bold;
            font-size: 12px;
        }

        /* 5. 하단 버튼 영역 */
        .bottom-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn-main {
            padding: 8px 20px;
            border-radius: 2px;
            text-decoration: none;
            font-weight: bold;
            font-size: 13px;
            transition: 0.1s;
            display: inline-block;
            border: 1px solid #ccc;
        }

        .btn-primary { 
            background: #82cd47; 
            color: white; 
            border-color: #71bb3a;
        }
        .btn-primary:hover { 
            background: #71bb3a; 
        }

        .btn-outline { 
            background: #fff; 
            color: #666; 
        }
        .btn-outline:hover {
            background: #f4f4f4;
        }
    </style>
</head>
<body>

<div class="board-container">
    <h2>🌿 Greentable 커뮤니티</h2>

    <div class="top-nav">
        <a href="/main" class="nav-link">🏠 홈으로</a>
        <a href="/communitylistform" class="nav-link">🔄 새로고침</a>
        <a href="/communitywriteform" class="nav-link">📝 새 글 쓰기</a>
    </div>

    <div class="search-section">
        <form action="/communitylistform" method="get">
            <select name="c_category">
                <option value="">전체 카테고리</option>
                <option value="공지사항" ${param.c_category == '공지사항' ? 'selected' : ''}>📢 공지사항</option>
                <option value="자유게시판" ${param.c_category == '자유게시판' ? 'selected' : ''}>자유게시판</option>
                <option value="정보공유" ${param.c_category == '정보공유' ? 'selected' : ''}>정보공유</option>
                <option value="구매후기" ${param.c_category == '구매후기' ? 'selected' : ''}>구매후기</option>
                <option value="질문" ${param.c_category == '질문' ? 'selected' : ''}>질문</option>
            </select>
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
            <button type="submit">🔍 검색</button>
        </form>
    </div>
    
    <table class="list-table">
        <thead>
            <tr>
                <th width="70">번호</th>
                <th width="100">카테고리</th>
                <th>제목</th>
                <th width="90">좋아요</th>
                <th width="110">작성자</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="item" items="${list}">
                        <tr>
                            <td>${item.c_no}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.c_category == '공지사항'}">
                                        <span class="category-tag notice-tag">공지</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="category-tag">${item.c_category}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td align="left" style="padding-left: 20px;">
                                <a href="/communitydetail?c_no=${item.c_no}" class="title-link">
                                    <c:if test="${item.c_category == '공지사항'}"><strong>${item.c_title}</strong></c:if>
                                    <c:if test="${item.c_category != '공지사항'}">${item.c_title}</c:if>
                                </a>
                                <c:if test="${not empty item.c_img}">
                                    <span class="img-icon">🖼️</span>
                                </c:if>
                            </td>
                            <td><span class="love-count">❤️ ${item.c_love}</span></td>
                            <td><small style="color: #888;">회원 ${item.m_no}</small></td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5" style="padding: 60px; color: #999;">등록된 게시글이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <div class="bottom-actions">
        <a href="/main" class="btn-main btn-outline">🏠 홈으로</a>
        <a href="/communitywriteform" class="btn-main btn-primary">📝 새 글 쓰기</a>
    </div>
</div>

</body>
</html>