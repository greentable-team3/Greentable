<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
</head>
<body>
	<table width="500">
		<tr>
			<td><img src="/image/${detail.f_imgfilename}" width="500"></td>
		</tr>
		<tr>
			<td>${detail.f_category}</td>
		</tr>
		<tr>
			<td>${detail.f_name}</td>
		</tr>
		<tr>
			<td>${detail.f_add}</td>
		</tr>
		<tr>
			<td>${detail.f_ingredient}</td>
		</tr>
		<tr>
			<td>${detail.f_recipe}</td>
		</tr>
		<tr>
			<td><img src="/image/${detail.f_kcalfilename}" width="300"></td>
		</tr>
		<tr>
			<td>${detail.f_love} || ${detail.f_nolove}</td>
		</tr>
		<tr>
			<td>
				<a href ="/foodlist">레시피목록</a>
				<a href="/fedit?f_no=${detail.f_no}" >레시피수정</a>
				<a href="/fdelete?f_no=${detail.f_no}">레시피삭제</a>
			</td>
		</tr>
	</table>
</body>
</html>



