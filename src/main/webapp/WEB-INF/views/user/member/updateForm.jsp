<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="telArr" value="${fn:split(update.m_tel, '-')}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
</head>
<body>
<!-- daum 주소 검색 api를 활용하기 위한 스크립트 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src = "/js/updateForm.js"></script>
	<header class="pb-3 mb-4 border-bottom d-flex justify-content-between align-items-center">
	    <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
	        <svg width="32" height="32" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
	            <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5z"/>
	            <path d="M8 3.293l6 6V13.5A1.5 1.5 0 0 1 12.5 15h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6z"/>
	        </svg>
	        <span class="fs-4 ms-2">home</span>
	    </a>
	
	
	    <div>
	        <c:choose>
	            <c:when test="${not empty pageContext.request.userPrincipal}">
	                <span class="me-3">${pageContext.request.userPrincipal.name} 님</span>
	                <sec:authorize access="hasRole('ROLE_ADMIN')">| 관리자 계정
				    <a href="/admin/list" class="btn btn-outline-secondary btn-sm ms-2">
				        회원 목록
				    </a>
				    </sec:authorize>
	                <form action="/logout" method="post" style="display:inline;">
	                    <input type="submit" class="btn btn-outline-danger btn-sm" value="로그아웃">
	                </form>
	            </c:when>
	
	            <c:otherwise>
	                <a href="/login" class="btn btn-outline-primary btn-sm">로그인</a>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</header>

    <form action="update" method="post" name = "update" enctype="multipart/form-data">
        <fieldset>
            <legend>회원 정보 수정</legend>
            <input type="hidden" name="m_no" value="${update.m_no}">
            <input type="hidden" name="m_authority" value="${update.m_authority}">
            <input type="hidden" name="m_image" value="${update.m_image}">
            <table>
                <tr>
                    <td>아이디</td>
                    <td>${update.m_id}</td>
                </tr>
				<tr>
					<td>비밀번호</td>
					<td><input type = "password" name = "m_passwd"></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password" name = "m_passwd2" oninput = "checkpasswd();"></td>
				</tr>
				<tr>
					<td colspan = 2><span id="pwMsg"></span></td>
				</tr>				
                <tr>
                    <td>이름</td>
                    <td><input type="text" name="m_name" value="${update.m_name}"></td>
                </tr>
                <tr>
                    <td>닉네임</td>
                    <td><input type="text" name="m_nickname" value="${update.m_nickname}"></td>
                </tr>
                <tr>
					<td>배송주소</td>
					<td>
						<input type="text" id="postcode" placeholder="우편번호" readonly>
					    <input type="button" value="주소 검색" onclick="execDaumPostcode()"><br>		
						<input type="text" id="roadAddress" name="m_addr" placeholder="도로명 주소" readonly><br>
						<input type="text" id="detailAddress" placeholder="상세 주소">
					</td>
				</tr>
				<tr>
                    <td>생년 월일</td>
                    <td><input type="date" name="m_bir" value="${update.m_bir}"></td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td><input type="text" name="m_email" value="${update.m_email}"></td>
                </tr>
				<tr>
					<td>전화번호</td>
					<td>
						<select name = "m_tel1">
							<option value="010" ${telArr[0] == '010' ? 'selected' : ''}>010</option>
						    <option value="011" ${telArr[0] == '011' ? 'selected' : ''}>011</option>
						    <option value="016" ${telArr[0] == '016' ? 'selected' : ''}>016</option>
						</select>
						-<input type="text" name="m_tel2" size="4" maxlength="4" value="${telArr[1]}">
						-<input type="text" name="m_tel3" size="4" maxlength="4" value="${telArr[2]}">
					</td>
				</tr>
				<tr>
	            	<td>프로필 사진</td>
	            	<td>새 파일 : <input type="file" name="m_image_file" class="form-control"> <br>기존파일 : ${update.m_image}</td>
	            </tr>
            </table>
        </fieldset>
        <input type="submit" value="수정하기">
        <input type="reset" value="다시 작성">
        <input type="button" value="뒤로 가기" onclick = "location.href='/myinfo'">
    </form>
</body>
</html>