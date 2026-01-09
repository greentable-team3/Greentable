package com.greentable.DTO;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class questionDTO {
	
	    private int q_no;               // 문의게시판 번호 (PK)
	    private String q_category;      // 카테고리
	    private String q_secret;        // 비밀글
	    private String q_title;         // 제목
	    private String q_content;       // 내용
	    private String q_img;           // 이미지 파일명
	    private MultipartFile qimage;   // 파일 업로드용
	    private int m_no;               // 회원번호 (FK)

}
