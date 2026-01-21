<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 수정</title>
<style>
    /* 1. 전역 스타일: 신선하고 밝은 커머스 톤 */
    body {
        font-family: "Malgun Gothic", dotum, sans-serif;
        background-color: #f8f9f8;
        margin: 0;
        padding: 40px 0;
        color: #333;
        line-height: 1.4;
    }

    /* 2. 컨테이너: 각진 실무형 레이아웃 (그림자 제거) */
    .update-container {
        width: 700px;
        margin: 0 auto;
        background: #fff;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 0; /* 라운드 제거 */
    }

    /* 3. 제목: 깔끔한 강조선 스타일 */
    h2 {
        text-align: left;
        margin-bottom: 25px;
        color: #222;
        font-weight: bold;
        font-size: 22px;
        border-bottom: 2px solid #333;
        padding-bottom: 15px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid #333;
    }

    .label-td {
        width: 140px;
        padding: 12px 15px;
        font-weight: bold;
        color: #555;
        background-color: #f9f9f9;
        border-bottom: 1px solid #eee;
        font-size: 13px;
        vertical-align: middle;
    }

    td {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    /* 4. 입력 필드: 각진 UI (0~2px) */
    input[type="text"], select, textarea {
        width: 100%;
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 0;
        box-sizing: border-box;
        font-size: 13px;
        background-color: #fff;
    }

    input[type="text"]:focus, select:focus, textarea:focus {
        border-color: #82cd47; /* 싱그러운 연두색 포커스 */
        outline: none;
    }

    /* 5. 라디오 그룹: 촘촘한 커머스 스타일 */
    .radio-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    .radio-group label {
        cursor: pointer;
        font-size: 13px;
        font-weight: bold;
        color: #777;
        display: flex;
        align-items: center;
        gap: 5px;
        padding: 6px 12px;
        border-radius: 2px;
        background: #fff;
        border: 1px solid #ddd;
        transition: 0.1s;
    }

    /* 체크 시 연두색 강조 */
    .radio-group label:has(input[type="radio"]:checked) {
        border-color: #82cd47;
        color: #82cd47;
        background: #f9fff2;
    }

    /* 6. 이미지 영역: 정돈된 느낌 */
    .file-display {
        margin-bottom: 10px;
        padding: 10px;
        background: #f9f9f9;
        border: 1px solid #eee;
        display: block;
    }

    input[type="file"] {
        font-size: 12px;
        color: #888;
        margin-top: 5px;
    }

    /* 7. 버튼 영역: 우측 정렬 및 고정 컬러 */
    .btn-area {
        margin-top: 30px;
        display: flex;
        justify-content: flex-end;
        gap: 8px;
    }

    input[type="submit"], input[type="button"] {
        padding: 10px 25px;
        border: 1px solid #ccc;
        border-radius: 2px;
        font-weight: bold;
        cursor: pointer;
        font-size: 13px;
        transition: 0.1s;
    }

    /* 수정완료: 싱그러운 연두색 */
    input[type="submit"] {
        background-color: #82cd47;
        border-color: #71bb3a;
        color: white;
        min-width: 120px;
    }

    input[type="submit"]:hover { 
        background-color: #71bb3a; 
    }

    /* 취소 버튼: 다크 그레이 */
    input[type="button"] {
        background-color: #666;
        color: white;
        border-color: #555;
    }

    input[type="button"]:hover {
        background-color: #444;
    }

    small {
        color: #82cd47; /* 안내 문구도 포인트 컬러 적용 */
        font-weight: bold;
    }
</style>
</head>
<body>

    <div class="update-container">
        <h2>문의글 수정하기</h2>
        
        <form action="/questionupdate" method="post" enctype="multipart/form-data">
            <input type="hidden" name="q_no" value="${dto.q_no}">
            
            <table>
                <tr>
                    <td class="label-td">카테고리</td>
                    <td>
                        <select name="q_category">
                            <option value="일반문의" ${dto.q_category == '일반문의' ? 'selected' : ''}>일반문의</option>
                            <option value="배송문의" ${dto.q_category == '배송문의' ? 'selected' : ''}>배송문의</option>
                            <option value="상품문의" ${dto.q_category == '상품문의' ? 'selected' : ''}>상품문의</option>
                            <option value="기타문의" ${dto.q_category == '기타문의' ? 'selected' : ''}>기타문의</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-td">공개여부</td>
                    <td>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="q_secret" value="N" ${dto.q_secret == 'N' ? 'checked' : ''}> 공개
                            </label>
                            <label>
                                <input type="radio" name="q_secret" value="Y" ${dto.q_secret == 'Y' ? 'checked' : ''}> 🔒 비밀글
                            </label>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="label-td">제목</td>
                    <td>
                        <input type="text" name="q_title" value="${dto.q_title}" required maxlength="50">
                    </td>
                </tr>
                <tr>
                    <td class="label-td">내용</td>
                    <td>
                        <textarea name="q_content" rows="10" required maxlength="1500">${dto.q_content}</textarea>
                    </td>
                </tr>
                <tr>
                <td class="label-td">현재 이미지</td>
                <td>
                    <c:if test="${not empty dto.q_img}">
                        <div class="file-display">
                            <img src="/upload/${dto.q_img}" width="120" style="border: 1px solid #ddd; background:#fff; padding:2px;">
                            <p style="font-size:11px; color:#999; margin: 5px 0 0 0;">파일명: ${dto.q_img}</p>
                        </div>
                    </c:if>
                    <input type="file" name="file" accept="image/*">
                    <small style="display:block; margin-top:5px;">* 이미지를 변경할 때만 파일을 선택하세요.</small>
                </td>
            </tr>
            </table>

            <div class="btn-area">
                <input type="submit" value="수정완료">
                <input type="button" value="취소" onclick="location.href='/questiondetail?q_no=${dto.q_no}'">
            </div>
        </form>
    </div>

</body>
</html>