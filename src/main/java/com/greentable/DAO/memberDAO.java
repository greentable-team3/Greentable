package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.memberDTO;



@Mapper
public interface memberDAO {
	public List<memberDTO> listDao() ; // 占쎌돳占쎌뜚 筌뤴뫖以� 鈺곌퀬�돳
	public int SignupDao(memberDTO dto); // 占쎌돳占쎌뜚 揶쏉옙占쎌뿯
	public int DeleteMemberDao(int m_no);	// 占쎌돳占쎌뜚 占쎌젟癰귨옙 占쎄텣占쎌젫
    public memberDTO getMember(int m_no); // 占쎌돳占쎌뜚 占쎌젟癰귨옙 占쎈땾占쎌젟
    public int updateDao(memberDTO dto); // 占쎈땾占쎌젟占쎈쭆 占쎌돳占쎌뜚 占쎌젟癰귣�占쏙옙 DB占쎈퓠 占쏙옙占쎌삢
    public memberDTO findByMid(String m_id); // 嚥≪뮄�젃占쎌뵥占쎌뒠 鈺곌퀬�돳
    public boolean checkPasswordDao(int rno, String passwd); // �뜮袁⑨옙甕곕뜇�깈 筌ｋ똾寃�
    public memberDTO getMemberByIdDao(@Param("m_id") String m_id); // 占쎄땀 占쎌젟癰귨옙
    public memberDTO MemberByLoginIdDao(String m_id); // 占쎄땀 占쎌젟癰귨옙
    int idCheck(String m_id); // 占쎈툡占쎌뵠占쎈탵 餓λ쵎�궗 占쎌넇占쎌뵥
    public List<memberDTO> findAllByEmail(String m_email); // �븘�씠�뵒 議댁옱 �뿬遺� �솗�씤 (�븘�씠�뵒 李얘린�슜)
    void updatePassword(@Param("m_id") String m_id,
                        @Param("m_passwd") String m_passwd);// 鍮꾨�踰덊샇 蹂�寃�
}
