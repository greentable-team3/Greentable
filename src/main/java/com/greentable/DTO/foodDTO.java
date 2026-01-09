package com.greentable.DTO;



import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class foodDTO {
	private int f_no;
	private String f_name;
	private String f_kind;
	private String f_category;
	private String f_add;
	private String f_ingredient;
	private String f_recipe;
	private int f_love;
	private MultipartFile f_kcal;
	private String f_kcalfilename;
	private MultipartFile f_img;
	private String f_imgfilename;
	
}
