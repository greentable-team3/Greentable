package com.greentable.DTO;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class communityDTO {
	    private int c_no;              // 커뮤니티 번호 (PK)
	    private String c_category;     // 카테고리
	    private String c_title;        // 제목
	    private String c_content;      // 내용
	    private String c_img;          // 이미지 파일명
	    private MultipartFile cimage; // 이미지 파일
	    private int c_love;            // 좋아요 수
	    private String c_comment;      // 댓글
	    private int m_no;              // 회원 번호

}
