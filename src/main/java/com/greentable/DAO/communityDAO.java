package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.communityDTO;

@Mapper
public interface communityDAO {
	// 1. 커뮤니티 전체 목록
    public List<communityDTO> communitylistDao(); 

    // 2. 게시글 상세보기
    public communityDTO communitydetailDao(int c_no);

    // 3. 게시글 저장 (글쓰기)
    // [수정포인트 1] 
    // 여기서 넘겨주는 communityDTO 객체 안의 m_no 필드에 
    // 세션에서 꺼낸 작성자 번호가 들어있어야 Mapper.xml의 #{m_no}에 전달됩니다.
    public int communityinsertDao(communityDTO dto);

    // 4. 좋아요 증가
    public int communityupdateLoveDao(int c_no); 

    // 5. 최신 좋아요 수 조회
    public int communityLoveDao(int c_no); 

    // 6. 특정 게시글에 달린 '댓글 목록' 가져오기
    public List<communityDTO> communityListDao(int c_no);

    // 7. 댓글 저장
    // [수정포인트 2] 
    // 게시글 저장과 마찬가지로, dto 내부에 c_no(게시글번호)와 
    // m_no(작성자 세션번호)가 모두 셋팅된 상태로 호출되어야 합니다.
    public int commentWriteDao(communityDTO dto);
    
    // [수정포인트 3] 댓글 삭제
    // 현재는 댓글 번호만 받지만, 보안을 위해 
    // "작성자 본인인지" 체크하는 로직은 컨트롤러에서 m_no를 비교해 수행해야 합니다.
    public int commentDeleteDao(int c_commentNo); 

    // [수정포인트 4] 게시글 삭제
    public int communityDeleteDao(int c_no);      
    
    // 8. 게시글 수정
    // [수정포인트 5] 
    // 수정 시에도 DTO에 담긴 m_no를 사용하여 
    // "WHERE c_no = #{c_no} AND m_no = #{m_no}" 처럼 본인 확인 쿼리를 짤 수 있습니다.
    public int communityupdateDao(communityDTO dto);
    
    //검색 기능
    public List<communityDTO> communitylistdao(
    	    @Param("c_category") String c_category, 
    	    @Param("keyword") String keyword
    	);
    
 // 관리자 통합 페이지용: 전체 댓글 조회
    public List<communityDTO> allCommentListDao();

    // 관리자용: 게시글 삭제 시 해당 글의 댓글 선삭제
    public int commentDeleteByPostDao(int c_no);
    
    
 // 예시: 리스트를 가져오는 메서드
 // 관리자: 관리자의 공지사항이 맨위로가게합니다
    public List<communityDTO> communityadminuserlistdao(String c_category, String keyword);
    
    // 9. 공지사항 가져오기
    public communityDTO getLatestNotice();
}
