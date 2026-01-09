<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 글 수정</title>

<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

</head>
<body>

<div class="header-bar">커뮤니티 글 수정</div>

<div class="form-container">
<form name="communityupdate" method="post" enctype="multipart/form-data" action="/communityUpdate">

    <!-- 글 번호는 hidden으로 전달 -->
    <input type="hidden" name="c_no" value="${dto.c_no}">

    <div class="mb-3">
        <label class="form-label">카테고리</label>
        <input type="text" name="c_category" class="form-control" value="${dto.c_category}">
    </div>

    <div class="mb-3">
        <label class="form-label">제목</label>
        <input type="text" name="c_title" class="form-control" value="${dto.c_title}">
    </div>

    <div class="mb-3">
        <label class="form-label">내용</label>
        <textarea name="c_content" class="form-control" rows="5">${dto.c_content}</textarea>
    </div>

    <div class="mb-3">
        <label class="form-label">현재 이미지</label><br>
        <img src="/upload/${dto.c_img}" alt="현재 이미지" style="width:120px; height:auto; border-radius:5px;">
    </div>

    <div class="mb-3">
        <label class="form-label">새 이미지 업로드</label>
        <input type="file" name="cimage" class="form-control">
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