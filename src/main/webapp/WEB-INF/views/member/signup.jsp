<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
	<!-- daum 주소 검색 api를 활용하기 위한 스크립트 -->
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src ="/js/member.js"></script>
	<form action = "write" method = "post" name = "signup" id = "signup" enctype="multipart/form-data" onsubmit="return check();">
	<input type="hidden" name="m_tel">
	<input type="hidden" name="m_addr" id="m_addr_hidden">
		<fieldset>
			<legend>회원가입</legend>
				<table>
					<tr>
						<td>아이디</td>
						<td><input type = "text" name = "m_id" id = "m_id"></td>			
					</tr>
					<tr>
						<!-- 중복 검사 버튼을 누르면 "checkId()" 함수를 실행하고 js 파일에서  -->
						<td><input type="button" onclick="checkId();" value = "중복검사"></td>
						<td><span id="idMsg"></span></td> <!-- js 파일에서 받은 msg 문구를 출력 -->
					</tr>
					<tr>
						<td>비밀번호</td>
						<td><input type = "password" name = "m_passwd"></td>
					</tr>
					<tr>
						<td>비밀번호 확인</td>
						<!-- 비밀번호 확인란에 값을 입력하면 member.js파일에 있는 "checkpasswd()"함수가 실행되고 js파일에서 비밀번호 일치 여부를 판별함 						 -->
						<td><input type="password" name = "m_passwd2" oninput = "checkpasswd();"></td>
					</tr>
					<tr>
						<!-- js파일에서 비밀 번호 일치인지 불일치인지에 대한 메시지를 가져와서 출력 -->
						<td colspan = 2><span id="pwMsg"></span></td>
					</tr>
					</div>
					<tr>
						<td>이름</td>
						<td><input type = "text" name = "m_name"></td>
					</tr>
					<tr>
						<td>닉네임</td>
						<td><input type = "text" name = "m_nickname"></td>
					</tr>
					<tr>
						<td>배송주소</td>
						<td>
							<!-- 배송 주소 입력란은 우편 번호, 도로명 주소, 상세 주소로 나누어짐, 'read only'로 사용자가 검색해서 입력한 데이터는 직접 수정 불가능 -->
							<input type="text" id="postcode" placeholder="우편번호" readonly>
							<!-- 주소 검색 버튼 클릭 시 member.js파일에 있는 "execDaumPostcode()" 함수를 실행 -->
						    <input type="button" value="주소 검색" onclick="execDaumPostcode()"><br>						
						    <input type="text" id="roadAddress" placeholder="도로명 주소" readonly><br>
						    <input type="text" id="detailAddress" placeholder="상세 주소">
						</td>
					</tr>
					<tr>
						<td>전화번호</td>
						<td>
							<select name = "m_tel1">
								<option value = "010">010</option>
								<option value = "011">011</option>
								<option value = "016">016</option>
							</select>
							-<input type = "text" name = "m_tel2" size = "4" maxlength = "4">
							-<input type = "text" name = "m_tel3" size = "4" maxlength = "4">
						</td>
					</tr>				
					<tr>
						<td>생년 월일</td>
						<td><input type = "date" name = "m_bir"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type = "text" name = "m_email"></td>
					</tr>
					<tr>
						<td>프로필 이미지</td>
						<td><input type = "file" name = "m_image_file"></td>
					</tr>
				</table>
		</fieldset>				
		<input type = "submit" value = "가입하기">
		<input type = "reset" value = "다시작성">
		<input type="button" value="뒤로 가기" onclick = "location.href='/'"><br>
		관리자 인증 키 <input type = "password" name = "adminCode" placeholder = "관리자만 입력하세요">
		<c:if test="${not empty msg}">
			<p style = "color:red;font-weight:bold">${msg}</p>
		</c:if>	
	</form>
</body>
</html>