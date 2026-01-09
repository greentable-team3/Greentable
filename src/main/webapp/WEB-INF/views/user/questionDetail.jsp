<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 문의 게시판 상세 목록</title>

<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- CSS링크  -->
<link rel="stylesheet" href="">

</head>
<body>

<div class="header-bar">회원 문의 게시판 상세 데이터 수정/삭제</div>

<div class="table-container">
<table class="table table-striped table-hover" name="questionDetail" method="post" action="questionDetail" enctype="multipart/form-data" onsubmit="return check()">
<tr>
    <th>문의게시판 번호</th>
    <th>회원번호</th>
    <th>카테고리</th>
    <th>비밀글</th>
    <th>제목</th>
    <th>내용</th> 
    <th>이미지</th>   
    <th>수정/삭제</th>
</tr>


<tr>
    <td>${dto.q_no}</td>
    <td>${dto.m_no}</td>
    <td>${dto.q_category}</td>
    <td>${dto.q_secret}</td>
    <td>${dto.q_title}</td>
    <td>${dto.q_content}</td>

    <td><img src="/image/${dto.q_img}" alt="회원작성 이미지" style="width:60px; height:auto; border-radius:5px;"></td>
    <td>

        <a href="questionUpdateform?q_no=${dto.q_no}" class="btn-action">수정</a>
        <a href="questionDelete?q_no=${dto.q_no}" class="btn-action">삭제</a>
    </td>
</tr>

</table>
</div>
<a href="/questionlist">목록으로</a>
</body>
</html>
