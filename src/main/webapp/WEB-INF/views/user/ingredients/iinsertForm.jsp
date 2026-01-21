<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료등록</title>
<script>
function check(){
	document.ingredients.submit();
}
</script>
</head>
<body>
	<form name="ingredients" method="post" action="/iinsert">
		<table>
			<tr>
				<td>재료명</td>
				<td><input type="text" name="i_name"></td>
			</tr>
			<tr>
				<td>재료가격</td>
				<td><input type="text" name="i_price"></td>
			</tr>
			<tr>
				<td>원산지</td>
				<td><input type="text" name="i_origin"></td>
			</tr>
			<tr>
				<td colspan="2">
                    <button type="button" onclick="check()">재료등록</button>
                    <button type="reset">등록취소</button>
                </td>
			</tr>
		</table>
	</form>
</body>
</html>