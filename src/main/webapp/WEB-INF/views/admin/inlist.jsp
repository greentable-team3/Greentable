<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 재료 재고 관리</title>
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
        min-width: 260px; max-width: 260px; min-height: 100vh;
        background: linear-gradient(135deg, #a2d149 0%, #8bc34a 100%);
        color: white; position: fixed; z-index: 1000;
        box-shadow: 2px 0 10px rgba(0,0,0,0.05);
    }

    #sidebar .sidebar-header { padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }

    #sidebar ul li a { padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; font-weight: 500; transition: 0.3s; }

    #sidebar ul li a:hover { background: rgba(255, 255, 255, 0.1); padding-left: 40px; color: white; }

    #sidebar ul li.active > a {
        background: white; color: #76a336; font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
        box-shadow: -5px 5px 15px rgba(0,0,0,0.05);
    }

    /* 메인 컨텐츠 영역 */
    #main-content { margin-left: 260px; width: calc(100% - 260px); }

    .navbar-admin { background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1; }

    .admin-card {
        background: white; padding: 35px; border-radius: 25px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 35px; border: 1px solid #f0f3e8;
    }

    /* 테이블 스타일 */
    .table thead th {
        background-color: var(--gt-soft-bg); color: #76a336; border: none; padding: 15px; font-weight: 600;
    }
    .table tbody td { padding: 15px; border-bottom: 1px solid #f9f9f9; }

    /* 버튼 스타일 */
    .btn-gt-add {
        background-color: var(--gt-bright-green); color: white; border: none; padding: 10px 20px;
        border-radius: 12px; font-weight: 700; transition: 0.3s; text-decoration: none;
    }
    .btn-gt-add:hover { background-color: #76a336; color: white; transform: translateY(-2px); }

    .action-link { font-size: 0.85rem; font-weight: 600; text-decoration: none; padding: 5px 10px; border-radius: 8px; }
    .link-edit { color: #0088cc; background: #e3f7ff; margin-right: 5px; }
    .link-delete { color: #e53935; background: #fff0f0; }
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
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li class="active"><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin d-flex justify-content-between">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-basket2-fill me-2"></i> 식재료 마스터 관리
            </div>
            <a href="/iinsertForm" class="btn-gt-add shadow-sm">
                <i class="bi bi-plus-lg me-1"></i> 새 재료 등록
            </a>
        </nav>

        <div class="admin-card">
            <div class="mb-4">
                <h2 class="fw-bold mb-1" style="color: #4a6d1a;">전체 재료 목록</h2>
                <p class="text-muted small">등록된 모든 식재료의 단가와 원산지를 관리합니다.</p>
            </div>

            <div class="table-responsive">
                <table class="table table-hover align-middle text-center">
                    <thead>
                        <tr>
                            <th width="100">재료 번호</th>
                            <th>재료명</th>
                            <th width="150">재료 가격</th>
                            <th width="150">원산지</th>
                            <th width="200">데이터 관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${list}">	
                            <tr>
                                <td class="text-muted small">ID-${dto.i_no}</td>
                                <td class="fw-bold text-dark">${dto.i_name}</td>
                                <td>
                                    <span class="fw-bold text-success">
                                        <fmt:formatNumber value="${dto.i_price}" pattern="#,###"/>원
                                    </span>
                                </td>
                                <td><span class="badge bg-light text-dark border">${dto.i_origin}</span></td>
                                <td>
                                    <a href="/iupdateForm?i_no=${dto.i_no}" class="action-link link-edit">수정</a>
                                    <a href="/idelete?i_no=${dto.i_no}" 
                                       class="action-link link-delete" 
                                       onclick="return confirm('${dto.i_name} 재료를 삭제하시겠습니까?')">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty list}">
                            <tr>
                                <td colspan="5" class="py-5 text-muted">등록된 재료가 없습니다. 새 재료를 추가해 주세요.</td>
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