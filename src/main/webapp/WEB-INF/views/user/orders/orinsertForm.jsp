<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>주문/결제 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/member.js"></script>
    
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; padding: 50px 0; }
        .order-container { max-width: 650px; margin: 0 auto; padding: 0 20px; }
        .order-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .section-title { font-size: 20px; font-weight: 800; color: #198754; margin-bottom: 25px; border-bottom: 2px solid #198754; padding-bottom: 10px; }
        .form-label { font-weight: 700; font-size: 13px; color: #555; margin-bottom: 8px; display: block; }
        .form-label .required { color: #ff4757; margin-left: 3px; }
        .form-control { padding: 12px; border-radius: 8px; font-size: 14px; border: 1px solid #ddd; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); }
        
        /* 결제 수단 선택 */
        .pay-method-group { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-top: 10px; }
        .pay-method-item { position: relative; }
        .pay-method-item input[type="radio"] { position: absolute; opacity: 0; width: 0; height: 0; }
        .pay-method-label { 
            display: block; padding: 15px 5px; text-align: center; border: 1px solid #ddd; 
            border-radius: 8px; cursor: pointer; font-size: 13px; font-weight: 600; transition: 0.2s; background: #fff;
        }
        .pay-method-item input[type="radio"]:checked + .pay-method-label { 
            border-color: #198754; background-color: #f1f8e9; color: #198754; 
        }

        .total-price-box { background: #fcfdfc; padding: 20px; border-radius: 10px; border: 1px solid #eefae0; margin-top: 30px; }
        .total-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px; }
        .total-row.final { border-top: 1px solid #eefae0; margin-top: 10px; padding-top: 10px; }

        .btn-pay { width: 100%; padding: 16px; font-size: 18px; font-weight: 800; border-radius: 10px; background-color: #198754; border: none; color: white; margin-top: 20px; }
        .btn-pay:hover { background-color: #146c43; }
        .btn-cancel { width: 100%; background: none; border: none; color: #888; text-decoration: underline; font-size: 13px; margin-top: 15px; }
        /* 배송지 */
        .address-group input { margin-bottom: 10px; }
        .btn-outline-custom { 
		    background: #fff; 
		    border: 1px solid #ddd; 
		    color: #666; 
		    font-weight: 600; 
		    font-size: 13px; 
		    
		    /* 높이를 입력창과 똑같이 맞추기 위한 설정 */
		    display: flex;
		    align-items: center;
		    padding: 0 20px; 
		    height: 46px; /* .form-control의 padding 12px + 폰트 높이를 계산한 값 */
		    margin-left: -1px; /* 입력창 테두리와 겹쳐서 깔끔하게 보이게 함 */
		    border-radius: 0 8px 8px 0; /* 오른쪽만 둥글게 */
		    transition: 0.2s; 
		}
		
		.btn-outline-custom:hover { 
		    background: #f8f9fa; 
		    border-color: #ccc; 
		}
        
    </style>

    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script>
    function requestPay() {
        var f = document.orders; // HTML의 <form name="orders"> 를 가리킴

        // 1. 유효성 검사
        if(f.o_name.value.trim() == "") { alert("수령인을 입력해주세요."); f.o_name.focus(); return; }
        if(f.o_tel.value.trim() == "") { alert("연락처를 입력해주세요."); f.o_tel.focus(); return; }
        if(f.o_detail.value.trim() == "") { alert("배송 요청사항을 입력해주세요."); f.o_detail.focus(); return; }

        // 2. 주소 합치기 (중요!)
        let roadAddr = document.getElementById("roadAddress").value;
        let detailAddr = document.getElementById("detailAddress").value;
        
        if(roadAddr.trim() == "") { alert("주소를 검색해주세요."); return; }
        
        // 합친 주소를 o_addr 필드에 저장 (이 필드는 form 안에 hidden으로 추가해야 함)
        f.o_addr.value = roadAddr + " " + detailAddr;

        // 3. 결제 수단 및 PG 설정
        var pay_method = f.pay_selection.value; 
        var pg_provider = "";
        if(pay_method === "kakaopay") { pg_provider = "kakaopay.TC0ONETIME"; } 
        else if(pay_method === "tosspay") { pg_provider = "tosspay.tosstest"; } 
        else if(pay_method === "payco") { pg_provider = "payco.PARTNERTEST"; }

        // 4. 아임포트 결제 실행
        var IMP = window.IMP; 
        IMP.init("imp10368661"); 

        IMP.request_pay({
            pg: pg_provider,
            pay_method: "card",
            merchant_uid: "ORD-" + new Date().getTime(),
            name: "그린테이블 상품 주문",
            amount: ${sumprice + fee},
            buyer_name: f.o_name.value,
            buyer_tel: f.o_tel.value,
            buyer_addr: f.o_addr.value // 여기서 위에서 합친 값이 전달됨
        }, function (rsp) {
            if (rsp.success) {
                alert("결제가 완료되었습니다.");
                
                // 결제 수단 및 TID 추가
                var payMethodInput = document.createElement("input");
                payMethodInput.type = "hidden"; payMethodInput.name = "o_pay_method";
                payMethodInput.value = pay_method; 
                f.appendChild(payMethodInput);

                var tidInput = document.createElement("input");
                tidInput.type = "hidden"; tidInput.name = "o_pay_tid";
                tidInput.value = rsp.imp_uid; 
                f.appendChild(tidInput);

                f.submit(); // 최종 폼 제출
            } else {
                alert("결제에 실패하였습니다. 사유: " + rsp.error_msg);
            }
        });
    }
    </script>
</head>
<body>

<div class="order-container">
    <div class="order-card shadow-sm">
        <form name="orders" method="post" action="/oinsert">
        	<input type="hidden" name="o_addr" value="">
            <c:forEach items="${b_no_list}" var="id">
                <input type="hidden" name="b_no_list" value="${id}">
            </c:forEach>
            <div class="section-title">
                <i class="bi bi-truck me-2"></i>배송 정보
            </div>

            <div class="mb-3">
                <label class="form-label">수령인 <span class="required">*</span></label>
                <input type="text" name="o_name" class="form-control" placeholder="성함을 입력하세요">
            </div>
            
            <div class="mb-3">
                <label class="form-label">연락처 <span class="required">*</span></label>
                <input type="text" name="o_tel" class="form-control" placeholder="010-0000-0000">
            </div>

            <div class="mb-4 address-group">
                <label class="form-label">배송지 주소 <span class="required">*</span></label>
                <div class="input-group mb-2">
                    <input type="text" id="postcode" class="form-control rounded-end-0" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-outline-custom" onclick="execDaumPostcode()">주소 검색</button>
                </div>
                <input type="text" id="roadAddress" class="form-control mb-2" placeholder="도로명 주소" readonly>
                <input type="text" id="detailAddress" class="form-control" placeholder="상세 주소를 입력해주세요">
            </div>

            <div class="mb-4">
                <label class="form-label">배송 요청사항 <span class="required">*</span></label>
                <input type="text" name="o_detail" class="form-control" placeholder="예: 문 앞에 놓아주세요">
            </div>

            <div class="section-title mt-5">
                <i class="bi bi-credit-card me-2"></i>결제 수단
            </div>

            <div class="pay-method-group">
                <div class="pay-method-item">
                    <input type="radio" name="pay_selection" id="pay_kakao" value="kakaopay" checked>
                    <label for="pay_kakao" class="pay-method-label">카카오페이</label>
                </div>
                <div class="pay-method-item">
                    <input type="radio" name="pay_selection" id="pay_toss" value="tosspay">
                    <label for="pay_toss" class="pay-method-label">토스페이</label>
                </div>
                <div class="pay-method-item">
                    <input type="radio" name="pay_selection" id="pay_payco" value="payco">
                    <label for="pay_payco" class="pay-method-label">페이코</label>
                </div>
            </div>

            <div class="total-price-box">
                <div class="total-row">
                    <span class="text-muted">주문 금액</span>
                    <span>${sumprice}원</span>
                </div>
                <div class="total-row">
                    <span class="text-muted">배송비</span>
                    <span>+ ${fee}원</span>
                </div>
                <div class="total-row final">
                    <span class="fw-bold">최종 결제 금액</span>
                    <span class="fs-4 fw-bolder text-success">${sumprice + fee}원</span>
                </div>
            </div>

            <button type="button" class="btn-pay shadow" onclick="requestPay()">
                ${sumprice + fee}원 결제하기
            </button>
            
            <button type="button" class="btn-cancel" onclick="history.back();">
                주문 취소하고 돌아가기
            </button>
        </form>
    </div>
</div>

</body>
</html>