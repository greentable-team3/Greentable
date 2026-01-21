package com.greentable.Controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.foodDAO;
import com.greentable.DAO.food_ingredientsDAO;
import com.greentable.DTO.foodDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
public class foodController {
   @Autowired
   foodDAO dao;
   
   @Autowired
   food_ingredientsDAO fidao;
   
   
   @RequestMapping("/") // 메인화면
   public String root() {
      return "redirect:/main";
   }
   
   @RequestMapping("/finsertForm") // 레시피 등록 폼
   @PreAuthorize("hasAuthority('ADMIN')")
   public String finsertForm(Authentication authentication) {   
      // 1. 권한 확인 로그 (문제 발생 시 콘솔 확인용)
       if (authentication != null) {
           System.out.println("현재 접속자 권한: " + authentication.getAuthorities());
       }
       
       return "admin/finsertForm";
   }
   
   @RequestMapping("/finsert") // 레시피 등록
   public String finsert(foodDTO dto, @RequestParam("f_kcal") MultipartFile f_kcal, @RequestParam("f_img") MultipartFile f_img) throws Exception {   
      // 영양성분 파일업로드 했다면
      if(!f_kcal.isEmpty()) {
         String f_kcalfilename = f_kcal.getOriginalFilename();
         f_kcal.transferTo(new File("C:\\Greentable\\Greentable\\src\\main\\resources\\static\\image\\"+f_kcalfilename));
         dto.setF_kcalfilename(f_kcalfilename);
         
      }
      // 음식 파일업로드 했다면
      if(!f_img.isEmpty()) {
         String f_imgfilename = f_img.getOriginalFilename();
         f_img.transferTo(new File("C:\\Greentable\\Greentable\\src\\main\\resources\\static\\image\\"+f_imgfilename));
         dto.setF_imgfilename(f_imgfilename);
      
      }
      dao.finsertDao(dto);
      return "redirect:/foodlist";
   }
   
   
   
   @RequestMapping("/foodlist") // 레시피 목록
   public String foodlist(@RequestParam(value="f_kind", required=false) String f_kind, Model model) {
       
       // 1. 파라미터(f_kind)를 DAO의 메서드에 인자로 전달합니다.
       // 2. 만약 f_kind가 null이면 전체 리스트를, 값이 있으면 해당 분류만 가져오게 설계합니다.
       model.addAttribute("list", dao.flistDao(f_kind));
       
       // 선택된 카테고리를 뷰에서 알 수 있게 다시 모델에 담아주면 좋습니다 (선택 표시용)
       model.addAttribute("selectedKind", f_kind);
       
       return "user/food/foodlist";
   }
   
   
   
   @RequestMapping("/fdetail")   // 레시피 상세보기 
   public String fdetail(@RequestParam("f_no") int f_no, HttpServletRequest request, Model model, foodDTO dto) {
      model.addAttribute("detail", dao.fdetailDao(dto));
      model.addAttribute("ingrelist", fidao.fiselectDao(f_no));
      return "user/food/fdetail";
   }
   
   
   @RequestMapping("/fdelete")  // 레시피 삭제
   public String fdelete(@RequestParam("f_no") int f_no, HttpSession session) {
      Integer m_no = (Integer) session.getAttribute("m_no");
       // 관리자가 아니면 차단
       if (m_no == null || m_no != 1) {
           return "redirect:/foodlist";
       }
       dao.fdeleteDao(f_no);
       return "redirect:/foodlist";
   }

   @RequestMapping("/fedit")  // 레시피 수정 전 목록 확인
   public String fedit(@RequestParam("f_no") int f_no, HttpSession session, Model model) {
      Integer m_no = (Integer) session.getAttribute("m_no");
       if (m_no == null || m_no != 1) {
           return "redirect:/foodlist";
       }
       model.addAttribute("edit", dao.feditDao(f_no));
       return "user/food/fedit";
   }
   
   @RequestMapping("/fupdate")  // 레시피 수정
   public String fupdate(HttpServletRequest request, foodDTO dto) {
      int f_no = Integer.parseInt(request.getParameter("f_no"));
      dao.fupdateDao(dto);
      return "redirect:/foodlist";
   }
   
   @RequestMapping("/loveUpdate") // 좋아요 기능
   @ResponseBody
   public void loveUpdate(@RequestParam("f_no") String f_no) {
       dao.updateLove(f_no);
   }
   
}


