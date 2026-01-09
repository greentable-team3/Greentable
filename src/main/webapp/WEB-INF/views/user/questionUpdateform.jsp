<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 글 수정</title>

<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

</head>
<body>

<div class="header-bar">문의 게시판 글 수정</div>

<div class="form-container">
<form name="questionUpdateform" method="post" enctype="multipart/form-data" action="/questionUpdate">

    <!-- 글 번호는 hidden으로 전달 -->
    <input type="hidden" name="q_no" value="${dto.q_no}">

    <div class="mb-3">
        <label class="form-label">카테고리</label>
        <input type="text" name="q_category" class="form-control" value="${dto.q_category}">
    </div>
    
    <div class="mb-3">
        <label class="form-label">비밀글</label>
        <input type="text" name="q_secret" class="form-control" value="${dto.q_secret}">
    </div>


    <div class="mb-3">
        <label class="form-label">제목</label>
        <input type="text" name="q_title" class="form-control" value="${dto.q_title}">
    </div>

    <div class="mb-3">
        <label class="form-label">내용</label>
        <textarea name="q_content" class="form-control" rows="5">${dto.q_content}</textarea>
    </div>

    <div class="mb-3">
        <label class="form-label">현재 이미지</label><br>
        <img src="/upload/${dto.q_img}" alt="현재 이미지" style="width:120px; height:auto; border-radius:5px;">
    </div>

    <div class="mb-3">
        <label class="form-label">새 이미지 업로드</label>
        <input type="file" name="qimage" class="form-control">
    </div>

    <div class="mb-3">
        <label class="form-label">회원 번호</label>
        <input type="text" name="m_no" class="form-control" value="${dto.m_no}" readonly>
    </div>

    <button type="submit" class="btn btn-primary">수정하기</button>
    <a href="communitylist" class="btn btn-secondary">목록으로</a>
</form>
</div>

</body>
</html>