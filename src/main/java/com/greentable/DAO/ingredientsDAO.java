package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greentable.DTO.ingredientsDTO;

@Mapper
public interface ingredientsDAO {
	public List<ingredientsDTO> ilistDao(); // 재료목록
	public int iinsertDao(ingredientsDTO dto); // 재료입력
	public int ideleteDao(int i_no); // 재료삭제
	public ingredientsDTO ieditlistDao(int i_no); // 재료수정폼
	public int iupdateDao(ingredientsDTO dto); // 재료수정
}
