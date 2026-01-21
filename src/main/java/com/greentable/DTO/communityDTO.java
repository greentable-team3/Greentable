package com.greentable.DTO;

import java.sql.Timestamp;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;

@Data
public class communityDTO {
    // 게시글 필드
    private int c_no;
    private String c_category;
    private String c_title;
    private String c_content;
    private String c_img;
    private Timestamp c_date;
    private int c_love;
    private int m_no; // 작성자 (관리자=1)
    
    // 파일 업로드
    private MultipartFile file;

    // 댓글 필드 (한 번에 담기 위해 추가)
    private int c_commentNo;
    private String c_commentContent;
    private Timestamp c_commentdate;
}