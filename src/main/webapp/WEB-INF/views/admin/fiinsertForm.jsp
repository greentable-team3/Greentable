<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식_재료등록</title>
<script>
function check(){
	document.food_ingredients.submit();
}
</script>
</head>
<body>
	<h1>음식-재료 연결 등록</h1>
	<form name="food_ingredients" method="post" action="/fiinsert">
		<table>
			<tr>
				<td>음식선택</td>
				<td><select name="f_no">
                        <c:forEach var="f" items="${foodList}">
                            <option value="${f.f_no}">${f.f_name}</option>
                        </c:forEach>
                    </select>
                </td>
			</tr>
			<tr>
				<td>재료선택</td>
				<td><select name="i_no">
                        <c:forEach var="i" items="${ingreList}">
                            <option value="${i.i_no}">${i.i_name}</option>
                        </c:forEach>
                    </select>
                </td>
			</tr>
			<tr>
				<td colspan="2">
                    <button type="button" onclick="check()">등록</button>
                    <button type="reset">등록취소</button>
                </td>
			</tr>
		</table>
	</form>
</body>
</html>