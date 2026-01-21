package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.greentable.DAO.basketDAO;
import com.greentable.DAO.ordersDAO;
import com.greentable.DTO.basketDTO;
import com.greentable.DTO.memberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class basketController {
   @Autowired
   basketDAO dao;
   
   @Autowired
    ordersDAO oDao;
   
   @RequestMapping("/cartlist") // 장바구니 목록
   public String cartlist(Model model,HttpSession session) {
      memberDTO member = (memberDTO) session.getAttribute("user");
      // 2. 로그인이 되어있는지 확인 (비로그인 시 처리)
       if (member != null) {
           // 3. 객체에서 실제 m_no 값을 꺼냅니다.
           int m_no = member.getM_no(); 
           
           // 4. dao에 하드코딩된 0 대신 실제 m_no를 전달합니다.
           model.addAttribute("list", dao.blistDao(m_no));
       } else {
           // 로그인이 안 되어 있을 경우 로그인 페이지로 리다이렉트 등의 처리
           return "redirect:/login"; 
       }
       
       return "user/basket/cartlist";
   }
   
   @RequestMapping("/bdelete")  // 장바구니 삭제
   public String bdelete(HttpServletRequest request, HttpSession session) {
      int b_no = Integer.parseInt(request.getParameter("b_no"));
        
        // 1. DB에서 삭제 실행
        dao.bdeleteDao(b_no);
        
        // 2. 삭제 후 현재 사용자의 장바구니 개수를 다시 세서 세션 갱신
        memberDTO member = (memberDTO) session.getAttribute("user");
        if (member != null) {
            int currentCount = oDao.getCartCount(member.getM_no());
            session.setAttribute("cartCount", currentCount); // ★ 세션 값 갱신
        }
        
        return "redirect:/cartlist";
   }

   @RequestMapping("/bedit")  // 장바구니 수정 전 목록 확인
   public String bedit(@RequestParam("b_no") int b_no, Model model) {
      model.addAttribute("edit", dao.beditDao(b_no));
      return "user/basket/bedit";
   }
   
   @RequestMapping("/bupdate")  // 장바구니 수정
   public String bupdate(@RequestParam("b_no") int b_no, @RequestParam("b_count") int b_count, HttpSession session) {
      // 1. 수량 업데이트 실행
       dao.bupdateDao(b_no, b_count);
       
       // 2. 세션의 장바구니 숫자 갱신 (동기화)
       memberDTO member = (memberDTO) session.getAttribute("user");
       if (member != null) {
           // DB에서 최신 개수를 다시 조회
           int currentCount = oDao.getCartCount(member.getM_no());
           // 세션에 덮어쓰기
           session.setAttribute("cartCount", currentCount);
       }
       
       return "redirect:/cartlist";
   }
   
   @RequestMapping("/binsert")  // 장바구니 담기
   public String binsert(basketDTO dto, @RequestParam(value="f_no") int f_no,
         HttpSession session,
          @RequestParam(value="i_no") int i_no,
          @RequestParam(value="b_count", required=false, defaultValue="1") int b_count) {
      // 1. 세션에서 로그인 정보 가져오기
       memberDTO member = (memberDTO) session.getAttribute("user");
       
       if (member != null) {
           // 2. dto에 로그인한 회원의 번호를 세팅 (dto에 setM_no 메서드가 있다고 가정)
           dto.setM_no(member.getM_no());
           
           // 3. 나머지 파라미터들도 dto에 담기 (필요한 경우)
           dto.setF_no(f_no);
           dto.setI_no(i_no);
           dto.setB_count(b_count);
           
           // 4. 세팅된 dto를 DAO에 전달
           dao.binsertDao(dto);
       } else {
           // 로그인이 안 되어 있다면 로그인 페이지로 보냄
           return "redirect:/login";
       }
       
       int currentCount = oDao.getCartCount(member.getM_no());
       session.setAttribute("cartCount", currentCount);
       
       return "redirect:/cartlist";
   }
   
   @RequestMapping("/binsertAjax")  // 장바구니 머물기
   @ResponseBody
   public String binsertAjax(basketDTO dto, HttpSession session) {
       memberDTO member = (memberDTO) session.getAttribute("user");
       if (member == null) {
           return "login_required";
       }
   
       try {
           dto.setM_no(member.getM_no()); 
           dao.binsertDao(dto); // 1. DB에 저장
   
           // ★ [추가] DB에 저장된 최신 개수를 다시 세서 세션 갱신
           int currentCount = oDao.getCartCount(member.getM_no());
           session.setAttribute("cartCount", currentCount); 
   
           return String.valueOf(currentCount); 
       } catch (Exception e) {
           return "fail";
       }
   }
   
   
}
