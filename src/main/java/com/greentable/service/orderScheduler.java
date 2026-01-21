package com.greentable.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.greentable.DAO.ordersDAO;

@Component // 스프링이 이 클래스를 관리하도록 설정
public class orderScheduler {
	@Autowired
    ordersDAO dao;

    /**
     * cron 표현식 설명: "초 분 시 일 월 요일"
     * "0 0 0 * * *" : 매일 새벽 0시 0분 0초에 실행
     */
    @Scheduled(cron = "0 0 0 * * *")
    public void autoOrderConfirm() {
        System.out.println("--- 자동 구매 확정 스케줄러 실행 시작 ---");
        
        // DAO에 미리 만들어둔 자동 구매확정 쿼리 호출
        int count = dao.updateAutoConfirm();
        
        System.out.println("처리 결과: " + count + "건의 주문이 자동으로 구매 확정되었습니다.");
        System.out.println("--- 자동 구매 확정 스케줄러 실행 종료 ---");
    }
}
