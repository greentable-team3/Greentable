package com.greentable.DAO;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.greentable.DTO.questionDTO;

@Mapper
public interface questionDAO {
    
    // 1. 목록 조회 (전체)
    public List<questionDTO> questionlistdao();           

    // 2. 글 저장 (DTO 안에 작성자 m_no가 포함되어야 함)
    public int questioninsertdao(questionDTO dto);        

    // 3. 상세보기
    public questionDTO questiondetaildao(int q_no);      

    // 4. 수정용 (DTO 안에 q_no와 m_no가 모두 있어야 본인 확인 후 수정됨)
    public void questionupdatedao(questionDTO dto); 

    // 5. 삭제용 [수정됨] q_no만 보내면 남의 글도 지울 수 있으므로, m_no를 함께 보냅니다.
    public void questiondeletedao(@Param("q_no") int q_no, @Param("m_no") int m_no);       

    // 6. 관리자용 답변 업데이트
    int updateAnswer(@Param("q_no") int q_no, @Param("q_answer") String q_answer);
    
    // 7. 관리자 전용 삭제 (관리자는 작성자 상관없이 q_no만으로 삭제 가능)
    public void adminQuestionDelete(int q_no);

    // 8. 검색 및 필터링 기능
    public List<questionDTO> questionselectlistdao(
        @Param("q_category") String q_category, 
        @Param("keyword") String keyword
    );
    
}