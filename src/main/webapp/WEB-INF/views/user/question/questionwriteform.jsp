<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 글쓰기</title>
<style>
    /* 1. 기본 설정 - 정보 밀도 최적화 */
    body {
        font-family: "Malgun Gothic", dotum, sans-serif;
        background-color: #f8f9f8;
        color: #333;
        margin: 0;
        padding: 40px 0;
        line-height: 1.4;
    }

    /* 2. 컨테이너: 각진 실무형 레이아웃 */
    .write-container {
        width: 700px;
        margin: 0 auto;
        background: #fff;
        padding: 30px;
        border: 1px solid #ddd;
        border-radius: 0;
    }

    /* 3. 제목: 싱그러운 연두색 포인트 */
    h2 {
        text-align: left;
        margin-bottom: 25px;
        font-weight: bold;
        color: #222;
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

    /* 4. 입력 필드: 각진 UI 및 줄바꿈 최적화 */
    input[type="text"], select {
        width: 100%;
        padding: 8px 10px;
        border: 1px solid #ccc;
        border-radius: 0;
        box-sizing: border-box;
        font-size: 13px;
    }

    /* ⭐ 글자가 밑으로 확실히 가게 만드는 Textarea 설정 */
    textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 0;
        box-sizing: border-box;
        font-size: 14px;
        background-color: #fff;
        resize: vertical; /* 세로로만 늘릴 수 있게 설정 */
        min-height: 200px;
        
        /* 줄바꿈 핵심 속성 */
        white-space: pre-wrap; /* 공백과 줄바꿈 보존하며 영역 끝에서 자동 줄바꿈 */
        word-break: break-all; /* 영문/숫자도 영역 끝에서 강제 줄바꿈 */
        overflow-y: auto;      /* 내용 많아지면 세로 스크롤 생성 */
        line-height: 1.6;      /* 가독성 높은 행간 */
    }

    input:focus, select:focus, textarea:focus {
        border-color: #82cd47; /* 싱그러운 연두색 */
        outline: none;
    }

    /* 5. 공개설정 영역 */
    .secret-container {
        display: flex;
        gap: 5px;
    }
    .secret-box { flex: 1; }
    .secret-box input[type="radio"] { display: none; }
    .secret-card {
        display: block;
        padding: 8px;
        text-align: center;
        border: 1px solid #ddd;
        border-radius: 2px;
        cursor: pointer;
        font-size: 13px;
        font-weight: bold;
        color: #777;
    }
    .secret-box input[type="radio"]:checked + .secret-card.open {
        border-color: #82cd47; background-color: #f9fff2; color: #82cd47;
    }
    .secret-box input[type="radio"]:checked + .secret-card.private {
        border-color: #333; background-color: #f5f5f5; color: #333;
    }
    .secret-hint { font-size: 12px; color: #999; margin-top: 5px; display: block; }

    /* 6. 버튼 영역 */
    .btn-area {
        margin-top: 30px;
        display: flex;
        justify-content: flex-end;
        gap: 8px;
    }
    input[type="submit"], input[type="reset"], input[type="button"] {
        padding: 10px 25px;
        border: 1px solid #ccc;
        border-radius: 2px;
        font-weight: bold;
        cursor: pointer;
        font-size: 13px;
    }
    input[type="submit"] {
        background-color: #82cd47; border-color: #71bb3a; color: white;
    }
    input[type="submit"]:hover { background-color: #71bb3a; }
</style>
</head>
<body>

<div class="write-container">
    <h2>문의글 작성하기</h2>
    <form action="/questioninsert" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td class="label-td">카테고리</td>
                <td>
                <select name="q_category">
                        <option value="일반문의">일반문의</option>
                        <option value="배송문의">배송문의</option>
                        <option value="상품문의">상품문의</option>
                        <option value="기타문의">기타문의</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="label-td">공개설정</td>
                <td>
                    <div class="secret-container">
                        <div class="secret-box">
                            <input type="radio" name="q_secret" id="q_open" value="N" checked>
                            <label for="q_open" class="secret-card open">🔓 전체 공개</label>
                        </div>
                        <div class="secret-box">
                            <input type="radio" name="q_secret" id="q_private" value="Y">
                            <label for="q_private" class="secret-card private">🔒 비밀글</label>
                        </div>
                    </div>
                    <span class="secret-hint">* 비밀글은 작성자와 관리자만 볼 수 있습니다.</span>
                </td>
            </tr>
            <tr>
                <td class="label-td">제목</td>
                <td>
                    <input type="text" name="q_title" maxlength="50" placeholder="제목을 입력하세요" required>
                </td>
            </tr>
            <tr>
                <td class="label-td">내용</td>
                <td>
                    <textarea name="q_content" placeholder="상세한 문의 내용을 입력해 주세요. 글자가 영역 끝에 닿으면 자동으로 줄바꿈됩니다." required></textarea>
                </td>
            </tr>
            <tr>
                <td class="label-td">파일첨부</td>
                <td>
                    <input type="file" name="file" accept="image/*">
                </td>
            </tr>
        </table>

        <div class="btn-area">
            <input type="button" value="취소" onclick="location.href='/questionlistform'">
            <input type="reset" value="초기화">
            <input type="submit" value="문의 등록하기">
        </div>
    </form>
</div>

</body>
</html>