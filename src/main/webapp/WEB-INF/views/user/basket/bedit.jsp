<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>수량 수정 - Greentable</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    
    <style>
        body { 
            background-color: #f8f9f8; 
            font-family: 'Pretendard', sans-serif; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            min-height: 100vh; 
            margin: 0; 
        }

        .edit-card { 
            background: #fff; 
            padding: 30px; 
            border-radius: 12px; 
            border: 1px solid #eee; 
            width: 100%; 
            max-width: 320px; 
            box-shadow: 0 8px 20px rgba(0,0,0,0.06); 
            text-align: center;
        }

        .title { 
            font-size: 18px; 
            color: #198754; 
            font-weight: 800; 
            margin-bottom: 20px; 
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .form-control { 
            padding: 12px; 
            border-radius: 8px; 
            font-size: 18px; 
            font-weight: 700;
            text-align: center; 
            border: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .form-control:focus { 
            border-color: #198754; 
            box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.1); 
        }

        .btn-group-custom { 
            display: flex; 
            gap: 10px; 
        }

        .btn { 
            flex: 1; 
            padding: 12px; 
            font-weight: 700; 
            border-radius: 8px; 
            font-size: 14px; 
            transition: 0.2s; 
        }

        .btn-update { 
            background: #198754; 
            color: #fff; 
            border: none;
        }
        .btn-update:hover { background: #146c43; }

        .btn-cancel { 
            background: #f8f9fa; 
            color: #666; 
            border: 1px solid #ddd;
        }
        .btn-cancel:hover { background: #e9ecef; }
        
        .hint-text {
            font-size: 12px;
            color: #888;
            margin-bottom: 15px;
            display: block;
        }
    </style>
    
    <script>
        function check(){
            let b_count = document.basket.b_count;
            let expB_count = /^[0-9]+$/;
            
            if(!b_count.value || !expB_count.test(b_count.value) || b_count.value < 1){
                alert("주문 수량을 1 이상의 숫자로 입력해주세요.");
                b_count.focus();
                return false;
            }
            
            if(confirm("수량을 수정하시겠습니까?")) {
                document.basket.submit();
            }
        }
    </script>
</head>
<body>

    <div class="edit-card">
        <div class="title">
            <i class="bi bi-cart-check"></i> 수량 수정
        </div>
        
        <form name="basket" method="post" action="/bupdate">
            <input type="hidden" name="b_no" value="${edit.b_no}">
            
            <label class="hint-text">구매하실 수량을 선택해 주세요.</label>
            <input type="number" min="1" name="b_count" value="${edit.b_count}" class="form-control" autofocus>
            
            <div class="btn-group-custom">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <button type="button" class="btn btn-update" onclick="check()">수정하기</button>
            </div>
        </form>
    </div>

</body>
</html>