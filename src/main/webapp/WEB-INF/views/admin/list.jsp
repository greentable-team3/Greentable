<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
<link href = "https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel = "stylesheet">
</head>
<body>
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
                <span class="me-3">${pageContext.request.userPrincipal.name} 님 | 관리자 계정</span>
            </c:when>
        </c:choose>
    </div>
</header>
	<h3 class = "text-center">회원정보</h3>
	<form action = "/member/list" method = "post" name = "list">
		<input type="hidden" name="m_authority" value="${m_authority}">
		<table border = "1" width = "1000" class = "table mx-auto d-block table text-center">
			<tr>
				<td>번호</td>
				<td>아이디</td>		
				<td>이름</td>		
				<td>배송주소</td>		
				<td>전화번호</td>		
				<td>이메일</td>
				<td>가입일</td>
				<td></td>		
			</tr>
			<c:forEach var="m" items="${member}">
				<tr>
					<td>${m.m_no}</td>
					<td>${m.m_id}</td>
	        		<td>${m.m_name}</td>
		        	<td>${m.m_addr}</td>
	       			<td>${m.m_tel}</td>
	        		<td>${m.m_email}</td>
	        		<td>${m.m_date}</td>
	        		<td><a href="/adminCheckForm?m_no=${m.m_no}&mode=delete">회원정보삭제</a>|<a href="/adminCheckForm?m_no=${m.m_no}&mode=update">회원정보수정</a></td>
				</tr>
			</c:forEach>		
		</table>
	</form>
</body>
</html>