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
}
