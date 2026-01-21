<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 레시피 구성 관리</title>
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
        box-shadow: -5px 5px 15px rgba(0,0,0,0.05);
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

    /* 테이블 스타일 최적화 */
    .table thead th {
        background-color: var(--gt-soft-bg);
        color: #76a336;
        border: none;
        padding: 15px;
        font-weight: 600;
    }

    .table tbody td {
        padding: 18px 15px;
        border-bottom: 1px solid #f9f9f9;
    }

    /* 음식/재료 배지 디자인 */
    .food-badge { background-color: #e8f5e9; color: #2e7d32; padding: 6px 14px; border-radius: 10px; font-weight: 600; font-size: 0.9rem; }
    .ingre-badge { background-color: #fff3e0; color: #ef6c00; padding: 6px 14px; border-radius: 10px; font-weight: 600; font-size: 0.9rem; }

    /* 버튼 스타일 */
    .btn-add {
        background-color: var(--gt-bright-green);
        color: white;
        border: none;
        padding: 10px 22px;
        border-radius: 12px;
        font-weight: 600;
        transition: 0.3s;
    }
    .btn-add:hover {
        background-color: #76a336;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(139, 195, 74, 0.3);
        color: white;
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
            <li><a href="/adminquestionManage"><i class="bi bi-headset me-2"></i> 1:1 문의 관리</a></li>
            
            <li><hr class="mx-4 opacity-25"></li>
            
            <li><a href="/alist"><i class="bi bi-people me-2"></i> 회원 관리</a></li>
            <li><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li class="active"><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin d-flex justify-content-between">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-link-45deg me-2"></i> 레시피 구성(연결) 현황
            </div>
            <div class="small fw-bold">
                <span class="text-muted me-3">환영합니다, <strong>Admin</strong>님</span>
            </div>
        </nav>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="fw-bold mb-1" style="color: #4a6d1a;">음식 - 재료 연결 목록</h2>
                    <p class="text-muted small mb-0">각 음식에 어떤 재료가 포함되는지 구성 데이터를 관리합니다.</p>
                </div>
                <button class="btn-add shadow-sm" onclick="location.href='/fiinsertForm'">
                    <i class="bi bi-plus-lg me-1"></i> 새로운 연결 등록
                </button>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-center">
                    <thead>
                        <tr>
                            <th width="120">음식번호</th>
                            <th width="200">대상 음식명</th>
                            <th width="120">재료번호</th>
                            <th width="200">연결된 재료명</th>
                            <th width="150">액션</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${list}">    
                            <tr>
                                <td><span class="text-muted fw-bold">#${dto.f_no}</span></td>
                                <td><span class="food-badge">${dto.f_name}</span></td>
                                <td><span class="text-muted fw-bold">#${dto.i_no}</span></td>
                                <td><span class="ingre-badge">${dto.i_name}</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-danger border-0 fw-bold" 
                                            onclick="if(confirm('이 레시피 연결 구성을 삭제하시겠습니까?')) location.href='/fidelete?f_no=${dto.f_no}&i_no=${dto.i_no}'">
                                        <i class="bi bi-trash3 me-1"></i> 삭제
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="5" class="py-5 text-muted">
                                    <i class="bi bi-info-circle d-block fs-2 mb-2"></i>
                                    등록된 레시피 구성 데이터가 없습니다.
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