package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greentable.DTO.foodDTO;
import com.greentable.DTO.ingredientsDTO;

@Mapper
public interface foodDAO {
	public List<foodDTO> flistDao(); //레시피 목록
	public foodDTO fdetailDao(foodDTO dto); // 레시피 상세보기
	public int finsertDao(foodDTO dto); //레시피 등록
	public int fdeleteDao(int f_no); // 레시피 삭제
	public foodDTO feditDao(int f_no); // 레시피 수정 전 폼
	public int fupdateDao(foodDTO dto); // 레시피 수정 폼
	

}
