<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" 
      rel="stylesheet">

<!-- '내 정보' 버튼 스타일 시트 -->
<style>
.container-box {
    max-width: 600px;
    margin: 40px auto;
}
</style>

</head>
<body>

<div class="container-box">

    <h2 class="mb-4 text-center">내 정보</h2>

    <table class="table table-bordered">
        <tr>
            <th>프로필 이미지</th>
            <td>
                <c:choose>
                    <%-- 이미지가 있을 때 --%>
                    <c:when test="${not empty member.m_image}">
                        <img src="/images/${member.m_image}" width="200" class="rounded-circle">
                    </c:when>
            
                    <%-- 이미지가 없을 때 (기본 이미지 출력) --%>
                    <c:otherwise>
                        <img src="/images/default_profile.png" width="200" class="rounded-circle">
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th>회원번호</th>
            <td>${member.m_no}</td>
        </tr>
        <tr>
            <th>아이디</th>
            <td>${member.m_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${member.m_name}</td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>${member.m_tel}</td>
        </tr>
    </table>

    <div class="d-flex justify-content-center gap-3 mt-4">

        <a href="/passwordCheckForm?m_no=${m_no}&mode=update" 
           class="btn btn-primary">
            회원 정보 수정
        </a>

        <a href="/passwordCheckForm?m_no=${m_no}&mode=delete" 
           class="btn btn-danger">
            회원 탈퇴
        </a>

    </div>

    <div class="text-center mt-4">
        <a href="/" class="btn btn-secondary btn-sm">홈</a>
    </div>

</div>

</body>
</html>
