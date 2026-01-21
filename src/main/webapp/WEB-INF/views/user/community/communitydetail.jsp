<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${dto.c_title}</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        /* 1. 전역 스타일 및 레이아웃 */
        body {
            font-family: "Malgun Gothic", dotum, sans-serif;
            background-color: #f8f9f8;
            margin: 0;
            padding: 40px 0;
            color: #333;
            line-height: 1.5;
        }

        .detail-container {
            width: 850px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 0; 
        }

        /* 2. 헤더 영역 */
        .post-header {
            text-align: left;
            margin-bottom: 0; 
            border-bottom: 2px solid #333;
            padding-bottom: 15px;
        }

        .category-badge {
            display: inline-block;
            color: #82cd47; 
            font-weight: bold;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .post-title {
            font-size: 24px;
            font-weight: bold;
            color: #222;
            margin: 0 0 15px 0;
            word-break: break-all;
        }

        .post-meta {
            color: #888;
            font-size: 12px;
            display: flex;
            justify-content: space-between;
        }

        .meta-actions a {
            text-decoration: none;
            color: #888;
            margin-left: 10px;
            font-size: 12px;
        }

        .meta-actions a:hover { color: #ff4757; }

        /* 3. 본문 내용 (수정됨) */
        .post-content {
            padding: 20px 0; /* 상하 여백만 살짝 추가 */
            font-size: 15px;
            color: #444;
            min-height: auto; 
            border-bottom: 1px solid #eee;
            white-space: pre-wrap; /* 줄바꿈 유지 */
            word-break: break-all;
            line-height: 1.8;
            overflow: hidden;
            text-indent: 0 !important; /* ⭐ 들여쓰기 강제 제거 */
            text-align: left;          /* ⭐ 좌측 정렬 명시 */
        }

        .post-content img {
            display: block;
            margin: 0 auto 20px auto; 
            width: 600px;        
            height: auto;       
            border: 1px solid #eee;
            border-radius: 2px;
        }

        /* 4. 좋아요 버튼 */
        .love-section {
            text-align: center;
            margin: 30px 0;
        }

        #btnLove {
            background: #fff;
            border: 1px solid #ddd;
            color: #ff4757;
            padding: 10px 25px;
            border-radius: 2px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.1s;
        }

        #btnLove:hover { background: #fff9f9; border-color: #ff4757; }

        /* 5. 댓글 영역 디자인 */
        .comment-section {
            border-top: 1px solid #ddd;
            padding-top: 25px;
            margin-top: 20px;
        }

        .comment-section h3 {
            font-size: 16px;
            color: #222;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .comment-form {
            background: #f9fff2;
            padding: 15px;
            border: 1px solid #eefae0;
            margin-bottom: 30px;
        }

        .comment-form textarea {
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 0;
            padding: 12px;
            box-sizing: border-box;
            font-size: 13px;
            resize: vertical;
            margin-bottom: 8px;
            white-space: pre-wrap;
            word-break: break-all;
        }

        #btnComment {
            background: #82cd47;
            color: #fff;
            border: 1px solid #71bb3a;
            padding: 8px 20px;
            border-radius: 2px;
            font-weight: bold;
            font-size: 13px;
            cursor: pointer;
            float: right;
        }

        .comment-item {
            padding: 15px 5px;
            border-bottom: 1px solid #f2f2f2;
        }

        .comment-user { font-weight: bold; color: #555; font-size: 13px; }
        .comment-date { font-size: 11px; color: #aaa; margin-left: 10px; }
        
        .comment-content { 
            margin: 10px 0 0 0; 
            color: #444; 
            font-size: 13px; 
            white-space: pre-wrap;
            word-break: break-all;
            line-height: 1.6;
        }
        
        .comment-delete { color: #ff4757; font-size: 11px; text-decoration: none; margin-left: 8px; font-weight: bold; }

        /* 6. 목록 버튼 */
        .list-btn-area {
            text-align: center;
            margin-top: 40px;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }

        .btn-list {
            text-decoration: none;
            background: #fff;
            color: #333;
            border: 1px solid #ddd;
            padding: 10px 30px;
            border-radius: 2px;
            font-size: 13px;
            font-weight: bold;
            display: inline-block;
        }

        .btn-list:hover { background: #f4f4f4; }
    </style>
</head>
<body>

<div class="detail-container">
    <div class="post-header">
        <span class="category-badge">[${dto.c_category}]</span>
        <h2 class="post-title">${dto.c_title}</h2>
        <div class="post-meta">
            <span>작성자: 회원(${dto.m_no}) | 게시번호: ${dto.c_no}</span>
            <c:if test="${not empty sessionScope.m_no && (dto.m_no == sessionScope.m_no || sessionScope.m_no == 1)}">
                <span class="meta-actions">
                    <a href="/communityupdateform?c_no=${dto.c_no}">수정</a>
                    <a href="/communitydelete?c_no=${dto.c_no}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
                </span>
            </c:if>
        </div>
    </div>

    <div class="post-content"><c:if test="${not empty dto.c_img}"><img src="/upload/${dto.c_img}"></c:if>${dto.c_content}</div>

    <div class="love-section">
        <button type="button" id="btnLove">❤️ 좋아요 <span id="loveCount">${dto.c_love}</span></button>
    </div>

    <div class="comment-section">
        <h3>댓글 작성</h3>
        <div class="comment-form">
            <form id="commentWriteForm"> 
                <input type="hidden" name="c_no" id="c_no" value="${dto.c_no}">
                <textarea name="c_commentContent" id="c_commentContent" rows="3" placeholder="건강한 커뮤니티를 위해 따뜻한 댓글을 남겨주세요." required></textarea>
                <button type="button" id="btnComment">등록하기</button>
                <div style="clear:both;"></div>
            </form>
        </div>

        <h3>전체 댓글 (${comments.size()})</h3>
        <div id="comment-list">
            <c:choose>
                <c:when test="${not empty comments}">
                    <c:forEach var="com" items="${comments}">
                        <div class="comment-item">
                            <span class="comment-user">회원(${com.m_no})</span>
                            <small class="comment-date">
                                <fmt:formatDate value="${com.c_commentdate}" pattern="yyyy-MM-dd HH:mm" />
                            </small>
                            <c:if test="${not empty sessionScope.m_no && (com.m_no == sessionScope.m_no || sessionScope.m_no == 1)}">
                                <a href="javascript:void(0);" onclick="deleteComment(${com.c_commentNo})" class="comment-delete">삭제</a>
                            </c:if>
                            <p class="comment-content">${com.c_commentContent}</p>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="color:#999; text-align:center; padding: 40px; font-size: 13px;">등록된 댓글이 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="list-btn-area">
        <a href="/communitylistform" class="btn-list">목록으로 돌아가기</a>
    </div>
</div>

<script>
    $("#btnLove").click(function() {
        $.ajax({
            url: '/communityupdateLove',
            type: 'POST',
            data: { c_no: ${dto.c_no} },
            success: function(count) {
                $("#loveCount").text(count);
            }
        });
    });

    $("#btnComment").click(function() {
        var content = $("#c_commentContent").val();
        var c_no = $("#c_no").val();

        if(content.trim() == "") {
            alert("내용을 입력해주세요.");
            return;
        }

        $.ajax({
            url: '/commentWrite',
            type: 'POST',
            data: { c_no: c_no, c_commentContent: content },
            success: function(response) {
                if(response === "success") { location.reload(); }
                else { alert("로그인이 필요한 서비스입니다."); }
            }
        });
    });

    function deleteComment(c_commentNo) {
        if(!confirm("댓글을 삭제하시겠습니까?")) return;
        $.ajax({
            url: '/commentdelete',
            type: 'GET',
            data: { c_commentNo: c_commentNo },
            success: function(response) {
                if(response === "success") { location.reload(); }
                else { alert("삭제 실패!"); }
            }
        });
    }
</script>

</body>
</html>