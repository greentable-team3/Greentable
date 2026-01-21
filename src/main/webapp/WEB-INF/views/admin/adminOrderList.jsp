<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 배송 관리 시스템</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    :root {
        --gt-bright-green: #8bc34a;
        --gt-soft-bg: #f8fbef;
        --gt-active-white: #ffffff;
        --gt-text-main: #2c3e50;
    }
    
    body {
        background-color: #fcfdfc;
        margin: 0;
        font-family: 'Malgun Gothic', sans-serif;
        color: var(--gt-text-main);
    }

    /* 사이드바 스타일 통일 */
    #sidebar {
        min-width: 260px;
        max-width: 260px;
        min-height: 100vh;
        background: linear-gradient(135deg, #a2d149 0%, #8bc34a 100%);
        color: white;
        position: fixed;
        box-shadow: 2px 0 10px rgba(0,0,0,0.05);
        z-index: 1000;
    }

    #sidebar .sidebar-header {
        padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2);
    }

    #sidebar ul li a {
        padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; font-weight: 500; transition: 0.3s;
    }

    #sidebar ul li a:hover {
        background: rgba(255, 255, 255, 0.1); padding-left: 40px; color: white;
    }

    #sidebar ul li.active > a {
        background: var(--gt-active-white); color: #76a336; font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
        box-shadow: -5px 5px 15px rgba(0,0,0,0.05);
    }

    /* 메인 영역 */
    #main-content {
        margin-left: 260px;
        width: calc(100% - 260px);
    }

    .navbar-admin {
        background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1;
    }

    .admin-card {
        background: white; padding: 35px; border-radius: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 35px; border: 1px solid #f0f3e8;
    }

    /* 테이블 스타일 최적화 */
    .table thead th {
        background-color: var(--gt-soft-bg); color: #76a336; border: none; padding: 15px; font-weight: 600;
    }

    .table tbody td {
        padding: 18px 15px; border-bottom: 1px solid #f9f9f9;
    }

    /* 상태 배지 디자인 */
    .status-badge {
        padding: 6px 15px; border-radius: 30px; font-size: 0.82rem; font-weight: bold;
    }
    
    .status-pay-done { background-color: #e3f7ff; color: #0088cc; }
    .status-shipping { background-color: #fff9e6; color: #d9a300; }
    .status-return { background-color: #fff0f0; color: #e53935; }
    .status-default { background-color: #f5f5f5; color: #888; }

    .btn-action {
        border-radius: 10px; padding: 6px 16px; font-weight: 600; font-size: 0.85rem; transition: 0.2s;
    }
    .btn-action:hover { transform: scale(1.05); }
</style>
</head>
<body>

<div class="d-flex">
    <nav id="sidebar">
        <div class="sidebar-header">
            <h3 class="fw-bold mb-0"><i class="bi bi-flower1"></i> GREEN</h3>
            <span class="small" style="opacity: 0.8;">Admin Management</span>
        </div>

        <ul class="list-unstyled mt-4">
            <li><a href="/main"><i class="bi bi-house me-2"></i> 쇼핑몰 홈</a></li>
            
            <li class="active"><a href="/admin/olist"><i class="bi bi-box-seam me-2"></i> 주문 배송 관리</a></li>
            
            <li><a href="/admincommunityList"><i class="bi bi-chat-left-dots me-2"></i> 커뮤니티 관리</a></li>
            
            <li><a href="/adminquestionManage"><i class="bi bi-headset me-2"></i> 1:1 문의 관리</a></li>
            
            <li><hr class="mx-4 opacity-25"></li>
            
            <li><a href="/alist"><i class="bi bi-people me-2"></i> 회원 관리</a></li>
            <li><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin d-flex justify-content-between">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-box-seam-fill me-2"></i> 배송 및 주문 현황
            </div>
            <div class="small fw-bold">
                <span class="text-muted me-3">현재 접속자: <strong>Admin</strong></span>
                <a href="/myinfo" class="btn btn-sm btn-outline-success border-0"><i class="bi bi-person-circle"></i> 정보수정</a>
            </div>
        </nav>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-1" style="color: #4a6d1a;">주문 배송 내역</h2>
                    <p class="text-muted small mb-0">접수된 모든 주문의 상태를 관리하고 실시간으로 배송 처리를 진행합니다.</p>
                </div>
                <button class="btn btn-sm btn-success shadow-sm" style="background-color: var(--gt-bright-green); border:none; padding: 8px 15px;" onclick="location.reload()">
                    <i class="bi bi-arrow-clockwise me-1"></i> 데이터 새로고침
                </button>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="text-center">
                        <tr>
                            <th width="100">주문번호</th>
                            <th width="150">주문일시</th>
                            <th width="120">수령인</th>
                            <th width="120">결제금액</th>
                            <th width="130">현재상태</th>
                            <th width="180">상태변경 처리</th>
                            <th width="100">조회</th>
                        </tr>
                    </thead>
                    <tbody class="text-center">
                        <c:forEach var="dto" items="${list}">
                            <tr>
                                <td><span class="fw-bold" style="color: #76a336;">#${dto.o_no}</span></td>
                                <td><small class="text-muted fw-bold">${dto.o_delivery_date != null ? dto.o_delivery_date : "-"}</small></td>
                                <td><strong>${dto.o_name}</strong></td>
                                <td class="fw-bold text-dark">
                                    <fmt:formatNumber value="${dto.o_total}" pattern="#,###"/>원
                                </td>
                                <td>
                                    <span class="status-badge 
                                        <c:choose>
                                            <c:when test="${dto.o_status == '결제완료'}">status-pay-done</c:when>
                                            <c:when test="${dto.o_status == '배송중'}">status-shipping</c:when>
                                            <c:when test="${dto.o_status == '반품접수' || dto.o_status == '교환접수'}">status-return</c:when>
                                            <c:otherwise>status-default</c:otherwise>
                                        </c:choose>">
                                        ${dto.o_status}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${dto.o_status == '결제완료'}">
                                            <button class="btn btn-success btn-action border-0" style="background-color: var(--gt-bright-green);"
                                                    onclick="if(confirm('배송을 시작하시겠습니까?')) location.href='/updateStatus?o_no=${dto.o_no}&status=배송중'">배송시작</button>
                                        </c:when>
                                        <c:when test="${dto.o_status == '배송중'}">
                                            <button class="btn btn-outline-success btn-action fw-bold"
                                                    onclick="if(confirm('배송완료 처리를 하시겠습니까?')) location.href='/updateStatus?o_no=${dto.o_no}&status=배송완료'">완료처리</button>
                                        </c:when>
                                        <c:when test="${dto.o_status == '반품접수'}">
                                            <button class="btn btn-danger btn-action border-0" onclick="if(confirm('반품을 승인하시겠습니까?')) location.href='/admin/approveRequest?o_no=${dto.o_no}&type=반품'">반품승인</button>
                                        </c:when>
                                        <c:when test="${dto.o_status == '교환접수'}">
                                            <button class="btn btn-warning btn-action text-white border-0" onclick="if(confirm('교환을 승인하시겠습니까?')) location.href='/admin/approveRequest?o_no=${dto.o_no}&type=교환'">교환승인</button>
                                        </c:when>
                                        <c:otherwise><span class="text-muted small">처리불가</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/odetail?o_no=${dto.o_no}" class="btn btn-sm btn-light border text-muted px-3 fw-bold rounded-pill">
                                        <i class="bi bi-search"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty list}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox fs-1 text-muted opacity-50"></i>
                    <p class="mt-3 text-muted fw-bold">현재 처리할 주문 내역이 없습니다.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>

</body>
</html>