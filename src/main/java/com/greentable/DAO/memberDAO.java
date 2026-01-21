package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.memberDTO;



@Mapper
public interface memberDAO {
	public List<memberDTO> listDao() ; // 회원 목록 조회
	public int SignupDao(memberDTO dto); // 회원 가입
	public int DeleteMemberDao(int m_no);	// 회원 정보 삭제
    public memberDTO getMember(int m_no); // 회원 정보 수정
    public int updateDao(memberDTO dto); // 수정된 회원 정보를 DB에 저장
    public memberDTO findByMid(String m_id); // 로그인용 조회
    public boolean checkPasswordDao(int rno, String passwd); // 비밀번호 체크
    public memberDTO getMemberByIdDao(String m_id); // 아이디로 조회
    public memberDTO MemberByLoginIdDao(String m_id); // 내 정보
    int idCheck(String m_id); // 아이디 중복 확인
    public List<memberDTO> findAllByEmail(String m_email); // 사용자가 입력한 이메일 입력값과 동일한 이메일 데이터를 가진 행을 조회
    // 비밀번호 재설정
    void updatePassword(@Param("m_id") String m_id, // m_id에 사용자가 입력한 값을 저장
                        @Param("m_passwd") String m_passwd);// m_passwd에 사용자가 입력한 값을 저장
    public int kakaoSignup(memberDTO dto); // 카카오톡 회원가입
}
