package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.greentable.DAO.ordersDAO;
import com.greentable.DTO.ordersDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ordersController {
	@Autowired
	ordersDAO dao;
	
	// 주문 입력 폼: 장바구니에서 선택된 b_no들을 들고 옴
    @RequestMapping("/oinsertForm")
    public String insertForm(HttpServletRequest request, Model model) {
        String[] b_no_list = request.getParameterValues("b_no");
        model.addAttribute("b_no_list", b_no_list);
        return "user/orders/insertForm";
    }
	
    // 주문 처리
    @Transactional
    @RequestMapping("/oinsert")
    public String insert(ordersDTO dto, HttpServletRequest request) {
    	// JSP에서 체크한 장바구니 번호들만 가져옵니다.
        String[] b_no_list = request.getParameterValues("b_no_list");

        if (b_no_list != null && b_no_list.length > 0) {
            // m_no를 따로 세팅하지 않아도 XML의 서브쿼리가 basket 테이블에서 찾아갑니다.
            dao.oinsertDao(dto, b_no_list);
            
            // 데이터 보존을 위해 삭제는 일단 주석 처리 (성공 확인 후 해제)
            // dao.cartDeleteDao(b_no_list);
        }
        return "redirect:/olist";
    }
	
	@RequestMapping("/olist")
	public String list(Model model) {
		model.addAttribute("list", dao.olistDao());
		return "user/orders/list";
	}
}
