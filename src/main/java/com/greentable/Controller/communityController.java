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

import com.greentable.DAO.communityDAO;
import com.greentable.DTO.communityDTO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class communityController {

    @Autowired
    private communityDAO dao;
    
    //1 글쓰기 폼 이동
    @RequestMapping("/communitywriteform")
    public String writeForm() {
        return "/user/communitywriteform";
    }
    
    // 2 커뮤니티 목록
    @RequestMapping("/communitylist")
    public String communityList(Model model) {
        List<communityDTO> list = dao.communitylistDao();
        model.addAttribute("list", list);
        return "/user/communitylist";
    }

 

 //글쓰기 (파일 업로드)처리
    @RequestMapping("/communitywrite")
    public String communitywrite(communityDTO dto,HttpServletRequest request) throws Exception { // 해당 메소드가 예외 처리가 된다면 아래 방법으로 처리해주세욥
        MultipartFile file = dto.getCimage(); // DTO에서 이미지 파일(cimage)을 꺼내서 'file'변수에 저장, 지금부턴 file이라는 변수가 이미지 파일(임시)
        
         // 이미지 파일 처리
           if (!file.isEmpty()) { //type이 'file'인 입력란에 공백이 없다면
            // 해당 입력란에 입력된 이미지 파일을 저장할 경로(폴더)를 'uploadDir' 변수에 저장, images 폴더에 저장
               Path uploadDir = Paths.get("C:\\Greentable\\src\\main\\resources\\static\\image");
               if (!Files.exists(uploadDir)) { // 만약 위의 경로가 존재 하지 않는다면 
                   Files.createDirectories(uploadDir); // 새로 폴더를 만들어줍니다
               }
               String filename = file.getOriginalFilename();
               Path filePath = uploadDir.resolve(filename);
               Files.write(filePath, file.getBytes());

               dto.setC_img(filename);
           }
           
           
           dao.communityinsertDao(dto);
           return "redirect:/communitylist";
    }

  
 //수정   
    @RequestMapping("/communityUpdateform")
    public String communityUpdate(@RequestParam("c_no") int c_no, Model model) {
        communityDTO dto = dao.communityDetailDao(c_no);
        model.addAttribute("dto", dto);
        return "/user/communityUpdateform";
    }
    
 // 6️ 수정 처리
    @RequestMapping("/communityUpdate")
    public String communityupdate(communityDTO dto) throws Exception {

        MultipartFile file = dto.getCimage();

        if (file != null && !file.isEmpty()) {

            String imageName = file.getOriginalFilename();

            String uploadPath =
                "C:\\Greentable\\src\\main\\resources\\static\\image\\";

            // 파일 저장
            file.transferTo(new File(uploadPath + imageName));

            // ⭐ DB에는 파일명만 저장
            dto.setC_img(imageName);
        }

        dao.communityUpdateDao(dto);

        return "redirect:communitylist";
    }



    // 7️ 삭제
    @RequestMapping("/communityDelete")
    public String communityDelete(@RequestParam("c_no") int c_no) {
        dao.communityDeleteDao(c_no);
        return "redirect:/communitylist";
    }
    
    
    
 // 4️ 상세보기
    @RequestMapping("/communityDetail")
    public String communityDetail(@RequestParam("c_no") int c_no, Model model) {
        communityDTO dto = dao.communityDetailDao(c_no);
        model.addAttribute("dto", dto);
        return "/user/communityDetail"; // 상세보기 JSP로 이동
    }

}









