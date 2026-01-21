<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린테이블 | 커뮤니티 관리</title>
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
        padding: 30px;
        border-radius: 25px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        margin: 25px;
        border: 1px solid #f0f3e8;
    }

    /* 테이블 스타일 */
    .table thead th {
        background-color: var(--gt-soft-bg);
        color: #76a336;
        border: none;
        padding: 15px;
        font-weight: 600;
    }

    .category-badge {
        padding: 4px 10px;
        border-radius: 8px;
        background-color: #e8f5e9;
        color: #2e7d32;
        font-size: 0.85rem;
        font-weight: 600;
    }

    .btn-edit { color: #0088cc; text-decoration: none; font-weight: bold; font-size: 0.9rem; }
    .btn-delete { color: #e53935; text-decoration: none; font-weight: bold; font-size: 0.9rem; }
    .btn-edit:hover, .btn-delete:hover { text-decoration: underline; }
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
            
            <li class="active"><a href="/admincommunityList"><i class="bi bi-chat-left-dots me-2"></i> 커뮤니티 관리</a></li>
            
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
                <i class="bi bi-shield-check me-2"></i> 커뮤니티 모니터링 시스템
            </div>
            <div class="small fw-bold">
                <span class="text-muted me-3">관리자 모드</span>
                <button class="btn btn-sm btn-outline-success border-0" onclick="location.reload()">
                    <i class="bi bi-arrow-clockwise"></i> 새로고침
                </button>
            </div>
        </nav>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold mb-0 text-success" style="font-size: 1.25rem;">
                    <i class="bi bi-journal-text me-2"></i>게시글 관리
                </h4>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle text-center">
                    <thead>
                        <tr>
                            <th width="80">번호</th>
                            <th width="120">카테고리</th>
                            <th>게시글 제목</th>
                            <th width="120">작성자</th>
                            <th width="180">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${list}">
                            <tr id="row-cno-${item.c_no}">
                                <td><span class="text-muted">#${item.c_no}</span></td>
                                <td><span class="category-badge">${item.c_category}</span></td>
                                <td class="text-start">
                                    <a href="/communitydetail?c_no=${item.c_no}" class="text-dark text-decoration-none fw-bold">
                                        ${item.c_title}
                                    </a>
                                </td>
                                <td><span class="badge bg-white text-success border border-success-subtle">ID: ${item.m_no}</span></td>
                                <td>
                                    <a href="/communityupdateform?c_no=${item.c_no}" class="btn-edit me-2">[수정]</a>
                                    <a href="javascript:void(0);" class="btn-delete" onclick="deleteAsync('${item.c_no}', 'post')">[강제삭제]</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="fw-bold mb-0 text-success" style="font-size: 1.25rem;">
                    <i class="bi bi-chat-dots me-2"></i>실시간 댓글 모니터링
                </h4>
            </div>
            <div class="table-responsive">
                <table class="table table-hover align-middle text-center">
                    <thead>
                        <tr>
                            <th width="80">번호</th>
                            <th width="80">원문</th>
                            <th width="100">작성자</th>
                            <th>댓글 내용</th>
                            <th width="120">작성일</th>
                            <th width="100">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty allComments}">
                                <c:forEach var="com" items="${allComments}">
                                    <tr id="row-comment-${com.c_commentNo}">
                                        <td class="text-muted">${com.c_commentNo}</td>
                                        <td><span class="badge bg-light text-dark border">#${com.c_no}</span></td>
                                        <td class="fw-bold text-success">${com.m_no}</td>
                                        <td class="text-start">${com.c_commentContent}</td>
                                        <td><small class="text-muted"><fmt:formatDate value="${com.c_commentdate}" pattern="MM-dd HH:mm" /></small></td>
                                        <td>
                                            <a href="javascript:void(0);" class="btn-delete" onclick="deleteAsync('${com.c_commentNo}', 'comment')">[삭제]</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="6" class="py-5 text-muted">등록된 댓글이 없습니다.</td></tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
async function deleteAsync(no, type) {
    if (!no) return;
    const msg = type === 'post' ? '게시글과 모든 댓글이 삭제됩니다. 계속하시겠습니까?' : '댓글을 삭제하시겠습니까?';
    if (!confirm(msg)) return;

    const cp = "${pageContext.request.contextPath}";
    let url = (type === 'post') 
              ? cp + "/adminCommunitydelete?c_no=" + no 
              : cp + "/adminCommentdelete?c_commentNo=" + no;

    try {
        const response = await fetch(url, { method: 'GET' });
        if (response.ok) {
            const result = await response.text();
            if(result.trim() === "success") {
                if (type === 'post') {
                    const postRow = document.getElementById("row-cno-" + no);
                    if(postRow) postRow.remove();
                    // 게시글 삭제 시 관련 댓글 행들도 화면에서 즉시 제거
                    const allCommentRows = document.querySelectorAll('tr[id^="row-comment-"]');
                    allCommentRows.forEach(row => {
                        const postNoInComment = row.cells[1].innerText.replace('#', '').trim();
                        if (postNoInComment === no.toString()) row.remove();
                    });
                } else {
                    const commentRow = document.getElementById("row-comment-" + no);
                    if(commentRow) commentRow.remove();
                }
                // alert 생략 가능 (사용자 경험상 행이 사라지는 것으로 충분)
            } else {
                alert("삭제 실패: 권한이 없거나 이미 삭제된 데이터입니다.");
            }
        }
    } catch (error) { 
        console.error("에러 발생:", error);
        alert("서버 통신 중 오류가 발생했습니다.");
    }
}
</script>
</body>
</html>