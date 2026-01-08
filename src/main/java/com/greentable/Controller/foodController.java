package com.greentable.Controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.foodDAO;
import com.greentable.DAO.food_ingredientsDAO;
import com.greentable.DTO.foodDTO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class foodController {
	@Autowired
	foodDAO dao;
	
	@Autowired
	food_ingredientsDAO fidao;
	
	@RequestMapping("/") // 메인화면
	public String root() {
		return "home";
	}
	
	@RequestMapping("/finsertForm") // 레시피 등록 폼
	public String finsertForm() {	
		return "/admin/finsertForm";
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
	public String foodlist(Model model) {
		model.addAttribute("list", dao.flistDao());
		return "user/food/foodlist";
	}
	
	@RequestMapping("/fdetail")   // 레시피 상세보기 
	public String fdetail(@RequestParam("f_no") int f_no, HttpServletRequest request, Model model, foodDTO dto) {
		model.addAttribute("detail", dao.fdetailDao(dto));
		model.addAttribute("ingrelist", fidao.fiselectDao(f_no));
		return "user/food/fdetail";
	}
	
	
	@RequestMapping("/fdelete")  // 레시피 삭제
	public String fdelete(HttpServletRequest request, foodDTO dto) {
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		dao.fdeleteDao(f_no);
		return "redirect:/foodlist";
	}

	@RequestMapping("/fedit")  // 레시피 수정 전 목록 확인
	public String fedit(@RequestParam("f_no") int f_no, Model model) {
		model.addAttribute("edit", dao.feditDao(f_no));
		return "user/food/fedit";
	}
	
	@RequestMapping("/fupdate")  // 레시피 수정
	public String fupdate(HttpServletRequest request, foodDTO dto) {
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		dao.fupdateDao(dto);
		return "redirect:/foodlist";
	}
	
	
}


