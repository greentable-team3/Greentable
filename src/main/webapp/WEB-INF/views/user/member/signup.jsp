<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원가입 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/member.js"></script>

    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; padding: 50px 0; }
        
        .signup-container { max-width: 680px; margin: 0 auto; padding: 0 20px; }
        .signup-card { background: #fff; padding: 50px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        
        .brand-logo { text-align: center; margin-bottom: 40px; }
        .brand-logo img { width: 180px; }
        
        .section-title { font-size: 18px; font-weight: 800; color: #198754; margin-bottom: 25px; border-bottom: 2px solid #198754; padding-bottom: 10px; }
        
        .form-label { font-weight: 700; font-size: 13px; color: #555; margin-bottom: 8px; display: block; }
        .form-label .required { color: #ff4757; margin-left: 3px; }
        
        .form-control, .form-select { padding: 12px; border-radius: 6px; font-size: 14px; border: 1px solid #ddd; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); }
        
        /* 버튼 스타일 */
        .btn-green { background-color: #198754; color: white; border: none; font-weight: 700; transition: 0.2s; }
        .btn-green:hover { background-color: #146c43; color: white; }
        
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

        .btn-submit { width: 100%; padding: 16px; font-size: 17px; margin-top: 30px; border-radius: 8px; }

        /* 상태 메시지 */
        #idMsg, #pwMsg, #auth-msg { font-size: 12px; margin-top: 5px; font-weight: 600; display: block; }
        .text-success { color: #198754 !important; }
        .text-danger { color: #ff4757 !important; }

        .address-group input { margin-bottom: 10px; }
        .hint-text { font-size: 12px; color: #888; margin-top: 5px; }
    </style>
</head>

<body>
<div class="signup-container">
    <div class="signup-card">
        <div class="brand-logo">
            <a href="/main"><img src="/profile_images/green_table.png" alt="Greentable"></a>
        </div>

        <form action="/write" method="post" name="signup" id="signup" enctype="multipart/form-data" onsubmit="return check();">
            <input type="hidden" name="m_tel">
            <input type="hidden" name="m_addr" id="m_addr_hidden">

            <div class="section-title">기본 정보 입력</div>

            <div class="mb-4">
                <label class="form-label">아이디 <span class="required">*</span></label>
                <div class="input-group">
                    <input type="text" name="m_id" id="m_id" oninput="resetIdCheck()" class="form-control" placeholder="아이디를 입력해주세요" required>
                    <button type="button" class="btn btn-outline-custom" onclick="checkId();">중복검사</button>
                </div>
                <span id="idMsg"></span>
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">비밀번호 <span class="required">*</span></label>
                    <input type="password" name="m_passwd" class="form-control" placeholder="비밀번호 입력" required>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">비밀번호 확인 <span class="required">*</span></label>
                    <input type="password" name="m_passwd2" oninput="checkpasswd();" class="form-control" placeholder="비밀번호 재입력" required>
                    <span id="pwMsg"></span>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">이름 <span class="required">*</span></label>
                    <input type="text" name="m_name" class="form-control" placeholder="실명을 입력하세요" required>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">닉네임<span class="required">*</span></label>
                    <input type="text" name="m_nickname" class="form-control" placeholder="활동 닉네임">
                </div>
            </div>

            <div class="mb-4 address-group">
                <label class="form-label">배송 주소 <span class="required">*</span></label>
                <div class="input-group mb-2">
                    <input type="text" id="postcode" class="form-control rounded-end-0" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-outline-custom" onclick="execDaumPostcode()">주소 검색</button>
                </div>
                <input type="text" id="roadAddress" class="form-control mb-2" placeholder="도로명 주소" readonly>
                <input type="text" id="detailAddress" class="form-control" placeholder="상세 주소를 입력해주세요">
            </div>

            <div class="mb-4">
                <label class="form-label">연락처 <span class="required">*</span></label>
                <div class="d-flex align-items: center; gap: 8px;">
                    <select name="m_tel1" class="form-select" style="flex: 1;">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                    </select>
                    <span class="pt-2">-</span>
                    <input type="text" name="m_tel2" maxlength="4" class="form-control" style="flex: 1;" required>
                    <span class="pt-2">-</span>
                    <input type="text" name="m_tel3" maxlength="4" class="form-control" style="flex: 1;" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">생년월일</label>
                <input type="date" name="m_bir" class="form-control">
            </div>

            <div class="mb-4">
                <label class="form-label">이메일 <span class="required">*</span></label>
                <div class="input-group">
                    <input type="email" name="m_email" id="m_email" class="form-control" placeholder="example@email.com" required>
                    <button type="button" id="send-btn" class="btn btn-outline-custom" onclick="sendJoinEmail();">인증요청</button>
                </div>
            </div>

            <div id="auth-section" class="mb-4" style="display:none; background: #f9fff9; padding: 15px; border-radius: 8px; border: 1px dashed #82cd47;">
                <label class="form-label text-success">인증번호 입력</label>
                <div class="input-group">
                    <input type="text" id="auth_code" class="form-control" placeholder="6자리 숫자">
                    <button type="button" id="verify-btn" class="btn btn-green rounded-end" onclick="verifyEmailCode();">확인</button>
                </div>
                <span id="auth-msg"></span>
            </div>

            <div class="mb-4">
                <label class="form-label">프로필 이미지</label>
                <input type="file" name="m_image_file" id="m_image_file" class="form-control">
                <p class="hint-text"><i class="bi bi-info-circle"></i> 본인을 나타내는 사진을 등록해주세요.</p>
            </div>

            <div class="mb-4">
                <label class="form-label">관리자 인증코드</label>
                <input type="password" name="adminCode" class="form-control" placeholder="관리자 가입 시에만 입력하세요">
            </div>

            <c:if test="${not empty msg}">
                <div class="alert alert-danger py-2 text-center" style="font-size: 13px;">${msg}</div>
            </c:if>

            <button type="submit" class="btn btn-green btn-submit shadow-sm">가입하기</button>
            
            <div class="d-flex justify-content: center; gap: 15px; margin-top: 25px;">
                <button type="reset" class="text-muted border-0 bg-transparent small">다시 작성</button>
                <span class="text-muted small">|</span>
                <button type="button" class="text-muted border-0 bg-transparent small" onclick="history.back()">뒤로 가기</button>
            </div>
        </form>
    </div>
</div>

<footer class="text-center mt-5 text-muted small">
    &copy; 2026 Greentable. All rights reserved.
</footer>

</body>
</html>