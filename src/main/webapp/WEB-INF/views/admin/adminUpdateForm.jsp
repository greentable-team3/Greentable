<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="telArr" value="${fn:split(adminUpdate.m_tel, '-')}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>그린테이블 | 회원 정보 수정</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        :root {
            --gt-bright-green: #8bc34a;
            --gt-soft-bg: #f8fbef;
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
        }

        #sidebar .sidebar-header { padding: 35px 20px; text-align: center; border-bottom: 1px solid rgba(255,255,255,0.2); }

        #sidebar ul li a { padding: 16px 30px; display: block; color: rgba(255, 255, 255, 0.9); text-decoration: none; font-weight: 500; transition: 0.3s; }

        #sidebar ul li a:hover { background: rgba(255, 255, 255, 0.1); padding-left: 40px; color: white; }

        #sidebar ul li.active > a {
            background: white; color: #76a336; font-weight: 700; border-radius: 50px 0 0 50px; margin-left: 20px;
        }

        /* 메인 컨텐츠 영역 */
        #main-content { margin-left: 260px; width: calc(100% - 260px); }

        .navbar-admin { background: white; padding: 20px 40px; border-bottom: 1px solid #f1f1f1; }

        .admin-card {
            background: white; padding: 45px; border-radius: 30px; box-shadow: 0 10px 40px rgba(0,0,0,0.03);
            margin: 40px auto; border: 1px solid #f0f3e8; max-width: 800px;
        }

        /* 폼 스타일 */
        .form-label { font-weight: 600; color: #444; margin-bottom: 8px; margin-top: 15px; }
        .form-control, .form-select {
            border-radius: 12px; padding: 12px; border: 1px solid #e2e8f0; transition: 0.3s;
        }
        .form-control:focus { border-color: var(--gt-bright-green); box-shadow: 0 0 0 4px rgba(139, 195, 74, 0.1); outline: none; }
        
        .readonly-field { background-color: #f8fafc; font-weight: bold; color: var(--gt-bright-green); }

        /* 버튼 */
        .btn-submit {
            background-color: var(--gt-bright-green); color: white; border: none; padding: 14px 40px;
            border-radius: 15px; font-weight: 700; transition: 0.3s;
        }
        .btn-submit:hover { background-color: #76a336; transform: translateY(-3px); box-shadow: 0 8px 20px rgba(139, 195, 74, 0.3); color: white; }
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
                <i class="bi bi-person-gear me-2"></i> 회원 마스터 정보 수정
            </div>
            <div class="d-flex align-items-center small">
                <span class="me-3">${sessionScope.m_nickname} 관리자님</span>
                <img src="/profile_images/${sessionScope.m_image}" alt="프사" class="rounded-circle" style="width: 32px; height: 32px; object-fit: cover;">
            </div>
        </nav>

        <div class="admin-card">
            <div class="text-center mb-5">
                <h2 class="fw-bold" style="color: #4a6d1a;">회원 상세 프로필 수정</h2>
                <p class="text-muted">아이디: <span class="badge bg-success-subtle text-success px-3">${adminUpdate.m_id}</span></p>
            </div>

            <form action="/adminUpdate" method="post" name="adminUpdateForm" enctype="multipart/form-data">
                <input type="hidden" name="m_no" value="${adminUpdate.m_no}">
                <input type="hidden" name="m_authority" value="${adminUpdate.m_authority}">
                <input type="hidden" name="old_passwd" value="${adminUpdate.m_passwd}">
                <input type="hidden" name="old_addr" value="${adminUpdate.m_addr}">
                <input type="hidden" name="m_addr">
                <input type="hidden" name="m_tel">

                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label">이름</label>
                        <input type="text" name="m_name" class="form-control" value="${adminUpdate.m_name}">

                        <label class="form-label">새 비밀번호 <small class="text-muted">(변경 시에만 입력)</small></label>
                        <input type="password" name="m_passwd" class="form-control" placeholder="••••••••">

                        <label class="form-label">비밀번호 확인</label>
                        <input type="password" name="m_passwd2" class="form-control" oninput="checkpasswd();" placeholder="••••••••">
                        <div id="pwMsg" class="mt-1 small fw-bold"></div>
                        
                        <label class="form-label">닉네임</label>
                        <input type="text" name="m_nickname" class="form-control" value="${adminUpdate.m_nickname}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">생년월일</label>
                        <input type="date" name="m_bir" class="form-control" value="${adminUpdate.m_bir}">

                        <label class="form-label">이메일</label>
                        <input type="email" name="m_email" class="form-control" value="${adminUpdate.m_email}">

                        <label class="form-label">전화번호</label>
                        <div class="input-group">
                            <select name="m_tel1" class="form-select" style="max-width: 100px;">
                                <option value="010" ${telArr[0] == '010' ? 'selected' : ''}>010</option>
                                <option value="011" ${telArr[0] == '011' ? 'selected' : ''}>011</option>
                                <option value="016" ${telArr[0] == '016' ? 'selected' : ''}>016</option>
                            </select>
                            <span class="input-group-text bg-white">-</span>
                            <input type="text" name="m_tel2" class="form-control" maxlength="4" value="${telArr[1]}">
                            <span class="input-group-text bg-white">-</span>
                            <input type="text" name="m_tel3" class="form-control" maxlength="4" value="${telArr[2]}">
                        </div>

                        <label class="form-label">프로필 이미지</label>
                        <div class="card p-3 bg-light border-0 rounded-4">
                            <div class="small mb-2 text-muted">현재 파일: ${adminUpdate.m_image}</div>
                            <input type="file" name="m_image_file" class="form-control form-control-sm">
                        </div>
                    </div>

                    <div class="col-12 mt-4">
                        <label class="form-label d-block">배송 주소 관리</label>
                        <div class="row g-2">
                            <div class="col-8 col-md-4">
                                <input type="text" id="postcode" class="form-control" placeholder="우편번호" readonly>
                            </div>
                            <div class="col-4 col-md-2">
                                <button type="button" class="btn btn-dark w-100 rounded-3 py-2" onclick="execDaumPostcode()">검색</button>
                            </div>
                            <div class="col-12 col-md-6">
                                <input type="text" id="roadAddress" name="m_roadAdress" class="form-control" placeholder="도로명 주소" readonly>
                            </div>
                            <div class="col-12">
                                <input type="text" id="detailAddress" class="form-control" placeholder="상세 주소를 입력하세요">
                            </div>
                        </div>
                    </div>
                </div>

                <hr class="my-5 opacity-25">

                <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-5" onclick="location.href='/alist'">뒤로 가기</button>
                    <button type="reset" class="btn btn-light rounded-pill px-5 border">다시 작성</button>
                    <button type="button" class="btn-submit px-5 shadow-sm" onclick="check();">
                        <i class="bi bi-check-circle me-1"></i> 정보 수정 완료
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/adminUpdateForm.js"></script>
</body>
</html>