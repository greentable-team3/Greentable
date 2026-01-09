<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 게시판 상세 목록</title>

<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

</head>
<body>

<div class="header-bar">문의 게시판 상세 목록</div>

<div class="table-container">

<table class="table table-striped table-hover" name="questionlist" method="post" action="questioninsertDao" enctype="multipart/form-data" onsubmit="return check()">
<tr>
    <th>문의게시판</th>
    <th>카테고리</th>
    <th>비밀글 여부</th>
    <th>제목</th>
    <th>내용</th>
    <th>이미지 파일명</th>
    <th>이미지</th>
    <th>회원번호</th>
</tr>

<c:forEach var="dto" items="${list}">
<tr>
    <td><a href="/questionDetail?q_no=${dto.q_no}">${dto.q_no}</a></td>
    <td>${dto.q_category}</td>
    <td>${dto.q_secret}</td>
    <td>${dto.q_title}</td>
    <td>${dto.q_content}</td>
    <td>${dto.q_img}</td>
    <td><img src="/image/${dto.q_img}" alt="문의 이미지" style="width:60px; height:auto; border-radius:5px;"></td>
    <td>${dto.m_no}</td>
    
</tr>
</c:forEach>

</table>
</div>
<a href="/questionwriteform">처음으로</a>
</body>
</html>