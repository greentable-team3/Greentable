<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
</head>
<script>
	function addBasket(btn, i_no, f_no) {
		
		// 1. 로그인 여부 확인 (서버에서 넘겨준 세션 값 활용)
	    // 아래 'sessionScope.m_no'는 사용 중인 엔진(JSP 등)의 문법에 맞춰 수정하세요.
	   const loginId = "${sessionScope.loginId}";

		// m_id에 값이 없으면(false라면) 실행
		if (!m_id) {
		    alert("로그인 후 이용 가능합니다.");
		    location.href = "/loginForm";
		    return;
		}
		
	    // 1-1. 해당 버튼이 속한 행에서 수량(b_count) 가져오기
	    const row = btn.closest('tr');
	    const b_count = row.querySelector('select[name="b_count"]').value;
	
	    // 2. 서버로 보낼 데이터 준비
	    const formData = new URLSearchParams();
	    formData.append('i_no', i_no);
	    formData.append('f_no', f_no);
	    formData.append('b_count', b_count);
	
	    // 3. Ajax 요청 (페이지 이동 없이 실행)
	    fetch('/binsertAjax', {
	        method: 'POST',
	        headers: {
	            'Content-Type': 'application/x-www-form-urlencoded',
	        },
	        body: formData
	    })
	    .then(response => {
	        if (response.ok) {
	            alert("장바구니에 담겼습니다!");
	        } else {
	            alert("장바구니 담기에 실패했습니다.");
	        }
	    })
	    .catch(error => console.error('Error:', error));
	}
	
	function addLove(f_no) {
	    $.ajax({
	        url: '/loveUpdate',
	        type: 'post',
	        data: { "f_no": f_no },
	        success: function() {
	            // 서버 업데이트 성공 시, 현재 화면의 숫자도 1 증가시킴
	            let loveNode = document.getElementById("loveCount");
	            let currentCount = parseInt(loveNode.innerText.replace(/[^0-9]/g, ""));
	            loveNode.innerText = "❤️ " + (currentCount + 1);
	            
	        },
	        error: function() {
	            alert("오류가 발생했습니다.");
	        }
	    });
	}
	
</script>
<body>
	<div style="display: flex; justify-content: center; gap: 20px;">
		<table style="table-layout: auto; width: fit-content;">
			<tr>
				<td><img src="/image/${detail.f_imgfilename}" 
     style="width: 400px !important; height: 400px !important; object-fit: cover !important; border-radius: 8px;"></td>
			</tr>
			<tr>
				<td>${detail.f_category}</td>
			</tr>
			<tr>
				<td>${detail.f_name}</td>
			</tr>
			<tr>
				<td>${detail.f_add}</td>
			</tr>
			<tr>
				<td>${detail.f_ingredient}</td>
			</tr>
			<tr>
				<td><pre>${detail.f_recipe}</pre></td>
			</tr>
			
			<tr>
				<td><img src="/image/${detail.f_kcalfilename}" width="300"></td>
			</tr>
			<tr>
				<td>
			        <span id="loveCount" style="cursor:pointer; font-size: 20px;" onclick="addLove('${detail.f_no}')">
			            ❤️ ${detail.f_love}</span> 
			    </td>
			</tr>
			<tr>
				<td>
					<a href ="/foodlist">레시피목록</a>
					<a href="/fedit?f_no=${detail.f_no}" >레시피수정</a>
					<a href="/fdelete?f_no=${detail.f_no}">레시피삭제</a>
				</td>
			</tr>
		</table>
		<div style="display: flex; justify-content: center;">
    	<table border ="1" style="height: 100px;" style="display: inline-table;">
	      <tr>
	         <td colspan="5"><h2>재료구매</h2></td>
	      </tr>
	   <c:forEach var="i" items="${ingrelist}">
	      <tr>
	         <td>${i.i_name}</td>
	         <td>${i.i_price}</td>
	         <td>${i.i_origin}</td>
	         <td colspan="2"> 
	         <form action="/binsert" method="post" style="margin:0;">
            <select name="b_count">
            	<c:forEach var="num" begin="1" end="10">
            		<option value="${num}">${num}</option>
                </c:forEach>
            </select>

            <input type="hidden" name="i_no" value="${i.i_no}">
            <input type="hidden" name="f_no" value="${param.f_no}">
	            <button type="button" onclick="addBasket(this, '${i.i_no}', '${detail.f_no}')">
                담기
            </button>

	 
        	
       	 	</form>
    		</td>
	      </tr>
	   </c:forEach>
   	</table>
	</div>
	<div style="clear: both;"></div>
	<p>&nbsp;</p><p>&nbsp;</p> 
   	<a href="/cartlist">
	<button type="button" style="padding: 10px 20px; cursor: pointer;">장바구니가기</button>
	</a>	
	</div>
</body>
</html>



