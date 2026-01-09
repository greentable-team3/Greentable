<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!-- id 옆에 '관리자'라는 글자 띄우고 회원목록에 접근할 수 있도록 security tagilb 추가 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" 
      rel="stylesheet">

</head>
<body>
<a href="/myinfo" class="btn btn-outline-success btn-sm">내 정보</a>
<header class="pb-3 mb-4 border-bottom d-flex justify-content-between align-items-center">
    <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
        <svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
            <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5z"/>
            <path d="M8 3.293l6 6V13.5A1.5 1.5 0 0 1 12.5 15h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6z"/>
        </svg>
        <span class="fs-4 ms-2">home</span>
    </a>


    <div>
        <c:choose>
            <c:when test="${not empty pageContext.request.userPrincipal}">
                <span class="me-3">${pageContext.request.userPrincipal.name} 님</span> <!-- 회원 아이디 + 님 출력 --> 
				<!-- 관리자 권한을 가지고 있다면 ~님 "| 관리자 계정" 출력-->
                <sec:authorize access="hasRole('ADMIN')"> 
                	| 관리자 계정
                	<!--관리자 계정만 회원 목록에 access 가능 -->	
				    <a href="/admin/list" class="btn btn-outline-secondary btn-sm ms-2">
				        회원 목록
				    </a>
				</sec:authorize>
                <form action="/logout" method="post" style="display:inline;">
                    <input type="submit" class="btn btn-outline-danger btn-sm" value="로그아웃">
                </form>
            </c:when>
	
            <c:otherwise>
                <a href="/login" class="btn btn-outline-primary btn-sm">로그인</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<%! 
    String greeting = "";
    String tagline = "Welcome to Web Market!";
%>


<div class="row align-items-md-stretch text-center">
    <div class="col-md-12">
        <div class="h-100 p-5">
            <h3><%= tagline %></h3>
        </div>
    </div>
</div>


<footer class="pt-3 mt-4 text-body-secondary border-top text-center">
    &copy; BookMarket
</footer>

</body>
</html>
