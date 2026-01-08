<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료수정</title>
<script>
function check(){
	document.ingredients.submit();
}
</script>
</head>
<body>
	<h3>재료수정</h3>
	<form name="ingredients" method="post" action="/iupdate">
		<input type="hidden" name="i_no" value="${update.i_no}"> 
		<p> 재료명 : ${update.i_name}
		<p> 재료가격 : <input type="text" name="i_price" value="${update.i_price}">
		<p> 원산지 : <input type="text" name="i_origin" value="${update.i_origin}">
		<p> <button type="button" onclick="check()">수정완료</button>
			<button type="reset" onclick="history.back();">수정취소</button>
	</form>
</body>
</html>