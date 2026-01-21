<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
    <style>
        /* 1. 전역 스타일: 화면 중앙 정렬 및 배경 */
        body {
            font-family: "Malgun Gothic", dotum, sans-serif;
            background-color: #f8f9f8;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }

        /* 2. 각진 실무형 컨테이너 */
        .check-card {
            background: #fff;
            padding: 40px;
            border-radius: 0; /* 라운드 제거 */
            border: 1px solid #ddd;
            width: 380px;
            text-align: center;
            box-shadow: none; /* 그림자 제거로 실무 느낌 강조 */
        }

        h3 {
            margin-top: 0;
            margin-bottom: 20px;
            color: #222;
            font-weight: bold;
            font-size: 24px;
            border-bottom: 2px solid #333;
            padding-bottom: 15px;
        }

        .notice {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
            text-align: left;
            background: #f9f9f9;
            padding: 15px;
            border-left: 3px solid #82cd47; /* 포인트 컬러 선 */
        }

        /* 3. 입력창 스타일: 각진 디자인 */
        .input-group {
            margin-bottom: 20px;
        }

        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 0;
            font-size: 14px;
            box-sizing: border-box;
            outline: none;
            transition: 0.1s;
        }

        input[type="password"]:focus {
            border-color: #82cd47; /* 연두색 강조 */
        }

        /* 4. 버튼 영역: 각진 디자인 및 테마 컬러 */
        .btn-area {
            display: flex;
            gap: 8px;
        }

        .btn {
            flex: 1;
            padding: 12px;
            border-radius: 2px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            border: 1px solid #ccc;
            transition: 0.1s;
            text-decoration: none;
        }

        /* 확인 버튼: 싱그러운 연두색 */
        .btn-submit {
            background: #82cd47;
            color: #fff;
            border-color: #71bb3a;
        }

        .btn-submit:hover {
            background: #71bb3a;
        }

        /* 뒤로가기 버튼: 다크 그레이 */
        .btn-back {
            background: #666;
            color: #fff;
            border-color: #555;
        }

        .btn-back:hover {
            background: #444;
        }

        /* 에러 메시지 */
        .error-msg {
            color: #ff4757;
            font-weight: bold;
            font-size: 13px;
            margin-top: 15px;
        }
    </style>
</head>
<body>

    <div class="check-card">
        <h3>비밀번호 확인</h3>
        <div class="notice">
            개인정보 보호를 위해 <strong>비밀번호</strong>를<br>
            한번 더 입력해 주시기 바랍니다.
        </div>

        <form name="passwordCheckForm" method="post" action="/passwordCheck">
            <input type="hidden" name="m_no" value="${m_no}"> 
            <input type="hidden" name="mode" value="${mode}">  
            
            <div class="input-group">
                <input type="password" name="m_passwd" placeholder="비밀번호를 입력하세요" required autofocus>
            </div>

            <div class="btn-area">
                <button type="button" class="btn btn-back" onclick="history.back();">취소</button>
                <button type="submit" class="btn btn-submit">확인</button>
            </div>
        </form>

        <c:if test="${not empty msg}">
            <p class="error-msg">⚠️ ${msg}</p>
        </c:if>
    </div>

</body>
</html>