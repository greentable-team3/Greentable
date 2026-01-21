<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 상세 내용</title>
<style>
    /* 1. 전역 스타일 */
    body { 
        font-family: "Malgun Gothic", dotum, sans-serif; 
        background-color: #f8f9f8; 
        color: #333; 
        padding: 40px 0; 
        margin: 0;
        line-height: 1.4;
    }
    
    .detail-container { 
        width: 800px; 
        margin: 0 auto; 
        background: #fff; 
        padding: 30px; 
        border: 1px solid #ddd; 
        border-radius: 0; 
    }
    
    /* 접근 거부 스타일 */
    .denied-container { 
        text-align: center; 
        padding: 60px 30px; 
        background: #fff; 
        border: 1px solid #ddd;
        border-radius: 0; 
        width: 450px; 
        margin: 100px auto; 
    }
    .denied-icon { font-size: 40px; margin-bottom: 15px; display: block; }

    /* 제목 및 테이블 */
    h2 { 
        font-weight: bold; 
        font-size: 22px; 
        margin: 0 0 20px 0; 
        color: #222;
    }
    
    .detail-table { 
        width: 100%; 
        border-top: 2px solid #333; 
        border-collapse: collapse; 
        margin-bottom: 20px; 
    }
    .detail-table th { 
        background-color: #f9f9f9; 
        width: 120px; 
        padding: 12px; 
        border-bottom: 1px solid #eee; 
        text-align: left; 
        font-size: 13px; 
        color: #555; 
    }
    .detail-table td { 
        padding: 12px; 
        border-bottom: 1px solid #eee; 
        font-size: 13px; 
    }
    
    /* 본문 내용 박스: 공백 제거 및 정렬 보정 */
    .content-box { 
        min-height: auto; 
        padding: 10px 5px; 
        line-height: 1.7; 
        font-size: 14px;
        color: #444;
        white-space: pre-wrap; 
        word-break: break-all;
        overflow: hidden; 
        /* ⭐ 추가: 첫 줄 들여쓰기 강제 제거 및 왼쪽 정렬 */
        text-indent: 0 !important;
        text-align: left;
    }
    
    /* ⭐ 이미지 스타일 */
    .attached-img { 
        display: block;
        margin: 0 auto 15px auto; 
        width: 600px;        
        height: auto;       
        border: 1px solid #eee; 
        border-radius: 2px;
    }

    /* 버튼 스타일 */
    .btn-group { 
        display: flex; 
        justify-content: flex-end; 
        gap: 5px; 
        margin-top: 10px; 
        border-bottom: 1px solid #eee; 
        padding-bottom: 25px; 
    }
    .btn { 
        padding: 8px 18px; 
        border-radius: 2px; 
        cursor: pointer; 
        border: 1px solid #ccc; 
        font-weight: bold; 
        font-size: 13px; 
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }
    
    .btn-edit { background-color: #82cd47; color: white; border-color: #71bb3a; }
    .btn-list { background-color: #fff; color: #666; }
    .btn-delete { background-color: #fff; color: #ff4757; border-color: #ffd1d1; }

    /* 답변 영역 */
    .reply-section { margin-top: 30px; }
    .reply-header { 
        display: flex; 
        justify-content: space-between; 
        align-items: center; 
        margin-bottom: 15px; 
        border-bottom: 1px solid #333;
        padding-bottom: 10px;
    }
    .reply-box { 
        background: #f9fff2; 
        padding: 20px; 
        border: 1px solid #eefae0; 
        border-left: 4px solid #82cd47; 
        white-space: pre-wrap;
        word-break: break-all;
        /* ⭐ 답변 영역도 공백 제거 */
        text-indent: 0;
    }
    
    /* 관리자 답변 폼 */
    .reply-form textarea { 
        width: 100%; 
        padding: 12px; 
        border: 1px solid #ccc; 
        border-radius: 0; 
        resize: vertical; 
        font-family: inherit; 
        font-size: 13px;
        margin-bottom: 8px; 
        box-sizing: border-box;
        white-space: pre-wrap;
        word-break: break-all;
    }
    .btn-reply { 
        background: #333; 
        color: white; 
        border: none; 
        padding: 10px 20px; 
        border-radius: 2px; 
        cursor: pointer; 
        float: right; 
        font-weight: bold;
    }
</style>
</head>
<body>

<c:if test="${secretDenied}">
    <div class="denied-container">
        <span class="denied-icon">🔒</span>
        <h3>비밀글 보호 안내</h3>
        <p style="color: #888; font-size: 13px;">작성자 본인과 관리자만 열람 가능합니다.</p>
        <button class="btn btn-list" onclick="location.href='/questionlistform'">목록으로 돌아가기</button>
    </div>
</c:if>

<c:if test="${not secretDenied}">
<div class="detail-container">
    <div style="display: flex; justify-content: space-between; align-items: baseline;">
        <h2>문의 상세 내용</h2>
        <span style="color: #aaa; font-size: 12px;">문의번호 ${dto.q_no}</span>
    </div>
    
    <table class="detail-table">
        <tr>
            <th>문의 유형</th>
            <td><span style="color: #82cd47; font-weight: bold;">[${dto.q_category}]</span></td>
            <th>작성회원</th>
            <td>회원번호 ${dto.m_no}</td>
        </tr>
        <tr>
            <th>문의 제목</th>
            <td colspan="3" style="font-size: 15px; font-weight: bold; color: #222;">
                ${dto.q_title}
            </td>
        </tr>
        <tr>
          <td colspan="4">
              <div class="content-box"><c:if test="${not empty dto.q_img}"><img src="/upload/${dto.q_img}" class="attached-img"></c:if><c:out value="${dto.q_content}" escapeXml="false"/></div>
          </td>
      </tr>
    </table>

    <div class="btn-group">
        <a href="/questionlistform" class="btn btn-list">목록으로</a>
        <c:if test="${isOwner || isAdmin}">
            <a href="/questionupdateform?q_no=${dto.q_no}" class="btn btn-edit">수정하기</a>
            <a href="javascript:void(0);" class="btn btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='/questiondelete?q_no=${dto.q_no}'">삭제하기</a>
        </c:if>
    </div>

    <div class="reply-section">
        <div class="reply-header">
            <span style="font-weight: bold; font-size: 15px; color: #222;">💬 관리자 답변</span>
            <c:if test="${not empty dto.q_answer}">
                <span style="color: #82cd47; font-size: 12px; font-weight: bold;">ANSWERED</span>
            </c:if>
        </div>
        
        <c:choose>
            <c:when test="${isAdmin}">
                <form action="/questionreply" method="post" class="reply-form" style="overflow: hidden; margin-bottom: 20px;">
                    <input type="hidden" name="q_no" value="${dto.q_no}">
                    <textarea name="q_answer" rows="5" placeholder="사용자에게 전달할 답변을 입력하세요.">${dto.q_answer}</textarea>
                    <input type="submit" value="${empty dto.q_answer ? '답변 등록' : '답변 수정'}" class="btn-reply">
                </form>
            </c:when>
            <c:otherwise>
                <c:if test="${empty dto.q_answer}">
                    <div style="text-align: center; padding: 40px; color: #999; font-size: 13px; border: 1px dashed #ddd;">
                        내용 확인 후 빠른 시일 내에 답변드리겠습니다.
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>

        <c:if test="${not empty dto.q_answer}">
            <div class="reply-box">
                <div style="margin-bottom: 10px; color: #82cd47; font-weight: bold; font-size: 13px;">Greentable CS Team</div>
                <div style="color: #444; font-size: 14px;">${dto.q_answer}</div>
            </div>
        </c:if>
    </div>
</div>
</c:if>

</body>
</html>