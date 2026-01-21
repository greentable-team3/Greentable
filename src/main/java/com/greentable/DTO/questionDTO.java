package com.greentable.DTO;

import java.sql.Date;
import lombok.Data;

@Data
public class questionDTO {
    // question 테이블 컬럼
	private int m_no;
    private int q_no;
    private String q_category;
    private String q_secret;
    private String q_title;
    private String q_content;
    private String q_img;
    
    private String q_answer;      // 추가된 답변 컬럼
    private Date q_answerDate;    // 추가된 답변일 컬럼

    // q_comment(관리자 답변용) 필드
    private int c_no;
    private String c_content;
    private Date c_date;
}