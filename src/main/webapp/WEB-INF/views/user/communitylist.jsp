<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 게시판 상세 목록</title>

<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- CSS링크  -->
<link rel="stylesheet" href="">

</head>
<body>

<div class="header-bar">회원 커뮤니티 게시판 상세 목록</div>

<div class="table-container">
<table class="table table-striped table-hover" name="communitylist" method="post" action="communityinsertDao" enctype="multipart/form-data" onsubmit="return check()">
<tr>
    
    <th>커뮤니티 번호</th>
    <th>회원번호</th>
    <th>카테고리</th>
    <th>제목</th>
    <th>내용</th>
    <th>좋아요 수</th>
    <th>커뮤니티 글</th>
    <th>이미지 파일이름</th>  
    <th>이미지</th>
  
</tr>

<c:forEach var="dto" items="${list}">
<tr>
    <td><a href="/communityDetail?c_no=${dto.c_no}">${dto.c_no}</a></td>
    <td>${dto.m_no}</td>
    <td>${dto.c_category}</td>
    <td>${dto.c_title}</td>
    <td>${dto.c_content}</td>
    <td>${dto.c_love}</td>
    <td>${dto.c_comment}</td>
    <td>${dto.c_img}</td>
    <td><img src="/image/${dto.c_img}" alt="회원작성 이미지" style="width:60px; height:auto; border-radius:5px;"></td>
</tr>
</c:forEach>

</table>
</div>
<a href="/communitywriteform">처음으로</a>
</body>
</html>
