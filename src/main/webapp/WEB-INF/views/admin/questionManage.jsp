<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 문의 답변 관리</title>
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
    }

    #sidebar .sidebar-header {
        padding: 35px 20px;
        text-align: center;
        border-bottom: 1px solid rgba(255,255,255,0.2);
    }

    #sidebar ul li a {
        padding: 16px 30px;
        display: block;
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s;
    }

    #sidebar ul li a:hover {
        background: rgba(255, 255, 255, 0.1);
        padding-left: 40px;
        color: white;
    }

    #sidebar ul li.active > a {
        background: var(--gt-active-white);
        color: #76a336;
        font-weight: 700;
        border-radius: 50px 0 0 50px;
        margin-left: 20px;
    }

    /* 메인 영역 */
    #main-content {
        margin-left: 260px;
        width: calc(100% - 260px);
    }

    .navbar-admin {
        background: white;
        padding: 20px 40px;
        border-bottom: 1px solid #f1f1f1;
    }

    .admin-card {
        background: white;
        padding: 35px;
        border-radius: 25px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 35px;
        border: 1px solid #f0f3e8;
    }

    /* 테이블 & 뱃지 스타일 */
    .table thead th {
        background-color: var(--gt-soft-bg);
        color: #76a336;
        border: none;
        padding: 15px;
    }

    .badge-wait { background-color: #fff4e5; color: #ff9800; border: 1px solid #ffe0b2; padding: 6px 12px; border-radius: 8px; }
    .badge-done { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; padding: 6px 12px; border-radius: 8px; }
    
    .answer-preview {
        max-width: 200px;
        display: inline-block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        font-size: 0.85rem;
        color: #888;
    }
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
            <li><a href="/admin/olist"><i class="bi bi-box-seam me-2"></i> 주문 배송 관리</a></li>
            <li><a href="/admincommunityList"><i class="bi bi-chat-left-dots me-2"></i> 커뮤니티 관리</a></li>
            <li class="active"><a href="/adminquestionManage"><i class="bi bi-headset me-2"></i> 1:1 문의 관리</a></li>
            
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
                <i class="bi bi-headset me-2"></i> 고객 지원 센터 관리
            </div>
            <div class="small fw-bold">
                <span class="text-muted">관리자 전용 페이지</span>
            </div>
        </nav>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-1" style="color: #4a6d1a;">1:1 문의 통합 관리</h2>
                    <p class="text-muted small mb-0">고객의 목소리에 신속하게 답변해 주세요.</p>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-center">
                    <thead>
                        <tr>
                            <th width="70">No.</th>
                            <th width="100">분류</th>
                            <th width="250">문의 제목</th>
                            <th width="100">작성자</th>
                            <th width="200">답변 상태</th>
                            <th width="150">처리 현황</th>
                            <th width="200">액션</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${questionlist}">
                        <tr>
                            <td class="text-muted">#${q.q_no}</td>
                            <td><span class="badge bg-light text-dark border">${q.q_category}</span></td>
                            <td class="text-start">
                                <a href="/questiondetail?q_no=${q.q_no}" class="text-decoration-none fw-bold text-dark">
                                    <c:if test="${q.q_secret == 'Y'}"><i class="bi bi-lock-fill text-warning me-1"></i></c:if>
                                    ${q.q_title}
                                </a>
                            </td>
                            <td><span class="badge bg-white text-success border">ID: ${q.m_no}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty q.q_answer}">
                                        <span class="answer-preview" title="${q.q_answer}">${q.q_answer}</span>
                                    </c:when>
                                    <c:otherwise><span class="text-muted small">미등록</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty q.q_answer}">
                                        <span class="badge badge-wait">답변 대기</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-done">처리 완료</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="/questiondetail?q_no=${q.q_no}" class="btn btn-sm btn-outline-success me-1">상세/답변</a>
                                <button class="btn btn-sm btn-outline-danger" 
                                   onclick="if(confirm('원글과 답변을 모두 삭제하시겠습니까?')) location.href='/adminquestionDelete?q_no=${q.q_no}'">삭제</button>
                            </td>
                        </tr>
                        </c:forEach>
                        
                        <c:if test="${empty questionlist}">
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox d-block fs-2 mb-2"></i>
                                    관리할 문의 내역이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>