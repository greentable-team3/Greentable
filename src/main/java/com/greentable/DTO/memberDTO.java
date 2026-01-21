package com.greentable.DTO;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import lombok.Data;


@Data
public class memberDTO {
	private String m_image; // 이미지 파일명
	private MultipartFile m_image_file; //  이미지 폴더(src\main\resources\static) 업로드용
	private int m_no;
	private String m_id;
	private String m_passwd;
	private String m_name;
	private String m_nickname;
	private String m_addr;
	@DateTimeFormat(pattern = "yyyy-MM-dd") // type = date인 파일의 출력 형식을 2000-01-01 형태로 저장
	private Date m_bir;
	private Date m_date;
	private String m_authority;
	private String m_tel;
	private String m_email;
}
