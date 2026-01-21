package com.greentable.Controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.ordersDAO;
import com.greentable.DTO.orderRequestDTO;
import com.greentable.DTO.ordersDTO;
import com.greentable.service.PaymentService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

	@Controller
	public class ordersController {
	   @Autowired
	   ordersDAO dao;
	   
	   @Autowired
	   PaymentService paymentService;
	   
	   // [보완] 공통 장바구니 카운트 갱신 메서드 (중복 코드 방지)
	   private void updateCartCount(HttpSession session, int m_no) {
	       session.setAttribute("cartCount", dao.getCartCount(m_no));
	   }
   
    @RequestMapping("/oinsertForm")
    public String insertForm(HttpServletRequest request, Model model, HttpSession session) {
       Integer m_no = (Integer) session.getAttribute("m_no");
       if (m_no == null) return "redirect:/login";
       
       updateCartCount(session, m_no); // 헤더용 카운트 갱신
       
       String[] b_no_list = request.getParameterValues("b_no");
       int sumprice = dao.getBasketSelectTotal(b_no_list);
       int fee = (sumprice >= 15000) ? 0 : 3000;
        
       model.addAttribute("b_no_list", b_no_list);
       model.addAttribute("sumprice", sumprice);
       model.addAttribute("fee", fee);
        
       return "user/orders/orinsertForm";
    }
   
    @Transactional
    @RequestMapping("/oinsert")
    public String insert(ordersDTO dto, HttpServletRequest request, HttpSession session) {
        Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login"; 

        String[] b_no_list = request.getParameterValues("b_no_list");
        if (b_no_list != null) {
            int sumprice = dao.getBasketSelectTotal(b_no_list);
            int fee = (sumprice >= 15000) ? 0 : 3000;
            
            dto.setO_fee(fee);
            dto.setO_total(sumprice + fee);
            dto.setM_no(m_no); 
            
            dao.oinsertDao(dto, b_no_list); 
            dao.odinsertDao(dto.getO_no(), b_no_list);
            dao.basketdeleteDao(b_no_list);
            
            updateCartCount(session, m_no); // 주문 후 개수 갱신
        }
        return "redirect:/olist";
    }

   
    // 구매확정/반품 요청
    @RequestMapping("/changeStatus")
    public String changeStatus(@RequestParam("o_no") int o_no, @RequestParam("status") String status) {
        dao.updateStatus(o_no, status);
        return "redirect:/odetail?o_no=" + o_no;
    }
    
    @RequestMapping("/olist")
    public String list(HttpSession session, Model model) {
       Integer m_no = (Integer) session.getAttribute("m_no");
        if (m_no == null) return "redirect:/login";

        updateCartCount(session, m_no); // [추가] 주문목록 페이지 진입 시 카운트 갱신
        
        List<ordersDTO> list = dao.olistDao(m_no); 
        model.addAttribute("list", list);
        
        return "user/orders/orlist";
    }
   
   @RequestMapping("/odetail")
   public String orderDetail(@RequestParam("o_no") int o_no, HttpSession session, Model model) {
      Integer m_no = (Integer) session.getAttribute("m_no");
       if (m_no == null) return "redirect:/login";

       updateCartCount(session, m_no); // [추가] 상세페이지 진입 시 카운트 갱신

       ordersDTO master = dao.getOrderMaster(o_no);
       if (m_no != 1 && master.getM_no() != m_no) {
           return "redirect:/accessDenied";
       }

       model.addAttribute("master", master);
       model.addAttribute("details", dao.getOrderDetailList(o_no));
       model.addAttribute("requestInfo", dao.getOrderRequest(o_no));
       
       return "user/orders/odetail";
   }
   
   // --- 관리자 전용 주문 목록 페이지 ---
   @RequestMapping("/admin/olist")
   public String adminList(HttpSession session, Model model) {
      Integer m_no = (Integer) session.getAttribute("m_no");
       if (m_no == null || m_no != 1) return "redirect:/main"; 

       updateCartCount(session, m_no); 
       List<ordersDTO> list = dao.olistDao(1); 
       model.addAttribute("list", list);
       return "admin/adminOrderList";
   }
   
   // --- 상태 변경 처리 (배송시작/배송완료 등) ---
   @RequestMapping("/updateStatus")
   public String updateStatus(@RequestParam("o_no") int o_no, 
                              @RequestParam("status") String status) {
       // DAO의 updateStatus를 호출하여 DB의 o_status와 날짜를 업데이트
       dao.updateStatus(o_no, status);
       
       // 수정 후 다시 관리자 목록 페이지로 새로고침
       return "redirect:/admin/olist";
   }
   
   @RequestMapping("/submitRequest")
   public String submitRequest(orderRequestDTO requestDto, 
                               @RequestParam("uploadFile") MultipartFile file,HttpServletRequest request) {
       
      if (!file.isEmpty()) {
           try {
               String savePath = "C:/upload/"; // 고정 경로 추천
               File folder = new File(savePath);
               if (!folder.exists()) folder.mkdirs();

               // 원본 파일명에서 확장자만 추출 (예: .jpg)
               String originalName = file.getOriginalFilename();
               String extension = originalName.substring(originalName.lastIndexOf("."));
               
               // 저장파일명 생성: 현재시간_랜덤값.jpg (한글 제거)
               String saveName = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + extension; 
               
               File target = new File(savePath, saveName);
               file.transferTo(target);
               
               requestDto.setR_img(saveName); // DB에는 영문 파일명 저장
               
           } catch (Exception e) {
               e.printStackTrace();
           }
       }

       // DB 저장 (파일명이 포함된 DTO)
       dao.insertOrderRequest(requestDto);

       // 주문 상태 변경
       String nextStatus = requestDto.getR_type().equals("반품") ? "반품접수" : "교환접수";
       dao.updateStatus(requestDto.getO_no(), nextStatus);

       return "redirect:/odetail?o_no=" + requestDto.getO_no();
   }

   // (관리자용) 반품/교환 승인 처리
   @RequestMapping("/admin/approveRequest")
   public String approveRequest(@RequestParam("o_no") int o_no, @RequestParam("type") String type, HttpSession session) {
      // [보안 로직 추가] 세션에서 m_no 확인
          Integer m_no = (Integer) session.getAttribute("m_no");
          
          // 로그인이 안 되어 있거나, 관리자(m_no=1)가 아니면 처리 거부
          if (m_no == null || m_no != 1) {
              return "redirect:/main"; // 혹은 접근 거부 페이지
          }
      if (type.equals("반품")) {
              try {
                  // 1. DB에서 결제 정보 조회 (o_pay_tid가 필요함)
                  ordersDTO master = dao.getOrderMaster(o_no);
                  String tid = master.getO_pay_tid(); 
                  
                  if (tid != null && !tid.isEmpty()) {
                      // 2. 실제 결제 취소 API 호출
                      String token = paymentService.getToken();
                      paymentService.refund(token, tid, "관리자 반품 승인 환불");
                      
                      // 3. 결제 취소 성공 시 DB 상태 변경
                      dao.updateStatus(o_no, "반품완료");
                  } else {
                      System.out.println("TID가 없어 환불을 진행할 수 없습니다.");
                  }
              } catch (Exception e) {
                  e.printStackTrace();
                  return "redirect:/admin/olist?error=refund_fail";
              }
          } else {
              // 교환인 경우 물건만 다시 보내는 것이므로 상태만 변경
              dao.updateStatus(o_no, "교환완료");
          }
          return "redirect:/admin/olist";
   }
   
   @RequestMapping("/orderRequestForm")
   public String orderRequestForm(@RequestParam("o_no") int o_no, 
                                  @RequestParam("type") String type, Model model) {
       model.addAttribute("o_no", o_no);
       model.addAttribute("type", type);
       return "user/orders/orderRequestForm"; // jsp 파일명 확인
   }
}
