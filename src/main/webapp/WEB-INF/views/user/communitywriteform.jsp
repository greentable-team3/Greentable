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
    if (document.communitywriteform.c_category.value == "")
    { alert("카테고리를 입력하세요!"); 
    return false; }
    if (document.communitywriteform.m_no.value == "") 
    { alert("회원 번호을 입력하세요!"); 
    return false; }
    if (document.communitywriteform.c_title.value == "") 
    { alert("제목을 입력하세요!"); 
    return false; }
  
    if (document.communitywriteform.c_comment.value == "") 
    { alert("작성자를 입력하세요!"); 
    return false; }
    if (document.communitywriteform.c_content.value == "") 
    { alert("내용을 입력하세요!"); 
    return false; }
    if (document.communitywriteform.cimage.value == "") 
    { alert("첨부파일을 넣어주세요!");
    return false; }
    return true;
}
</script>

<title>그린테이블 프로젝트 커뮤니티 게시판 글쓰기</title>
</head>
<body>
    <h1>그린테이블 커뮤니티 게시판 글쓰기</h1>
    
    <form name="communitywriteform" method="post" action="/communitywrite" 
          enctype="multipart/form-data" onsubmit="return check()">
        
        <table border="1" width=0>
        	
            <tr>
                <td>카테고리</td>
                <td>
	                <select name="c_category" required>
	                	<option value = "질문">질문</option>
	                	<option value = "자유">자유</option>
	                </select>
                </td>
            </tr>
             <tr>
                <td>회원번호</td>
                <td><input type="text" name="m_no"></td>
            </tr>
            <tr>
                <td>제목</td>
                <td><input type="text" name="c_title"></td>
            </tr>
            <tr>
                <td>작성자</td>
                <td><input type="text" name="c_comment"></td>
            </tr>
            <tr>
                <td>내용</td>
                <td>
                <textarea rows="10" cols="60" name="c_content" placeholder="내용을 입력하세요"></textarea>  
                </td>
            </tr>
            
            <tr>
                <td>첨부파일</td>
                <td><input type="file" name="cimage"></td>
            </tr>
            
             <tr>
             <td>좋아요</td>
                  <td>
                  <select name="c_love" required>
                        <option value = "0">0</option>
	                	<option value = "1">1</option>
	                	<option value = "2">2</option>
	              </select>
	              </td>
            </tr>
        </table>
        <br>
        <input type="submit" value="글 등록">
        <input type="reset" value="초기화">
        <a href="/communitylist">목록으로</a>
    </form>
</body>
</html>