<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 상세보기</title>
<script>
function sendCart() {
    let cartList = [];
    
    $(".ingre-check:checked").each(function() {
        let i_no = $(this).val();
        let qty = $("#qty_" + i_no).val();
        let price = $(this).data("price");
        
        cartList.push({
            f_no: ${food.f_no},
            i_no: i_no,
            i_name: $(this).data("name"),
            i_price: price,
            a_count: qty,
            a_sumprice: price * qty,
            m_no: 1 // 테스트용 회원번호
        });
    });

    if(cartList.length == 0) return alert("재료를 선택하세요.");

    $.ajax({
        url: "/addToCart",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(cartList),
        success: function(res) {
            if(res == "success") alert("장바구니에 추가되었습니다!");
        }
    });
}
</script>
</head>
<body>
	<table width="1000" border="1" style="table-layout: auto; width: fit-content;">
		<tr>
			<td><img src="/image/${detail.f_imgfilename}" width="400"></td>
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
			<td>${detail.f_love} || ${detail.f_nolove}</td>
		</tr>
		<tr>
			<td>
				<a href ="/foodlist">레시피목록</a>
				<a href="/fedit?f_no=${detail.f_no}" >레시피수정</a>
				<a href="/fdelete?f_no=${detail.f_no}">레시피삭제</a>
			</td>
		</tr>
	</table>
	<table>
      <tr>
         <td rowspan="3"><h2>재료구매</h2></td>
      </tr>
   <c:forEach var="i" items="${ingrelist}">
      <tr>
         <td>${i.i_name}</td>
         <td>${i.i_price}</td>
         <td>${i.i_origin}</td>
         <td>셀렉트 박스 만들기</td>
      </tr>
   </c:forEach>
   </table>
	
</body>
</html>



