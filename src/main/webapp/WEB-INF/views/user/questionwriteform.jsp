<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootswatch 테마 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/minty/bootstrap.min.css">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
<script>
function check(){
    if (document.questionwriteform.q_category.value == "")
    { alert("카테고리을 선택하세요!"); 
    return false; } 
    
    let secrets = document.getElementsByName("q_secret");
    let secretChecked = false;
    for (let i = 0; i < secrets.length; i++) {
        if (secrets[i].checked) {
            secretChecked = true;
            break;
        }
    }
    if (!secretChecked) {
        alert("비밀글 여부를 선택하세요!");
        return false;
    }
    
    if (document.questionwriteform.q_title.value == "") 
    { alert("제목을 입력하세요!"); 
    return false; }
    if (document.questionwriteform.q_content.value == "") 
    { alert("내용을 입력하세요!"); 
    return false; }
    if (document.questionwriteform.qimage.files.length === 0) {
        alert("이미지를 넣으세요!");
        return false;
    }
    if (!document.questionwriteform.m_no.value) 
    { alert("회원번호을 선택하세요!");
    return false; }
    return true;
}
</script>
<title>그린테이블 프로젝트 문의 게시판 글쓰기</title>
</head>
<body>
    <h1>그린테이블 문의 게시판 글쓰기</h1>
    
    <form name="questionwriteform" method="post" action="questionwrite" 
          enctype="multipart/form-data" onsubmit="return check()">
        
        <table border="1" width=0>
        	
              <tr>
                <td>카테고리</td>
                <td>
	                <select name="q_category" required>
	                	<option value = "신고">신고</option>
	                	<option value = "문의">문의</option>
	                </select>
                </td>
            </tr>
           <tr>
           <td>비밀글 여부</td>
           <td>
           <input type="radio" name="q_secret" value="승인">승인 
           </td>
</tr>
            <tr>
                <td>제목</td>
                <td><input type="text" name="q_title"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td>
                <textarea rows="10" cols="60" name="q_content" placeholder="문의 내용을 입력하세요"></textarea>  
                </td>
            </tr>  
                     
            <tr>
                <td>이미지</td>
                <td><input type="file" name="qimage"></td>
            </tr>
            
             <tr>
                <td>회원번호</td>
                <td><input type="text" name="m_no"></td>
            </tr>
                     
        </table>
        <br>
        <input type="submit" value="문의 등록">
        <input type="reset" value="문의 초기화">
        <a href="/questionlist">문의 목록으로</a>
    </form>
</body>
</html>