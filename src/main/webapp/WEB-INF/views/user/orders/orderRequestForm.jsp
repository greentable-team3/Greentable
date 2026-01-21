<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${param.type} 신청 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9f8; font-family: 'Pretendard', sans-serif; padding: 40px 0; }
        
        .request-container { max-width: 500px; margin: 0 auto; padding: 0 20px; }
        .request-card { background: #fff; padding: 35px; border-radius: 12px; border: 1px solid #eee; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        
        .section-title { font-size: 22px; font-weight: 800; color: #198754; margin-bottom: 25px; text-align: center; }
        
        .info-box { background-color: #f1f8e9; padding: 15px; border-radius: 8px; margin-bottom: 25px; border: 1px solid #e1eedb; }
        .info-label { font-size: 13px; color: #555; font-weight: 600; }
        .info-value { font-size: 16px; color: #198754; font-weight: 800; margin-top: 2px; }

        .form-label { font-weight: 700; font-size: 14px; color: #333; margin-bottom: 8px; display: block; }
        .form-control { border-radius: 8px; border: 1px solid #ddd; padding: 12px; font-size: 14px; transition: 0.2s; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); }
        
        /* 파일 업로드 커스텀 스타일 */
        .file-upload-wrapper { background: #f9f9f9; border: 1px dashed #ccc; border-radius: 8px; padding: 20px; text-align: center; cursor: pointer; transition: 0.2s; }
        .file-upload-wrapper:hover { border-color: #198754; background: #f1f8e9; }
        .file-upload-wrapper i { font-size: 24px; color: #198754; display: block; margin-bottom: 5px; }
        
        .btn-submit { width: 100%; padding: 15px; font-size: 16px; font-weight: 800; border-radius: 8px; background-color: #198754; border: none; color: white; margin-top: 30px; transition: 0.2s; }
        .btn-submit:hover { background-color: #146c43; transform: translateY(-2px); }
        
        .btn-back { display: block; text-align: center; margin-top: 15px; color: #888; text-decoration: none; font-size: 13px; }
        .btn-back:hover { color: #555; text-decoration: underline; }
    </style>
</head>
<body>

<div class="request-container">
    <div class="request-card shadow-sm">
        <div class="section-title">${param.type} 신청</div>

        <form action="/submitRequest" method="post" enctype="multipart/form-data">
            <input type="hidden" name="o_no" value="${param.o_no}">
            <input type="hidden" name="r_type" value="${param.type}">
            
            <div class="info-box d-flex justify-content-between align-items-center">
                <div>
                    <div class="info-label">주문번호</div>
                    <div class="info-value" style="color: #333; font-size: 14px;">${param.o_no}</div>
                </div>
                <div class="text-end">
                    <div class="info-label">신청 유형</div>
                    <div class="info-value"><i class="bi bi-check2-circle"></i> ${param.type}</div>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">사유 작성</label>
                <textarea name="r_reason" rows="5" class="form-control" placeholder="${param.type}하시는 구체적인 사유를 입력해 주세요." required></textarea>
            </div>
            
            <div class="mb-2">
                <label class="form-label">증빙 사진 첨부</label>
                <div class="file-upload-wrapper" onclick="document.getElementById('uploadFile').click();">
                    <i class="bi bi-camera"></i>
                    <span id="fileNameDisplay" style="font-size: 13px; color: #777;">클릭하여 사진을 업로드하세요.</span>
                    <input type="file" name="uploadFile" id="uploadFile" style="display: none;" onchange="updateFileName(this)">
                </div>
                <div class="form-text mt-2 text-muted" style="font-size: 12px;">
                    <i class="bi bi-info-circle"></i> 파손되거나 문제가 있는 부분을 찍어주시면 빠른 처리가 가능합니다.
                </div>
            </div>
            
            <button type="submit" class="btn-submit shadow">
                ${param.type} 접수하기
            </button>
            
            <a href="javascript:history.back();" class="btn-back">이전 페이지로 돌아가기</a>
        </form>
    </div>
</div>

<script>
    // 파일 선택 시 화면에 파일명 표시해주는 기능
    function updateFileName(input) {
        const display = document.getElementById('fileNameDisplay');
        if (input.files && input.files[0]) {
            display.innerText = "선택된 파일: " + input.files[0].name;
            display.style.color = "#198754";
            display.style.fontWeight = "bold";
        }
    }
</script>

</body>
</html>