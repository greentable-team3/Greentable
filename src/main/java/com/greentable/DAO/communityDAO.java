package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greentable.DTO.communityDTO;



@Mapper
public interface communityDAO {
	public List<communityDTO> communitylistDao(); //회원 커뮤니티 게시판 목록조회
	public int communityinsertDao(communityDTO dto); // 회원 게시글 등록
	public int communityDeleteDao(int c_no); //회원 게시글 삭제
	public int communityUpdateDao(communityDTO dto); //회원 게시글 수정
	// 특정 글 번호로 상세보기
	public communityDTO communityDetailDao(int c_no);

}






