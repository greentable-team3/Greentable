<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록 폼</title>
<script>
function check(){
	
	let f_name = document.food.f_name;
	let f_category = document.food.f_category;
	let f_add = document.food.f_add;
	let f_ingredient = document.food.f_ingredient;
	let f_recipe = document.food.f_recipe;
	let f_kcal = document.food.f_kcal;
	let f_img = document.food.f_img;
	
	if(!f_name.value){
		alert("음식명을 입력하세요.");
		f_name.value = "";
		f_name.focus();
		return false;
	}
	
	if(!f_category.value){
		alert("카테고리를 설정하세요.");
		f_category.value = "";
		f_category.focus();
		return false;
	}
	
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
	
	if(!f_img.value){
		alert("음식 사진를 첨부하세요.");
		f_img.value = "";
		f_img.focus();
		return false;
	}
	
	if(!f_kcal.value){
		alert("영양성분 사진을 첨부하세요.");
		f_kcal.value = "";
		f_kcal.focus();
		return false;
	}

	
	document.food.submit();
}

</script>
</head>
<body>
	<h1>레시피 등록</h1>
	<form name="food" method="post" action="/finsert" enctype="multipart/form-data">
	<table>
	<tr>
		<td>레시피명</td>
		<td><input type="text" name="f_name"></td>
	</tr>
	<tr>
		<td>카테고리</td>
		<td>
			<input type ="radio" name ="f_category" value="식사류">식사류
			<input type ="radio" name ="f_category" value="디저트류">디저트류
		</td>
	</tr>
	<tr>
		<td>메뉴소개</td>
		<td><textarea rows=2 cols=50 name= "f_add"></textarea></td>
	</tr>
	<tr>
		<td>재료</td>
		<td><textarea rows=4 cols=50 name= "f_ingredient"></textarea></td>
	</tr>
	<tr>
		<td>레시피</td>
		<td><textarea rows=7 cols=100 name= "f_recipe"></textarea></td>
	</tr>
	<tr>
		<td>이미지</td>
		<td><input type="file" name="f_img"></td>
	</tr>	
	<tr>
		<td>칼로리</td>
		<td><input type="file" name="f_kcal"></td>
	</tr>
	<tr>
		<td colspan ="2">
			<button type="button" value="레시피등록" onclick="check()">레시피등록</button>
			<button type="reset" value="작성취소" >작성취소</button>
			<button type="reset" value="등록취소" onclick="history.back()">등록취소</button>
		</td>
	</tr>	
	</table>	
	</form>
</body>
</html>