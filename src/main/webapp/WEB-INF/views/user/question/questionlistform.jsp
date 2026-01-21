<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 목록</title>
<style>
    /* 1. 전역 스타일: 실무 커머스 고밀도 레이아웃 */
    body { 
        font-family: "Malgun Gothic", dotum, sans-serif; 
        background-color: #f8f9f8; 
        padding: 40px 0; 
        color: #333;
        margin: 0;
    }
    
    .board-container { 
        width: 1000px; 
        margin: 0 auto; 
        background: #fff; 
        padding: 30px; 
        border: 1px solid #ddd;
        border-radius: 0; /* 라운드 제거 */
    }

    /* 2. 제목: 깔끔한 강조선 스타일 */
    h2 { 
        text-align: left; 
        margin-bottom: 25px; 
        color: #222; 
        font-weight: bold; 
        font-size: 24px;
        border-bottom: 2px solid #333;
        padding-bottom: 15px;
    }
    
    /* 3. 검색 영역: 우측 정렬 및 촘촘한 배치 */
    .search-area { 
        margin-bottom: 20px; 
        display: flex; 
        justify-content: flex-end; 
    }
    
    .search-area select, .search-area input[type="text"] { 
        padding: 6px 10px; 
        border: 1px solid #ccc; 
        border-radius: 0; 
        margin-left: 5px; 
        font-size: 13px;
        background-color: #fff;
    }

    .search-area input[type="text"]:focus {
        border-color: #82cd47; /* 연두색 포커스 */
        outline: none;
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

    /* 5. 뱃지 및 아이콘 스타일: 실무형 2px 라운드 */
    .status-badge {
        display: inline-block;
        padding: 2px 8px;
        border-radius: 2px;
        font-size: 11px;
        font-weight: bold;
    }
    /* 공개: 연두색 */
    .status-open { background-color: #f9fff2; color: #82cd47; border: 1px solid #eefae0; }
    /* 비밀글: 그레이 */
    .status-private { background-color: #f5f5f5; color: #777; border: 1px solid #ddd; }
    
    .category-badge { 
        color: #888; 
        font-size: 12px; 
        font-weight: normal;
    }

    .title-link { 
        text-decoration: none; 
        color: #222; 
        font-weight: normal; 
        transition: 0.1s;
    }
    
    .title-link:hover { text-decoration: underline; color: #82cd47; }
    
    .secret-text { color: #999; font-size: 13px; }
    .locked-icon { color: #999; margin-right: 3px; font-size: 12px; }
    .img-icon { margin-left: 5px; opacity: 0.6; font-size: 12px; }
    
    /* 6. 하단 버튼 그룹: 실무형 버튼 배치 */
    .button-group { 
        display: flex; 
        justify-content: space-between; 
        margin-top: 30px; 
        align-items: center;
    }

    .btn { 
        padding: 8px 18px; 
        border-radius: 2px; 
        cursor: pointer; 
        border: 1px solid #ccc; 
        font-weight: bold; 
        text-decoration: none; 
        font-size: 13px;
        transition: 0.1s;
        display: inline-block;
    }

    /* 메인 버튼: 싱그러운 연두색 */
    .btn-primary { 
        background: #82cd47; 
        color: white; 
        border-color: #71bb3a;
    }
    .btn-primary:hover { 
        background: #71bb3a; 
    }

    /* 보조 버튼: 화이트 스타일 */
    .btn-outline { 
        background: #fff; 
        color: #666; 
    }
    .btn-outline:hover { 
        background: #f4f4f4; 
    }

    /* 관리자 전용 */
    .btn-admin { 
        background: #666; 
        color: #fff; 
        border-color: #555;
        margin-left: 5px;
    }
</style>
</head>
<body>

<div class="board-container">
    <h2>문의 게시판</h2>
    
    <div class="search-area">
        <form action="/questionlistform" method="get">
            <select name="q_category">
                <option value="">전체 카테고리</option>
                <option value="일반문의" ${param.q_category == '일반문의' ? 'selected' : ''}>일반문의</option>
                <option value="배송문의" ${param.q_category == '배송문의' ? 'selected' : ''}>배송문의</option>
                <option value="상품문의" ${param.q_category == '상품문의' ? 'selected' : ''}>상품문의</option>
                <option value="기타문의" ${param.q_category == '기타문의' ? 'selected' : ''}>기타문의</option>
            </select>
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력하세요">
            <input type="submit" value="검색" class="btn btn-outline" style="padding: 5px 12px; vertical-align: middle;">
        </form>
    </div>

    <table class="list-table">
        <thead>
            <tr>
                <th width="70">번호</th>
                <th width="100">공개여부</th>
                <th width="120">카테고리</th>
                <th>제목</th>
                <th width="120">작성자</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="dto" items="${list}">
            <tr>
                <td>${dto.q_no}</td>
                <td>
                    <c:choose>
                        <c:when test="${dto.q_secret == 'Y'}">
                            <span class="status-badge status-private">비밀글</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-badge status-open">공개</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><span class="category-badge">${dto.q_category}</span></td>
                <td align="left" style="padding-left: 15px;">
                    <c:choose>
                      <c:when test="${dto.q_secret == 'Y'}">
            <c:choose>
            <c:when test="${sessionScope.m_no == 1 || sessionScope.m_no == dto.m_no}">
                <a href="/questiondetail?q_no=${dto.q_no}" class="title-link">
                 <span class="locked-icon">🔒</span> ${dto.q_title}
                 <c:if test="${not empty dto.q_img}"><span class="img-icon">🖼️</span></c:if>
                </a>
            </c:when>    
                
                <c:otherwise>
                    <span class="secret-text">🔒 작성자와 관리자만 볼 수 있습니다.</span>
                </c:otherwise>
            </c:choose>
        </c:when>
                        
                        <c:otherwise>
                            <a href="/questiondetail?q_no=${dto.q_no}" class="title-link">
                                ${dto.q_title}
                                <c:if test="${not empty dto.q_img}"><span class="img-icon">🖼️</span></c:if>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${dto.m_no == 0}"><strong>관리자</strong></c:when>
                        <c:otherwise>회원 ${dto.m_no}</c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </c:forEach>
            
            <c:if test="${empty list}">
                <tr>
                    <td colspan="5" style="padding: 60px; color: #999;">문의 내역이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="button-group">
        <div>
            <input type="button" value="메인으로" class="btn btn-outline" onclick="location.href='/main'">
            
<c:if test="${sessionScope.m_no == 1}">
    <input type="button" value="관리 전용" class="btn btn-admin" onclick="location.href='/adminquestionManage'">
</c:if>
        </div>
        
        <input type="button" value="문의하기" class="btn btn-primary" onclick="location.href='/questionwriteform'">
    </div>
</div>

</body>
</html>