<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 수정 전 확인 폼</title>
<script>
function check(){
	
	let f_add = document.food.f_add;
	let f_ingredient = document.food.f_ingredient;
	let f_recipe = document.food.f_recipe;

	
	
	if(!f_add.value){
		alert("메뉴 소개를 입력하세요.");
		f_add.value = "";
		f_add.focus();
		return false;
	}
	
	if(!f_ingredient.value){
		alert("재료를 입력하세요.");
		f_ingredient.value = "";
		f_ingredient.focus();
		return false;
	}
	
	if(!f_recipe.value){
		alert("레시피를 입력하세요.");
		f_recipe.value = "";
		f_recipe.focus();
		return false;
	}

	
	document.food.submit();
}

</script>
</head>
<body>
	<h1>레시피 수정</h1>
	<form name=food method="post" action="/fupdate">
		<input type="hidden" name="f_no" value="${edit.f_no}">
		음식 번호 : ${edit.f_no} <br>
		레시피명 : ${edit.f_name} <br>
		메뉴소개 : <textarea name="f_add" rows=2 cols=50>${edit.f_add}</textarea><br>
		재료 : <textarea name="f_ingredient" rows=4 cols=50>${edit.f_ingredient}</textarea><br>
		레시피 : <textarea name="f_recipe" rows=7 cols=100>${edit.f_recipe}</textarea><br>
		<button type="button" value="레시피수정" onclick="check()" >레시피수정</button>
		<button type="reset" value="다시작성" >다시작성</button>
	</form>
</body>
</html>