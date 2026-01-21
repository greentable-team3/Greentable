package com.greentable.DTO;

import java.sql.Date;

import lombok.Data;

@Data
public class orderRequestDTO {
	private int r_no;          // 요청 번호 (PK)
    private int o_no;          // 주문 번호 (FK)
    private String r_type;     // '반품' 또는 '교환'
    private String r_reason;   // 사유
    private String r_img;      // 첨부 파일명
    private String r_status;   // '접수완료', '완료' 등
    private Date r_date;       // 신청일
}
