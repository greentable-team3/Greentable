package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.food_ingredientsDTO;
import com.greentable.DTO.ingredientsDTO;

@Mapper
public interface food_ingredientsDAO {
	// 1. 음식에 재료 연결 등록 (관리자용)
	public int fiinsertDao(food_ingredientsDTO dto);

    // 2. 음식에 연결된 재료 삭제 (관리자용)
	public int fideleteDao(@Param("f_no") int f_no, @Param("i_no") int i_no);

    // 3. 특정 음식의 모든 재료 목록 조회
	public List<ingredientsDTO> fiselectDao(int f_no);
    
    // 4. 음식의 모든 재료 목록 조회
    public List<food_ingredientsDTO> filistDao();
}
