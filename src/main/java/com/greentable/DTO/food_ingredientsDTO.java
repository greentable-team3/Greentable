package com.greentable.DTO;

import lombok.Data;

@Data
public class food_ingredientsDTO {
	private int f_no; // 음식 번호 (FK)
    private int i_no; // 재료 번호 (FK)
    
    // 추가: 리스트 출력용 필드
    private String f_name; // 음식명
    private String i_name; // 재료명
}
