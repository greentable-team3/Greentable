<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<c:set var="telArr" value="${fn:split(update.m_tel, '-')}" />

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>정보 수정 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; padding: 50px 0; }
        
        .update-container { max-width: 750px; margin: 0 auto; padding: 0 20px; }
        .update-card { background: #fff; padding: 40px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        
        .header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #198754; padding-bottom: 15px; }
        .header-flex h3 { font-weight: 800; color: #198754; margin: 0; font-size: 22px; }
        
        .form-label { font-weight: 700; font-size: 13px; color: #555; margin-bottom: 8px; display: block; }
        .form-control, .form-select { padding: 11px; border-radius: 6px; font-size: 14px; border: 1px solid #ddd; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); }
        .form-control-plaintext { font-weight: 700; font-size: 16px; color: #222; padding-left: 5px; }

        /* 버튼 스타일 */
        .btn-green { background-color: #198754; color: white; border: none; font-weight: 700; transition: 0.2s; }
        .btn-green:hover { background-color: #146c43; color: white; }
        
        .btn-outline-custom { background: #fff; border: 1px solid #ddd; color: #666; font-weight: 600; font-size: 13px; }
        .btn-outline-custom:hover { background: #f8f9fa; }

        .btn-update-submit { padding: 14px 40px; font-size: 16px; border-radius: 8px; }

        /* 프로필 영역 */
        .current-img-info { background: #f1f8e9; padding: 10px; border-radius: 6px; margin-top: 8px; display: inline-block; font-size: 12px; color: #198754; font-weight: 600; }
        #pwMsg { font-size: 12px; margin-top: 5px; font-weight: 600; display: block; }
    </style>
</head>

<body>
<div class="update-container">
    <div class="update-card">
        <div class="header-flex">
            <h3>정보 수정</h3>
            <a href="/" class="btn btn-sm btn-outline-secondary rounded-pill px-3">메인으로</a>
        </div>

        <form action="/mupdate" method="post" name="updateForm" enctype="multipart/form-data">
            <input type="hidden" name="m_no" value="${update.m_no}">
            <input type="hidden" name="m_authority" value="${update.m_authority}">
            <input type="hidden" name="old_passwd" value="${update.m_passwd}">
            <input type="hidden" name="old_addr" value="${update.m_addr}">
            <input type="hidden" name="m_addr">
            <input type="hidden" name="m_tel">

            <div class="mb-4">
                <label class="form-label">아이디</label>
                <input type="text" readonly class="form-control-plaintext" value="${update.m_id}">
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">새 비밀번호</label>
                    <input type="password" name="m_passwd" class="form-control" placeholder="변경 시에만 입력">
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">비밀번호 확인</label>
                    <input type="password" name="m_passwd2" oninput="checkpasswd();" class="form-control" placeholder="비밀번호 재입력">
                    <span id="pwMsg"></span>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">이름</label>
                    <input type="text" name="m_name" value="${update.m_name}" class="form-control">
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">닉네임</label>
                    <input type="text" name="m_nickname" value="${update.m_nickname}" class="form-control">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">배송 주소</label>
                <div class="input-group mb-2">
                    <input type="text" id="postcode" class="form-control" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-outline-custom" onclick="execDaumPostcode()">주소 검색</button>
                </div>
                <input type="text" id="roadAddress" name="road_Address" class="form-control mb-2" placeholder="도로명 주소" readonly>
                <input type="text" id="detailAddress" class="form-control" placeholder="상세 주소를 입력하세요">
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">생년월일</label>
                    <input type="date" name="m_bir" value="${update.m_bir}" class="form-control">
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">이메일</label>
                    <input type="email" name="m_email" value="${update.m_email}" class="form-control">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">연락처</label>
                <div class="d-flex align-items-center gap-2">
                    <select name="m_tel1" class="form-select" style="width: 100px;">
                        <option value="010" ${telArr[0] == '010' ? 'selected' : ''}>010</option>
                        <option value="011" ${telArr[0] == '011' ? 'selected' : ''}>011</option>
                        <option value="016" ${telArr[0] == '016' ? 'selected' : ''}>016</option>
                    </select>
                    <span>-</span>
                    <input type="text" name="m_tel2" maxlength="4" value="${telArr[1]}" class="form-control text-center">
                    <span>-</span>
                    <input type="text" name="m_tel3" maxlength="4" value="${telArr[2]}" class="form-control text-center">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">프로필 이미지</label>
                <input type="file" name="m_image_file" class="form-control">
                <div class="current-img-info">
                    <i class="bi bi-file-earmark-image"></i> 현재 파일: ${update.m_image}
                </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-5">
                <button type="button" class="btn btn-outline-secondary px-4" onclick="location.href='/myinfo'">취소</button>
                <button type="reset" class="btn btn-outline-secondary px-4">초기화</button>
                <button type="button" class="btn btn-green btn-update-submit" onclick="check()">정보 수정 완료</button>
            </div>
        </form>
    </div>
</div>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/js/updateForm.js"></script>
</body>
</html>