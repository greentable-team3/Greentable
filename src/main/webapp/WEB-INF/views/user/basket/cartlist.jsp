<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
</head>
<body>
	<h2>장바구니</h2>
	<c:choose>
        <c:when test="${empty list}">
            <div style="text-align: center; padding: 50px 0;">
                <p style="font-size: 1.2em; color: #666;">장바구니가 비어있습니다.</p>
                <a href="/foodlist" class="btn btn-primary">레시피 구경하러 가기</a>
            </div>
        </c:when>
		<c:otherwise>
	
		<table border="1">
		<c:forEach var="b" items="${list}">
		<c:set var="itemTotal" value="${b.i_price * b.b_count}" />
		<tr>
			<td>${b.i_name}</td>
			<td><fmt:formatNumber value="${b.i_price}" pattern="#,###"/>원</td>
			<td>${b.b_count}개</td>
			<td><fmt:formatNumber value="${itemTotal}" pattern="#,###"/>원</td>
			<td>
				<a href="/bedit?b_no=${b.b_no}">옵션수정</a>
				<a href="/bdelete?b_no=${b.b_no}">목록삭제</a>
			</td>
		</tr>
		</c:forEach>
		</table>
		<div>
		    <a href="/oinsertForm">주문하기</a>
		    <a href="/foodlist">레시피구경가기</a>
		</div>
		</c:otherwise>
	</c:choose>
</body>
</html>
