<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문수량 수정 폼</title>
<script>
	function check(){
		
		let b_count = document.basket.b_count;
		
		let expB_count = /^[0-9]+$/;
		
		if(!b_count.value || !expB_count.test(b_count.value)){
			alert("주문 수량을 숫자로 입력해주세요.");
			b_count.value = "";
			b_count.focus();
			return false;
		}
		
		if(confirm("수정하시겠습니까?")) { // 확인 절차 추가
            document.basket.submit();
        }
		
		document.basket.submit();
	}

</script>
</head>
<body>
	<form name="basket" method="post" action="/bupdate">
	<input type="hidden" name="b_no" value="${edit.b_no}">
	<table>
		<tr>
			<td><input type="number" min="1" name="b_count" value="${edit.b_count}"></td>
			<td><button type="button" value="수정" onclick = "check()">수정</button></td>
			<td><button type="button" value="취소" onclick = "history.back()">취소</button>
		</tr>
	</table>
	</form>
</body>
</html>