package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.greentable.DTO.questionDTO;



@Mapper
public interface questionDAO {
	public List<questionDTO> questionlistDao(); //회원 문의 게시판 목록조회
	public int questioninsertDao(questionDTO dto); // 회원 문의 게시글 등록
	public int questionDeleteDao(int q_no); //회원 문의 게시글 삭제
    public int questionUpdateDao(questionDTO dto); //회원 문의 게시글 수정
	// 특정 문글 번호로 상세보기
	public questionDTO questionDetailDao(int q_no);

}
