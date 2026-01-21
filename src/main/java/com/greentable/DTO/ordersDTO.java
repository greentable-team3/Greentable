package com.greentable.DTO;

import lombok.Data;

@Data
public class ordersDTO {
	private int o_no;
	private String o_name;
	private int o_total;
	private int o_fee;
	private String o_tel;
	private String o_addr;
	private String o_detail;
	private int b_no;
	private Integer m_no;
	
	// 추가 필드
    private String o_status;
    private String o_delivery_no;
    private java.sql.Date o_delivery_date;
    private java.sql.Date o_confirm_date;
    private String o_pay_tid;
    private String o_pay_method;
}
