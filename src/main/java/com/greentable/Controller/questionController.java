package com.greentable.Controller;


import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.questionDAO;
import com.greentable.DTO.questionDTO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class questionController {

    @Autowired
    private questionDAO dao;
    
    //1 문의 글쓰기 폼 이동
    @RequestMapping("/questionwriteform")
    public String writeForm() {
        return "/user/questionwriteform";
    }
    
    // 2 회원 문의 글 목록
    @RequestMapping("/questionlist")
    public String questionList(Model model) {
        List<questionDTO> list = dao.questionlistDao();
        model.addAttribute("list", list);
        return "/user/questionlist";
    }

 

 //회원 문의 (파일 업로드)처리
    @RequestMapping("/questionwrite")
    public String questionwrite(questionDTO dto,HttpServletRequest request) throws Exception { // 해당 메소드가 예외 처리가 된다면 아래 방법으로 처리해주세욥
        MultipartFile file = dto.getQimage(); // DTO에서 이미지 파일(cimage)을 꺼내서 'file'변수에 저장, 지금부턴 file이라는 변수가 이미지 파일(임시)
        
         // 이미지 파일 처리
           if (!file.isEmpty()) { //type이 'file'인 입력란에 공백이 없다면
            // 해당 입력란에 입력된 이미지 파일을 저장할 경로(폴더)를 'uploadDir' 변수에 저장, images 폴더에 저장
               Path uploadDir = Paths.get("C:\\Greentable\\src\\main\\resources\\static\\image");
               if (!Files.exists(uploadDir)) { // 만약 위의 경로가 존재 하지 않는다면 
                   Files.createDirectories(uploadDir); // 새로 폴더를 만들어주세요
               }
               String filename = file.getOriginalFilename();
               Path filePath = uploadDir.resolve(filename);
               Files.write(filePath, file.getBytes());

               dto.setQ_img(filename);
           }
           
           
           dao.questioninsertDao(dto);
           return "redirect:/questionlist";
    }

  
 //회원 문의 수정 
    @RequestMapping("/questionUpdateform")
    public String questionUpdate(@RequestParam("q_no") int q_no, Model model) {
    	questionDTO dto = dao.questionDetailDao(q_no);
        model.addAttribute("dto", dto);
        return "/user/questionUpdateform";
    }
    
 // 6️ 회원 문의 수정 처리
    @RequestMapping("/questionUpdate")
    public String questionupdate(questionDTO dto) throws Exception {

        MultipartFile file = dto.getQimage();

        if (file != null && !file.isEmpty()) {

            String imageName = file.getOriginalFilename();

            String uploadPath =
                "C:\\Greentable\\src\\main\\resources\\static\\image\\";

            // 파일 저장
            file.transferTo(new File(uploadPath + imageName));

            // ⭐ DB에는 파일명만 저장
            dto.setQ_img(imageName);
        }

        dao.questionUpdateDao(dto);

        return "redirect:questionlist";
    }



    // 7️ 회원 문의 삭제
    @RequestMapping("/questionDelete")
    public String questionDelete(@RequestParam("q_no") int q_no) {
        dao.questionDeleteDao(q_no);
        return "redirect:/questionlist";
    }
    
    
    
 // 4️ 회원 문의 상세보기
    @RequestMapping("/questionDetail")
    public String questionDetail(@RequestParam("q_no") int q_no, Model model) {
    	questionDTO dto = dao.questionDetailDao(q_no);
        model.addAttribute("dto", dto);
        return "/user/questionDetail"; // 상세보기 JSP로 이동
    }

}









