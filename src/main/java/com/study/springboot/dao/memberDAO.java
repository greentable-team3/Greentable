package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.memberDTO;



@Mapper
public interface memberDAO {
	public List<memberDTO> listDao() ; // 회원 목록 조회
	public int SignupDao(memberDTO dto); // 회원 가입
	public int DeleteMemberDao(int m_no);	// 회원 정보 삭제
    public memberDTO getMember(int m_no); // 회원 정보 수정
    public int updateDao(memberDTO dto); // 수정된 회원 정보를 DB에 저장
    public memberDTO findByMid(String m_id); // 로그인용 조회
    public boolean checkPasswordDao(int rno, String passwd); // 비밀번호 체크
    public memberDTO getMemberByIdDao(String m_id); // 내 정보
    public memberDTO MemberByLoginIdDao(String m_id); // 내 정보
    int idCheck(String m_id); // 아이디 중복 확인
}
