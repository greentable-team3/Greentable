package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.greentable.DAO.ingredientsDAO;
import com.greentable.DTO.ingredientsDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ingredientsController {
   @Autowired
   ingredientsDAO dao;
   
   @RequestMapping("/iinsertForm")
   @PreAuthorize("hasAuthority('ADMIN')")
   public String iinsertForm(Authentication authentication) {   
      // 1. 권한 확인 로그 (문제 발생 시 콘솔 확인용)
       if (authentication != null) {
           System.out.println("현재 접속자 권한: " + authentication.getAuthorities());
       }
       
       return "admin/iinsertForm";
   }
   
   @RequestMapping("/iinsert")
   public String iinsert(ingredientsDTO dto) {
      dao.iinsertDao(dto);
      return "redirect:/inlist";
   }
   
   @RequestMapping("/inlist")
   public String ilist(Model model) {
      model.addAttribute("list", dao.ilistDao());
      return "admin/inlist";
   }
   
   @RequestMapping("/idelete")
   public String idelete(HttpServletRequest request) {
      int i_no = Integer.parseInt(request.getParameter("i_no"));
      dao.ideleteDao(i_no);
      return "redirect:/inlist";
   }
   
   @RequestMapping("/iupdateForm")
   public String iupdateForm(HttpServletRequest request, Model model) {
      int i_no = Integer.parseInt(request.getParameter("i_no"));
      model.addAttribute("update", dao.ieditlistDao(i_no));
      return "admin/iupdateForm";
   }
   
   @RequestMapping("/iupdate")
   public String iupdate(ingredientsDTO dto) {
      dao.iupdateDao(dto);
      return "redirect:/inlist";
   }
}
