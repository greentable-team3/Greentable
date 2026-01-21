<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 회원 관리 시스템</title>
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
    .table tbody td { padding: 15px; border-bottom: 1px solid #f9f9f9; vertical-align: middle; }

    /* 관리 버튼 스타일 */
    .action-btn { font-size: 0.8rem; font-weight: 600; text-decoration: none; padding: 6px 12px; border-radius: 8px; transition: 0.2s; }
    .btn-edit { color: #0088cc; background: #e3f7ff; margin-right: 5px; }
    .btn-delete { color: #e53935; background: #fff0f0; }
    .action-btn:hover { opacity: 0.8; transform: translateY(-1px); }
    
    .member-no { font-family: 'Courier New', monospace; color: #888; font-size: 0.9rem; }
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
            <li class="active"><a href="/alist"><i class="bi bi-people me-2"></i> 회원 관리</a></li>
            <li><a href="/foodlist"><i class="bi bi-card-list me-2"></i> 음식(레시피) 관리</a></li>
            <li><a href="/filist"><i class="bi bi-link-45deg me-2"></i> 음식-재료 연결 관리</a></li>
            <li><a href="/inlist"><i class="bi bi-basket me-2"></i> 재료 재고 관리</a></li>
            <li class="mt-5"><a href="/logout" style="opacity: 0.7;"><i class="bi bi-power me-2"></i> 로그아웃</a></li>
        </ul>
    </nav>

    <div id="main-content">
        <nav class="navbar navbar-admin d-flex justify-content-between">
            <div class="fw-bold fs-5 text-success">
                <i class="bi bi-people-fill me-2"></i> 회원 계정 관리자 센터
            </div>
            <div class="small fw-bold text-muted">
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <i class="bi bi-person-badge me-1"></i> ${pageContext.request.userPrincipal.name} (Admin)
                </c:if>
            </div>
        </nav>

        <div class="admin-card">
            <div class="mb-4">
                <h2 class="fw-bold mb-1" style="color: #4a6d1a;">전체 회원 목록</h2>
                <p class="text-muted small">그린테이블에 가입된 회원들의 정보를 조회하고 관리할 수 있습니다.</p>
            </div>

            <div class="table-responsive">
                <table class="table table-hover text-center">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일 / 전화번호</th>
                            <th>배송 주소</th>
                            <th>가입일</th>
                            <th>관리 액션</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="m" items="${member}">
                            <tr>
                                <td><span class="member-no">#${m.m_no}</span></td>
                                <td class="fw-bold text-dark">${m.m_id}</td>
                                <td><span class="badge bg-light text-success border border-success-subtle px-3">${m.m_name}</span></td>
                                <td class="text-start small">
                                    <div><i class="bi bi-envelope me-1"></i> ${m.m_email}</div>
                                    <div><i class="bi bi-telephone me-1"></i> ${m.m_tel}</div>
                                </td>
                                <td class="text-start small text-muted">${m.m_addr}</td>
                                <td>
                                    <span class="text-muted" style="font-size: 0.85rem;">
                                        <fmt:formatDate value="${m.m_date}" pattern="yyyy-MM-dd" />
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex justify-content-center">
                                        <a href="/adminCheckForm?m_no=${m.m_no}&mode=update" class="action-btn btn-edit">수정</a>
                                        <a href="/adminCheckForm?m_no=${m.m_no}&mode=delete" 
                                           class="action-btn btn-delete"
                                           onclick="return confirm('${m.m_id} 회원을 강제 탈퇴 처리하시겠습니까?')">삭제</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty member}">
                            <tr>
                                <td colspan="7" class="py-5 text-muted">등록된 회원이 없습니다.</td>
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