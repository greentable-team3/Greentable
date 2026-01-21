package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.basketDTO;

@Mapper
public interface basketDAO {
	public List<basketDTO> blistDao(int m_no); // 장바구니 목록
	public basketDTO beditDao(int b_no); // 장바구니 수정 전 폼
	void bupdateDao(@Param("b_no") int b_no, @Param("b_count") int b_count);
	public int bdeleteDao(int b_no); // 장바구니 삭제
	public int binsertDao(basketDTO dto); // 장바구니 등록
}
