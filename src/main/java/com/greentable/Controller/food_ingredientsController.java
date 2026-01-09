package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.greentable.DAO.foodDAO;
import com.greentable.DAO.food_ingredientsDAO;
import com.greentable.DAO.ingredientsDAO;
import com.greentable.DTO.food_ingredientsDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class food_ingredientsController {
	@Autowired
	food_ingredientsDAO dao;
	@Autowired
	foodDAO fDao; // 음식 정보를 가져오기 위함
	@Autowired
	ingredientsDAO iDao; // 재료 정보를 가져오기 위함
	
	@RequestMapping("/fiinsertForm")
	public String insertForm(Model model) {
	    // 등록 시 선택할 수 있도록 전체 리스트를 보냅니다.
	    model.addAttribute("foodList", fDao.flistDao(null)); 
	    model.addAttribute("ingreList", iDao.ilistDao());
	    return "admin/fiinsertForm";
	}
	
	@RequestMapping("/fiinsert")
	public String insert(food_ingredientsDTO dto) {
		dao.fiinsertDao(dto);
		return "redirect:/filist";
	}
	
	@RequestMapping("/filist")
	public String list(Model model) {
		model.addAttribute("list", dao.filistDao());
		return "admin/filist";
	}
	
	@RequestMapping("/fidelete")
	public String delete(HttpServletRequest request) {
		int f_no = Integer.parseInt(request.getParameter("f_no"));
		int i_no = Integer.parseInt(request.getParameter("i_no"));
		
		dao.fideleteDao(f_no, i_no);
		return "redirect:/filist";
	}
	
}
