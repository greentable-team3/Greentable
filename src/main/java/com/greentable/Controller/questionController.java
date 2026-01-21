package com.greentable.Controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.questionDAO;
import com.greentable.DTO.questionDTO;

import jakarta.servlet.http.HttpSession;

@Controller
public class questionController {

    @Autowired
    private questionDAO dao;
    
    /**
     * 1. 문의 목록 조회
     */
    @RequestMapping(value = "/questionlistform", method = RequestMethod.GET)
    public String questionList(
            @RequestParam(value = "q_category", required = false, defaultValue = "") String q_category,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            Model model) {

        List<questionDTO> list = dao.questionselectlistdao(q_category, keyword);
        model.addAttribute("list", list);
        return "user/question/questionlistform";
    }

    /**
     * 2. 문의 작성 폼 이동
     */
    @RequestMapping(value = "/questionwriteform", method = RequestMethod.GET)
    public String questionWriteForm(HttpSession session) {
        if (session.getAttribute("m_no") == null) {
            return "redirect:/loginform";
        }
        return "user/question/questionwriteform";
    }

    private final String savePath = "C:/upload/"; // 고정 경로 설정
    /**
     * 3. 문의 등록 처리
     */
    @RequestMapping(value = "/questioninsert", method = RequestMethod.POST)
    public String questionInsert(
            questionDTO dto,
            @RequestParam(value = "file", required = false) MultipartFile file,
            HttpSession session) throws Exception {

        Integer mNo = (Integer) session.getAttribute("m_no");
        if (mNo == null) return "redirect:/login";

        dto.setM_no(mNo);

        if (file != null && !file.isEmpty()) {
            try {
                java.io.File folder = new java.io.File(savePath);
                if (!folder.exists()) folder.mkdirs();

                // [변경]: 한글 제거 로직 (확장자 유지)
                String originalName = file.getOriginalFilename();
                String extension = originalName.substring(originalName.lastIndexOf("."));
                String saveName = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + extension;

                file.transferTo(new java.io.File(savePath + saveName));
                dto.setQ_img(saveName);
            } catch (Exception e) { e.printStackTrace(); }
        }
        dao.questioninsertdao(dto);
        return "redirect:/questionlistform";
    }

    /**
     * 4. 문의 상세 보기
     */
    @RequestMapping(value = "/questiondetail", method = RequestMethod.GET)
    public String questionDetail(
            @RequestParam("q_no") int q_no,
            Model model,
            HttpSession session) {

        questionDTO dto = dao.questiondetaildao(q_no);
        
        Integer loginMno = (Integer) session.getAttribute("m_no");
        String loginId = (String) session.getAttribute("m_id");

        if (loginMno == null) return "redirect:/login";

     // [변경 핵심] 본인 여부와 관리자(1번) 여부 판별
        boolean isOwner = (dto.getM_no() == (int)loginMno);
        boolean isAdmin = (loginMno == 1); // 로그인한 번호가 숫자 1이면 관리자!

        if ("Y".equals(dto.getQ_secret())) {
            if (!(isOwner || isAdmin)) {
                model.addAttribute("secretDenied", true);
                return "user/question/questiondetail";
            }
        }

        model.addAttribute("dto", dto);
        model.addAttribute("isOwner", isOwner);
        model.addAttribute("isAdmin", isAdmin);
        return "user/question/questiondetail";
    }
    /**
     * 5. 문의 삭제 (수정됨)
     */
    @RequestMapping(value = "/questiondelete", method = RequestMethod.GET)
    public String questionDelete(@RequestParam("q_no") int q_no, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");
        if (loginMno == null) return "redirect:/login";

        // 1번이면 관리자 삭제 로직 수행
        if (loginMno == 1) {
            dao.adminQuestionDelete(q_no);
        } else {
            dao.questiondeletedao(q_no, loginMno);
        }
        return "redirect:/questionlistform";
    }

    /**
     * 6. 문의 수정 폼 이동 (중복 매핑 에러 해결 부분)
     */
    @RequestMapping(value = "/questionupdateform", method = RequestMethod.GET) // 경로 수정됨
    public String questionUpdateForm(@RequestParam("q_no") int q_no, Model model, HttpSession session) {

        questionDTO dto = dao.questiondetaildao(q_no);
        Integer loginMno = (Integer) session.getAttribute("m_no");
        String loginId = (String) session.getAttribute("m_id");

        if (loginMno == null) return "redirect:/login";

     // [수정 완료] 다른 곳과 똑같이 loginMno == 1 로 통일!
        boolean isOwner = (dto.getM_no() == (int)loginMno);
        boolean isAdmin = (loginMno == 1);

        if (!isOwner && !isAdmin) {
            return "redirect:/questionlistform";
        }

        model.addAttribute("dto", dto);
        return "user/question/questionupdateform";
    }

    /**
     * 7. 문의 수정 처리
     */
    @RequestMapping(value = "/questionupdate", method = RequestMethod.POST)
    public String questionUpdate(
            questionDTO dto,
            @RequestParam(value = "file", required = false) MultipartFile file,
            HttpSession session) throws Exception {

        Integer loginMno = (Integer) session.getAttribute("m_no");
        if (loginMno == null) return "redirect:/login";

     // 기존 데이터 가져오기 (파일 유지를 위함)
        questionDTO post = dao.questiondetaildao(dto.getQ_no());
        dto.setM_no(loginMno);

        if (file != null && !file.isEmpty()) {
            try {
                java.io.File folder = new java.io.File(savePath);
                if (!folder.exists()) folder.mkdirs();

                // [변경]: 수정 시에도 한글 제거 로직 적용
                String originalName = file.getOriginalFilename();
                String extension = originalName.substring(originalName.lastIndexOf("."));
                String saveName = System.currentTimeMillis() + "_" + (int)(Math.random() * 1000) + extension;

                file.transferTo(new java.io.File(savePath + saveName));
                dto.setQ_img(saveName);
            } catch (Exception e) { e.printStackTrace(); }
        } else {
            dto.setQ_img(post.getQ_img());
        }
        dao.questionupdatedao(dto);
        return "redirect:/questiondetail?q_no=" + dto.getQ_no();
    }
    /**
     * 8. [관리자 전용] 통합 관리 페이지 (수정됨)
     */
    @GetMapping("/adminquestionManage")
    public String adminquestionManage(Model model, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");

        // 1번이 아니면 아예 진입 불가
        if (loginMno == null || loginMno != 1) {
            return "redirect:/main"; 
        }

        List<questionDTO> list = dao.questionselectlistdao("", ""); 
        model.addAttribute("questionlist", list);
        return "admin/questionManage";
    }
    /**
     * 9. [관리자 전용] 답변 등록 처리 (수정됨)
     */
    @RequestMapping(value = "/questionreply", method = RequestMethod.POST)
    public String adminQuestionReply(@RequestParam("q_no") int q_no, @RequestParam("q_answer") String q_answer, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");

        if (loginMno == null || loginMno != 1) {
            return "redirect:/main";
        }

        dao.updateAnswer(q_no, q_answer);
        return "redirect:/adminquestionManage";
    }

    /**
     * 10. [관리자 전용] 삭제 액션 (수정됨)
     */
    @RequestMapping(value = "/adminquestionDelete", method = RequestMethod.GET)
    public String adminQuestionDeleteAction(@RequestParam("q_no") int q_no, HttpSession session) {
        Integer loginMno = (Integer) session.getAttribute("m_no");

        if (loginMno == null || loginMno != 1) {
            return "redirect:/main";
        }

        dao.adminQuestionDelete(q_no);
        return "redirect:/adminquestionManage";
    }
}