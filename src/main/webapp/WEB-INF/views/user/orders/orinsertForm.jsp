<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문등록</title>
<script>
function check(){
	document.orders.submit();
}
</script>
</head>
<body>
	<form name="orders" method="post" action="/oinsert">
    	<c:forEach items="${b_no_list}" var="id">
        <input type="hidden" name="b_no_list" value="${id}">
    	</c:forEach>
    	<h3>배송 정보 입력</h3>
		<table>
			<tr>
				<td>수신인</td>
				<td><input type="text" name="o_name"></td>
			</tr>
			
			<tr>
				<td>수신 전화번호</td>
				<td><input type="text" name="o_tel"></td>
			</tr>
			<tr>
				<td>배송지</td>
				<td><input type="text" name="o_addr"></td>
			</tr>
			<tr>
				<td>요청사항</td>
				<td><input type="text" name="o_detail"></td>
			</tr>
			<tr>
				<td colspan="2">
                    <button type="button" onclick="check()">주문완료</button>
                    <button type="reset">주문취소</button>
                </td>
			</tr>
		</table>
	</form>
</body>
</html>