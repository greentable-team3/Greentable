package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.ordersDTO;

@Mapper
public interface ordersDAO {
	public List<ordersDTO> olistDao(); // 주문목록
	
	// 1. 주문 저장: DTO(배송정보)와 b_no 리스트(금액계산용)를 같이 받음
    public int oinsertDao(@Param("dto") ordersDTO dto, @Param("b_no_list") String[] b_no_list);
    
    // 2. 주문 완료된 장바구니 삭제
    public int basketdeleteDao(@Param("b_no_list") String[] b_no_list);
}
