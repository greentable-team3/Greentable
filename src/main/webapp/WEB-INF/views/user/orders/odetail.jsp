<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<%@ taglib prefix = "fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>주문 상세 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; padding: 40px 0; }
        
        .detail-container { max-width: 850px; margin: 0 auto; padding: 0 20px; }
        .detail-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        
        .section-title { font-size: 18px; font-weight: 800; color: #198754; margin: 35px 0 15px; display: flex; align-items: center; gap: 8px; }
        .section-title:first-of-type { margin-top: 0; }
        .section-title i { font-size: 20px; }

        /* 테이블 스타일 커스텀 */
        .info-table { width: 100%; border-top: 2px solid #333; margin-bottom: 20px; }
        .info-table th { background-color: #f9f9f9; width: 150px; padding: 12px 15px; font-size: 14px; color: #555; border-bottom: 1px solid #eee; }
        .info-table td { padding: 12px 15px; font-size: 14px; color: #333; border-bottom: 1px solid #eee; }

        /* 상품 목록 테이블 */
        .item-list-table { width: 100%; border-top: 2px solid #198754; text-align: center; }
        .item-list-table th { background: #f1f8e9; padding: 12px; font-size: 13px; color: #198754; font-weight: 700; border-bottom: 1px solid #e1eedb; }
        .item-list-table td { padding: 15px 12px; font-size: 14px; border-bottom: 1px solid #eee; }
        .item-list-table tfoot td { background: #fcfdfc; font-weight: 700; padding: 15px; }

        /* 상태 박스 */
        .status-banner { background-color: #f1f8e9; border: 1px solid #82cd47; border-radius: 8px; padding: 20px; margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        .status-main { font-size: 18px; font-weight: 800; color: #198754; }
        .delivery-info { font-size: 14px; color: #555; }

        /* 버튼 */
        .btn-green { background-color: #198754; color: white; border: none; font-weight: 700; }
        .btn-green:hover { background-color: #146c43; color: white; }
        .btn-outline-custom { background: #fff; border: 1px solid #ddd; color: #666; font-weight: 600; }
        .btn-copy { padding: 2px 8px; font-size: 11px; vertical-align: middle; margin-left: 5px; }

        /* 관리자 전용 섹션 */
        .admin-section { background-color: #fff5f5; border: 1px solid #feb2b2; border-radius: 10px; padding: 25px; margin-top: 40px; }
        .admin-title { color: #c53030; font-weight: 800; font-size: 16px; margin-bottom: 15px; display: flex; align-items: center; gap: 8px; }
        .admin-img { max-width: 100%; height: auto; border-radius: 6px; border: 1px solid #feb2b2; margin-top: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        
        .back-link { display: block; text-align: center; margin-top: 40px; color: #888; text-decoration: none; font-weight: 600; font-size: 14px; transition: 0.2s; }
        .back-link:hover { color: #198754; }
    </style>
    
    <script>
        function copyNo() {
            var text = document.getElementById("deliveryNo").innerText;
            navigator.clipboard.writeText(text).then(function() {
                alert("송장 번호가 클립보드에 복사되었습니다.");
            });
        }
    </script>
</head>
<body>

<div class="detail-container">
    <div class="detail-card">
        <h2 class="text-center fw-bold mb-4">주문 상세 내역</h2>

        <div class="status-banner">
            <div>
                <span class="text-muted small">주문 상태</span>
                <div class="status-main">${master.o_status}</div>
            </div>
            <div class="text-end delivery-info">
                <c:choose>
                    <c:when test="${master.o_status == '배송중' || master.o_status == '배송완료'}">
                        송장번호: <span id="deliveryNo" class="fw-bold text-dark">${master.o_delivery_no}</span>
                        <button type="button" class="btn btn-sm btn-light border btn-copy" onclick="copyNo()">복사</button>
                        <div class="mt-1 small text-success fw-bold">
                            <a href="https://www.cjlogistics.com/ko/tool/parcel/tracking" target="_blank" class="text-decoration-none">CJ대한통운 조회하기 &rsaquo;</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <span class="text-muted small">상품 준비 및 처리가 진행중입니다.</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="section-title"><i class="bi bi-person-check"></i> 수령인 정보</div>
        <table class="info-table">
            <tr><th>주문번호</th><td>${master.o_no}</td></tr>
            <tr><th>수령인</th><td>${master.o_name}</td></tr>
            <tr><th>연락처</th><td>${master.o_tel}</td></tr>
            <tr><th>배송지</th><td>${master.o_addr}</td></tr>
            <tr><th>요청사항</th><td>${master.o_detail}</td></tr>
        </table>

        <div class="section-title"><i class="bi bi-box-seam"></i> 주문 상품 정보</div>
        <table class="item-list-table">
            <thead>
                <tr>
                    <th>상품명</th>
                    <th width="120">가격</th>
                    <th width="80">수량</th>
                    <th width="150">합계</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${details}">
                    <tr>
                        <td class="text-start fw-bold text-dark">${item.i_name}</td>
                        <td><fmt:formatNumber value="${item.i_price}" pattern="#,###"/>원</td>
                        <td>${item.b_count}개</td>
                        <td class="fw-bold"><fmt:formatNumber value="${item.i_price * item.b_count}" pattern="#,###"/>원</td>
                    </tr>
                </c:forEach>
            </tbody>
            <tfoot>
                <tr>
                    <td colspan="3" class="text-end text-muted small">배송비</td>
                    <td class="text-dark small"><fmt:formatNumber value="${master.o_fee}" pattern="#,###"/>원</td>
                </tr>
                <tr>
                    <td colspan="3" class="text-end align-middle">최종 결제 금액</td>
                    <td class="text-danger fs-5 fw-bolder"><fmt:formatNumber value="${master.o_total}" pattern="#,###"/>원</td>
                </tr>
            </tfoot>
        </table>

        <c:if test="${sessionScope.m_no != 1 && master.o_status == '배송완료'}">
            <div class="mt-4 p-3 bg-light rounded-3 text-center border">
                <p class="small text-muted mb-3">상품을 받으셨나요? 만족하셨다면 구매확정을 눌러주세요.</p>
                <div class="d-flex gap-2 justify-content-center">
                    <button class="btn btn-green px-4 py-2" onclick="if(confirm('구매 확정하시겠습니까?')) location.href='/changeStatus?o_no=${master.o_no}&status=구매확정'">구매확정</button>
                    <button class="btn btn-outline-custom px-4 py-2" onclick="location.href='/orderRequestForm?o_no=${master.o_no}&type=반품'">반품신청</button>
                    <button class="btn btn-outline-custom px-4 py-2" onclick="location.href='/orderRequestForm?o_no=${master.o_no}&type=교환'">교환신청</button>
                </div>
            </div>
        </c:if>

        <c:if test="${sessionScope.m_no == 1 && not empty requestInfo}">
            <div class="admin-section">
                <div class="admin-title">
                    <i class="bi bi-shield-lock-fill"></i> [관리자] ${requestInfo.r_type} 신청 정보
                </div>
                <table class="table table-sm table-borderless mb-0">
                    <tr>
                        <th class="text-muted" width="100">요청사유</th>
                        <td class="fw-bold text-dark">${requestInfo.r_reason}</td>
                    </tr>
                    <tr>
                        <th class="text-muted">첨부사진</th>
                        <td>
                            <c:choose>
                                <c:when test="${not empty requestInfo.r_img}">
                                    <img src="/upload/${requestInfo.r_img}" alt="첨부사진" class="admin-img"/>
                                </c:when>
                                <c:otherwise><span class="text-muted small italic">첨부사진 없음</span></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>

                <div class="mt-4">
                    <c:choose>
                        <c:when test="${master.o_status == '반품접수' || master.o_status == '교환접수'}">
                            <button class="btn btn-danger w-100 py-3 fw-bold shadow-sm" 
                                    onclick="if(confirm('${requestInfo.r_type} 처리를 최종 승인하시겠습니까?')) location.href='/admin/approveRequest?o_no=${master.o_no}&type=${requestInfo.r_type}'">
                                <i class="bi bi-check-lg"></i> ${requestInfo.r_type} 승인 및 완료 처리
                            </button>
                        </c:when>
                        <c:otherwise>
                            <div class="bg-white border rounded p-3 text-center text-muted fw-bold">
                                <i class="bi bi-info-circle me-1"></i> 해당 요청은 이미 승인/완료되었습니다. (${master.o_status})
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${sessionScope.m_no == 1}">
                <a href="/admin/olist" class="back-link"><i class="bi bi-arrow-left"></i> 관리자 주문 목록으로 돌아가기</a>
            </c:when>
            <c:otherwise>
                <a href="/olist" class="back-link"><i class="bi bi-arrow-left"></i> 내 주문 목록으로 돌아가기</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>