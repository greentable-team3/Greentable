package com.greentable.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.communityDAO;
import com.greentable.DTO.communityDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class communityController {

    @Autowired
    private communityDAO dao;

    // 1. 커뮤니티 리스트
    @GetMapping("/communitylistform")
    public String communitylistform(
            @RequestParam(value="c_category", required=false, defaultValue="") String c_category,
            @RequestParam(value="keyword", required=false, defaultValue="") String keyword,
            HttpSession session, 
            Model model) {
        
        // [변경]: m_no가 1이면 관리자로 판단
        Integer loginMno = (Integer) session.getAttribute("m_no");
        model.addAttribute("isAdmin", loginMno != null && loginMno == 1);
        
        List<communityDTO> list = dao.communitylistdao(c_category, keyword);
        model.addAttribute("list", list);
        return "user/community/communitylistform"; 
    }
    
    private final String savePath = "C:/upload/";
    
 // [4. 새 글 등록 전용]
    @PostMapping("/communitywrite")
    public String communitywrite(communityDTO dto, 
                                 @RequestParam(value="file", required=false) MultipartFile file,
                                 HttpSession session) {
        Object mNoObj = session.getAttribute("m_no");
        if (mNoObj == null) return "redirect:/login";
        dto.setM_no((int) mNoObj);

        if (file != null && !file.isEmpty()) {
            try {
                java.io.File folder = new java.io.File(savePath);
                if (!folder.exists()) folder.mkdirs();

                // [변경]: 확장자 추출 및 랜덤 파일명 생성
                String originalName = file.getOriginalFilename();
                String extension = originalName.substring(originalName.lastIndexOf("."));
                String saveName = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + extension;
                
                file.transferTo(new java.io.File(savePath + saveName));
                dto.setC_img(saveName); // 안전한 파일명 저장
            } catch (Exception e) { e.printStackTrace(); }
        }
        dao.communityinsertDao(dto);
        return "redirect:/communitylistform";
    }

    // [7-1. 기존 글 수정 전용]
    @PostMapping("/communityupdate")
    public String communityupdate(communityDTO dto, HttpSession session) {
        // 기존 데이터를 가져와서 사진 유지 로직 처리
        communityDTO post = dao.communitydetailDao(dto.getC_no());
        MultipartFile uploadFile = dto.getFile();
        
        if (uploadFile != null && !uploadFile.isEmpty()) {
            try {
                java.io.File folder = new java.io.File(savePath);
                if (!folder.exists()) folder.mkdirs();

                // [변경]: 수정 시에도 안전한 파일명 적용
                String originalName = uploadFile.getOriginalFilename();
                String extension = originalName.substring(originalName.lastIndexOf("."));
                String saveName = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + extension;
                
                uploadFile.transferTo(new java.io.File(savePath + saveName));
                dto.setC_img(saveName);
            } catch (Exception e) { e.printStackTrace(); }
        } else {
            dto.setC_img(post.getC_img());
        }
        dao.communityupdateDao(dto);
        return "redirect:/communitydetail?c_no=" + dto.getC_no();
    }
   
    // 2. 글쓰기 페이지 이동
    @RequestMapping("/communitywriteform")
    public String communitywriteform(HttpSession session) {
        return "user/community/communitywriteform";
    }
    
    

    // 3. 상세보기
    @RequestMapping("/communitydetail")
    public String communitydetail(@RequestParam("c_no") int c_no, Model model) {
        model.addAttribute("dto", dao.communitydetailDao(c_no));
        model.addAttribute("comments", dao.communityListDao(c_no));
        return "user/community/communitydetail";
    }

    // 5. 좋아요 (비동기)
    @PostMapping("/communityupdateLove")
    @ResponseBody
    public int communityupdateLove(@RequestParam("c_no") int c_no) {
        dao.communityupdateLoveDao(c_no);
        return dao.communityLoveDao(c_no);
    }

    // 6. 댓글 작성 (비동기)
    @PostMapping("/commentWrite")
    @ResponseBody
    public String commentWrite(communityDTO dto, HttpSession session) {
        Object mNoObj = session.getAttribute("m_no");
        if (mNoObj == null) return "fail";
        dto.setM_no((int) mNoObj); 
        int result = dao.commentWriteDao(dto); 
        return (result > 0) ? "success" : "fail";
    }

    // 7. 수정 폼 이동
    @RequestMapping("/communityupdateform")
    public String communityupdateform(@RequestParam("c_no") int c_no, Model model, HttpSession session) {
        communityDTO dto = dao.communitydetailDao(c_no);
        model.addAttribute("dto", dto);
        return "user/community/communityupdateform";
    }

    // 8. 댓글 삭제 (비동기)
    @RequestMapping("/commentdelete")
    @ResponseBody 
    public String commentDelete(@RequestParam("c_commentNo") int c_commentNo) {
        int result = dao.commentDeleteDao(c_commentNo);
        return (result > 0) ? "success" : "fail";
    } 

 // 9. 게시글 삭제
    @RequestMapping("/communitydelete")
    public String communitydelete(@RequestParam("c_no") int c_no, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");
        if (loginMno == null) return "redirect:/login";

        communityDTO post = dao.communitydetailDao(c_no);
        
        // [변경]: 1번 유저면 무조건 삭제 가능
        boolean isOwner = (post.getM_no() == (int)loginMno);
        boolean isAdmin = (loginMno == 1); 

        if (isOwner || isAdmin) {
            dao.commentDeleteByPostDao(c_no);
            dao.communityDeleteDao(c_no);
            // 관리자가 삭제했다면 다시 관리 목록으로, 유저가 삭제했다면 게시판 목록으로
            return isAdmin ? "redirect:/admincommunityList" : "redirect:/communitylistform";
        } else {
            return "redirect:/communitylistform";
        }
    }
 // 10. 관리자 기능 (관리자 페이지 접근)
    @RequestMapping("/admincommunityList")
    public String adminCommunityList(Model model, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");
        
        // [변경]: 1번이 아니면 접근 거부
        if (loginMno == null || loginMno != 1) {
            return "redirect:/main";
        }
        
        model.addAttribute("list", dao.communitylistdao("", ""));  
        model.addAttribute("allComments", dao.allCommentListDao());    
        
        return "admin/adminCommunityList";
    }

    // 관리자 게시글 비동기 삭제
    @GetMapping(value = "/adminCommunitydelete", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String adminCommunityDelete(@RequestParam("c_no") int c_no, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");
        
        // [변경]: 1번 유저 확인
        if (loginMno != null && loginMno == 1) {
            dao.commentDeleteByPostDao(c_no);
            dao.communityDeleteDao(c_no);
            return "success";
        }
        return "fail";
    }

    // 관리자 댓글 비동기 삭제
    @GetMapping(value = "/adminCommentdelete", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String adminCommentDelete(@RequestParam("c_commentNo") int c_commentNo, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");
        
        // [변경]: 1번 유저 확인
        if (loginMno != null && loginMno == 1) {
            dao.commentDeleteDao(c_commentNo);
            return "success";
        }
        return "fail";
    }
}