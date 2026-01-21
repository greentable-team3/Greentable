package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.foodDTO;

@Mapper
public interface foodDAO {
	List<foodDTO> searchFoodDao(@Param("searchType") String searchType, @Param("keyword") String keyword); // 메인 화면 검색 기능을 위한 메서드
	public List<foodDTO> flistDao(@Param("f_kind") String f_kind); // 레시피 목록(분류에 따라)
	public foodDTO fdetailDao(foodDTO dto); // 레시피 상세보기
	public int finsertDao(foodDTO dto); //레시피 등록
	public int fdeleteDao(int f_no); // 레시피 삭제
	public foodDTO feditDao(int f_no); // 레시피 수정 전 폼
	public int fupdateDao(foodDTO dto); // 레시피 수정 폼
	public void updateLove(@Param("f_no") String f_no); // 좋아요 기능	

}
