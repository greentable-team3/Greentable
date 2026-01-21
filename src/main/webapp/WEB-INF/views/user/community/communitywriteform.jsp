<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 글쓰기</title>
    <style>
        /* 1. 전역 스타일: 실무 커머스 고밀도 레이아웃 */
        body {
            font-family: "Malgun Gothic", dotum, sans-serif;
            background-color: #f8f9f8;
            margin: 0;
            padding: 40px 0;
            color: #333;
            line-height: 1.4;
        }

        /* 2. 컨테이너: 각진 실무형 레이아웃 (그림자 제거, 선 강조) */
        .write-container {
            width: 750px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 0; /* 라운드 제거 */
        }

        /* 3. 제목: 싱그러운 연두색 포인트 및 강조선 */
        h2 {
            text-align: left;
            margin-bottom: 25px;
            font-weight: bold;
            color: #222;
            font-size: 22px;
            border-bottom: 2px solid #333;
            padding-bottom: 15px;
        }

        /* 4. 테이블 디자인: 촘촘한 정보 밀도 */
        table {
            width: 100%;
            border-collapse: collapse;
            border-top: 1px solid #333;
        }

        th {
            width: 130px;
            padding: 12px 15px;
            font-weight: bold;
            color: #555;
            text-align: left;
            font-size: 13px;
            background-color: #f9f9f9;
            border-bottom: 1px solid #eee;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        /* 5. 입력 필드: 각진 UI (0~2px) */
        input[type="text"], select, textarea {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 0; /* 라운드 제거 */
            box-sizing: border-box;
            font-size: 13px;
            background-color: #fff;
            font-family: inherit;
        }

        input[type="text"]:focus, select:focus, textarea:focus {
            border-color: #82cd47; /* 싱그러운 연두색 포커스 */
            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 300px;
        }

        /* 공지사항 옵션 강조 */
        option[value="공지사항"] {
            color: #ff4757 !important;
            font-weight: bold;
        }

        /* 6. 파일 첨부 스타일링 */
        input[type="file"] {
            font-size: 12px;
            color: #888;
        }

        /* 7. 버튼 영역: 우측 정렬 및 고정 컬러 */
        .btn-area {
            margin-top: 30px;
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        button {
            padding: 10px 20px;
            border: 1px solid #ccc;
            border-radius: 2px; /* 고정된 각진 모서리 */
            font-weight: bold;
            cursor: pointer;
            transition: 0.1s;
            font-size: 13px;
            font-family: inherit;
        }

        /* 등록하기: 싱그러운 연두색 */
        button[type="submit"] {
            background-color: #82cd47;
            border-color: #71bb3a;
            color: white;
            min-width: 120px;
        }

        button[type="submit"]:hover {
            background-color: #71bb3a;
        }

        /* 다시작성: 화이트 */
        button[type="reset"] {
            background-color: #fff;
            color: #666;
        }

        /* 목록으로: 다크 그레이 */
        button[type="button"] {
            background-color: #666;
            color: white;
            border-color: #555;
        }

        button:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

<div class="write-container">
    <h2>🌿 커뮤니티 새 글 쓰기</h2>
    
    <form action="/communitywrite" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <th>카테고리</th>
                <td>
                    <select name="c_category" required>
                        <c:if test="${sessionScope.m_no == 1}">
                            <option value="공지사항">📢 공지사항 (관리자 전용)</option>
                        </c:if>
                        <option value="자유게시판">자유게시판</option>
                        <option value="정보공유">정보공유</option>
                        <option value="구매후기">구매후기</option>
                        <option value="질문">질문</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="c_title" required placeholder="제목을 입력하세요"></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="c_content" rows="12" required placeholder="내용을 입력해주세요."></textarea></td>
            </tr>
            <tr>
                <th>이미지 첨부</th>
                <td><input type="file" name="file"></td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="button" onclick="location.href='/communitylistform'">📋 목록으로</button>
            <button type="reset">🔄 다시작성</button>
            <button type="submit">✅ 등록하기</button>
        </div>
    </form>
</div>

</body>
</html>