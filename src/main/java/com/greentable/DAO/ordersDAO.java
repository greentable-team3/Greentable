package com.greentable.DAO;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.greentable.DTO.orderDetailDTO;
import com.greentable.DTO.orderRequestDTO;
import com.greentable.DTO.ordersDTO;

@Mapper
public interface ordersDAO {
   // 1. 주문 목록 조회 (파라미터 추가)
    // m_no가 1(관리자)이면 전체 조회, 그 외엔 해당 회원만 조회하도록 XML에서 처리
   // 1. 주문 전체 목록 조회 (마이페이지용)
   public List<ordersDTO> olistDao(@Param("m_no") Integer m_no);
    
    // 2. 선택된 장바구니 항목들의 순수 상품 금액 합계 계산
    int getBasketSelectTotal(@Param("b_no_list") String[] b_no_list);
    
    // 3. 주문 마스터 정보 저장 (결제 정보 및 자동 배송번호 포함)
    public int oinsertDao(@Param("dto") ordersDTO dto, @Param("b_no_list") String[] b_no_list);
    
    // 4. 주문 상세 내역 저장 (order_detail 테이블로 복사)
    int odinsertDao(@Param("o_no") int o_no, @Param("b_no_list") String[] b_no_list);
    
    // 5. 주문 완료된 장바구니 항목 삭제
    public int basketdeleteDao(@Param("b_no_list") String[] b_no_list);
    
    // 6. 특정 주문의 마스터 정보 가져오기 (상세페이지 상단)
    ordersDTO getOrderMaster(@Param("o_no") int o_no);

    // 7. 특정 주문의 상세 상품 리스트 가져오기 (상세페이지 하단)
    List<orderDetailDTO> getOrderDetailList(@Param("o_no") int o_no);

    /**
     * 추가된 기능들
     */

    // 8. 주문 상태 변경 (상태값: '구매확정', '반품신청', '배송중' 등)
    // XML에서 #{status}와 #{o_no}로 접근합니다.
    int updateStatus(@Param("o_no") int o_no, @Param("status") String status);

    // 9. 자동 구매 확정 처리 (7일 경과 데이터 일괄 변경)
    // 파라미터 없이 스케줄러가 호출합니다.
    int updateAutoConfirm();
    
    // 반품/교환 상세 내역 저장
    void insertOrderRequest(orderRequestDTO dto);

    // (관리자용) 특정 주문의 반품/교환 사유 조회
    orderRequestDTO getOrderRequest(int o_no);
    
    // DB에서 해당 사용자의 장바구니 레코드 개수를 세는 기능
    public int getCartCount(int m_no);
}
