package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.greentable.DAO.basketDAO;
import com.greentable.DTO.basketDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class basketController {
	@Autowired
	basketDAO dao;
	
	@RequestMapping("/cartlist") // 장바구니 목록
	public String cartlist(Model model) {
		model.addAttribute("list", dao.blistDao());
		
		return "user/basket/cartlist";
	}
	
	@RequestMapping("/bdelete")  // 장바구니 삭제
	public String bdelete(HttpServletRequest request, basketDTO dto) {
		int b_no = Integer.parseInt(request.getParameter("b_no"));
		dao.bdeleteDao(b_no);
		return "redirect:/cartlist";
	}

	@RequestMapping("/bedit")  // 장바구니 수정 전 목록 확인
	public String bedit(@RequestParam("b_no") int b_no, Model model) {
		model.addAttribute("edit", dao.beditDao(b_no));
		return "user/basket/bedit";
	}
	
	@RequestMapping("/bupdate")  // 장바구니 수정
	public String bupdate(@RequestParam("b_no") int b_no, @RequestParam("b_count") int b_count, basketDTO dto) {
		dao.bupdateDao(b_no, b_count);
		return "redirect:/cartlist";
	}
	
	@RequestMapping("/binsert")  // 장바구니 담기
	public String binsert(basketDTO dto, @RequestParam(value="f_no") int f_no,
		    @RequestParam(value="i_no") int i_no,
		    @RequestParam(value="b_count", required=false, defaultValue="1") int b_count) {
		dao.binsertDao(dto);
		return "redirect:/cartlist";
	}
	
	@RequestMapping("/binsertAjax")  // 장바구니 머물기
	@ResponseBody
	public String binsertAjax(basketDTO dto, HttpSession session) {
		// 세션에서 로그인한 회원 정보 가져오기 (예: "user"라는 이름으로 저장된 경우)
	    // MemberDTO member = (MemberDTO) session.getAttribute("user");
	    // int m_no = member.getM_no();
		
		// 만약 테스트 중이라면 임시로 값을 넣으세요
	    int m_no = 1; 
	    dto.setM_no(m_no); // DTO에 회원 번호 설정
		
	    try {
	        // 데이터가 잘 들어오는지 확인용 로그
	        System.out.println("장바구니 담기 시도: " + dto.getI_no()); 
	        
	        dao.binsertDao(dto);
	        return "success"; 
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "fail";
	    }
	}
	
	
}
