<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 글 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        .update-container {
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
            vertical-align: middle;
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
            border-radius: 0;
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

        /* 6. 이미지 관리 영역 스타일 */
        .image-preview-box {
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #eee;
            margin-bottom: 10px;
            display: inline-block;
            width: 100%;
            box-sizing: border-box;
        }

        .image-preview-box img {
            border: 1px solid #ddd;
            background: #fff;
            padding: 2px;
        }

        .file-hint {
            display: block;
            margin-top: 5px;
            color: #82cd47; /* 연두색 강조 */
            font-size: 12px;
            font-weight: bold;
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

        /* 수정완료: 싱그러운 연두색 */
        button[type="submit"] {
            background-color: #82cd47;
            border-color: #71bb3a;
            color: white;
            min-width: 120px;
        }

        button[type="submit"]:hover {
            background-color: #71bb3a;
        }

        /* 취소하기: 다크 그레이 */
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

<%-- 권한체크 로직 --%>
<c:if test="${not empty sessionScope.m_no && (dto.m_no != sessionScope.m_no && sessionScope.m_no != 1)}">
    <script>
        alert("수정 권한이 없습니다.");
        history.back();
    </script>
</c:if>

<div class="update-container">
    <h2>🌿 커뮤니티 글 수정</h2>

    <form action="/communityupdate" method="post" enctype="multipart/form-data">
        <input type="hidden" name="c_no" value="${dto.c_no}">
        
        <table>
            <tr>
                <th>카테고리</th>
                <td>
                    <select name="c_category" required>
                        <c:if test="${sessionScope.m_no == 1 || dto.c_category == '공지사항'}">
                            <option value="공지사항" ${dto.c_category == '공지사항' ? 'selected' : ''}>📢 공지사항</option>
                        </c:if>
                        <option value="자유게시판" ${dto.c_category == '자유게시판' ? 'selected' : ''}>자유게시판</option>
                        <option value="정보공유" ${dto.c_category == '정보공유' ? 'selected' : ''}>정보공유</option>
                        <option value="구매후기" ${dto.c_category == '구매후기' ? 'selected' : ''}>구매후기</option>
                        <option value="질문" ${dto.c_category == '질문' ? 'selected' : ''}>질문</option>
                    </select>
                </td>
            </tr>
            <tr>
                <th>제목</th>
                <td><input type="text" name="c_title" value="${dto.c_title}" required></td>
            </tr>
            <tr>
                <th>내용</th>
                <td><textarea name="c_content" rows="12" required>${dto.c_content}</textarea></td>
            </tr>
            <tr>
                <th>현재 이미지</th>
                <td>
                    <c:if test="${not empty dto.c_img}">
                        <div class="image-preview-box">
                            <img src="/upload/${dto.c_img}" width="150" style="display:block;">
                            <span class="file-hint" style="color:#999; font-weight:normal;">현재 등록된 파일: ${dto.c_img}</span>
                        </div>
                    </c:if>
                    <input type="file" name="file">
                    <span class="file-hint">* 이미지를 변경할 때만 파일을 선택하세요.</span>
                </td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="button" onclick="history.back()">❌ 취소하기</button>
            <button type="submit">🛠️ 수정완료</button>
        </div>
    </form>
</div>

</body>
</html>