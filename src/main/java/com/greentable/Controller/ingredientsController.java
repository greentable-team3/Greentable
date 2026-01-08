package com.greentable.Controller;

import org.springframework.beans.factory.annotation.Autowired;
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
	public String insertForm() {
		return "user/ingredients/insertForm";
	}
	
	@RequestMapping("/iinsert")
	public String insert(ingredientsDTO dto) {
		dao.iinsertDao(dto);
		return "redirect:/ilist";
	}
	
	@RequestMapping("/ilist")
	public String list(Model model) {
		model.addAttribute("list", dao.ilistDao());
		return "user/ingredients/list";
	}
	
	@RequestMapping("/idelete")
	public String delete(HttpServletRequest request) {
		int i_no = Integer.parseInt(request.getParameter("i_no"));
		dao.ideleteDao(i_no);
		return "redirect:/ilist";
	}
	
	@RequestMapping("/iupdateForm")
	public String updateForm(HttpServletRequest request, Model model) {
		int i_no = Integer.parseInt(request.getParameter("i_no"));
		model.addAttribute("update", dao.ieditlistDao(i_no));
		return "user/ingredients/updateForm";
	}
	
	@RequestMapping("/iupdate")
	public String update(ingredientsDTO dto) {
		dao.iupdateDao(dto);
		return "redirect:/ilist";
	}
}
