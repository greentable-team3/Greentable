<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식_재료목록</title>
</head>
<body>
    <h1>음식_재료목록</h1>
    <table border="1" width="500"> <tr>
            <td>음식번호</td>
            <td>음식명</td>
            <td>재료번호</td>
            <td>재료명</td>
            <td></td>
        </tr>
    <c:forEach var="dto" items="${list}">    
        <tr>
            <td>${dto.f_no}</td>
            <td>${dto.f_name}</td>
            <td>${dto.i_no}</td>
            <td>${dto.i_name}</td>
            <td><a href="/fidelete?f_no=${dto.f_no}&i_no=${dto.i_no}">삭제</a></td>
        </tr>
    </c:forEach>
    </table>
    <br>
    <a href="/fiinsertForm">음식_재료등록</a>
</body>
</html>