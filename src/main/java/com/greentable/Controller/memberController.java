package com.greentable.Controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.greentable.DAO.communityDAO;
import com.greentable.DAO.foodDAO;
import com.greentable.DAO.memberDAO;
import com.greentable.DAO.ordersDAO;
import com.greentable.DTO.communityDTO;
import com.greentable.DTO.foodDTO;
import com.greentable.DTO.memberDTO;
import com.greentable.service.EmailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

	@Controller
	public class memberController {
		
	@Autowired
	memberDAO dao;

	@Autowired
	ordersDAO oDao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	// 관리자 인증
	@Value("${admin.code}")
	private String adminCodeValue;

	@Autowired
	private foodDAO fDao; // FoodDAO를 주입받는 부분
	
	@Autowired
    private communityDAO cDao; // [추가] 공지사항/커뮤니티 관련

	// 이메일 인증
	@Autowired
	private EmailService EmailService;

	// [1] 메인 페이지 (리스트 랜덤 셔플 적용)
    @RequestMapping("/main")
    public String main(HttpSession session, Model model) {
    	
    	// 1. 최신 공지사항 가져오기
        communityDTO notice = cDao.getLatestNotice();
        
        // 2. 모델에 담기
        model.addAttribute("mainNotice", notice);
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
            String loginId = auth.getName();
            memberDTO dto = dao.getMemberByIdDao(loginId);
            
            if (dto != null) {
                session.setAttribute("user", dto);
                session.setAttribute("m_no", dto.getM_no());
                session.setAttribute("m_nickname", dto.getM_nickname());
                session.setAttribute("m_image", dto.getM_image());
                session.setAttribute("m_id", dto.getM_id());
                session.setAttribute("cartCount", oDao.getCartCount(dto.getM_no()));
                System.out.println(">>> 로그인 사용자 접속: " + dto.getM_nickname());
            }
        } else {
            System.out.println(">>> 비회원(익명) 사용자 접속");
        }

        // [핵심] 상품 리스트 가져오기 및 랜덤 셔플
        List<foodDTO> proteinList = fDao.flistDao("protein");
        List<foodDTO> dietList = fDao.flistDao("diet");

        // 리스트가 비어있지 않을 때만 섞기
        if (proteinList != null && !proteinList.isEmpty()) {
            Collections.shuffle(proteinList);
        }
        if (dietList != null && !dietList.isEmpty()) {
            Collections.shuffle(dietList);
        }

        model.addAttribute("proteinList", proteinList);
        model.addAttribute("dietList", dietList);
        
        return "user/member/main";
    }

    // [2] 검색 결과 처리
    @RequestMapping("/searchResult")
    public String searchResult(HttpSession session, Authentication authentication, Model model,
                               @RequestParam(value = "searchType", required = false) String searchType,
                               @RequestParam(value = "keyword", required = false) String keyword) {

        List<foodDTO> searchResult = fDao.searchFoodDao(searchType, keyword);
        model.addAttribute("list", searchResult);
        model.addAttribute("keyword", keyword);
        model.addAttribute("searchType", searchType);
        
        return "user/member/searchResult";
    }
   
   //회원 정보 입력
   @RequestMapping("/signup")
      public String writeForm() {
      return "user/member/signup";
   }
   
   // 회원 정보 저장
   @PostMapping("/write")
   public String write(memberDTO dto, HttpServletRequest request, Model model) {
       System.out.println(">>> 1. 컨트롤러 진입 성공!");
       System.out.println(">>> 2. 폼에서 넘어온 데이터 확인: " + dto.toString());

       try {
           // [파일 처리 섹션]
           MultipartFile file = dto.getM_image_file();
           String uploadPath = "C:/upload"; 
           File uploadDir = new File(uploadPath);

           if (!uploadDir.exists()) {
               uploadDir.mkdirs();
           }

           if (file != null && !file.isEmpty()) {
               String filename = file.getOriginalFilename();
               File saveFile = new File(uploadPath, filename);
               file.transferTo(saveFile); // 실제 물리 저장
               dto.setM_image(filename);  // DB에 저장할 파일명 세팅
               System.out.println(">>> 파일 업로드 완료: " + filename);
           } else {
               // 업로드 파일이 없을 경우 기본 이미지 설정
               dto.setM_image("default.png");
           }

           // [비밀번호 암호화]
           if (dto.getM_passwd() != null && !dto.getM_passwd().isEmpty()) {
               dto.setM_passwd(passwordEncoder.encode(dto.getM_passwd()));
           }

           // [권한 설정]
           String inputAdminCode = request.getParameter("adminCode");
           String authority = "USER";
           if (inputAdminCode != null && inputAdminCode.equals(adminCodeValue)) {
               authority = "ADMIN";
           }
           dto.setM_authority(authority);

           // [최종 로그 확인]
           System.out.println(">>> [DB 전송 직전] ID: " + dto.getM_id());
           System.out.println(">>> [DB 전송 직전] 주소: " + dto.getM_addr());
           System.out.println(">>> [DB 전송 직전] 전화번호: " + dto.getM_tel());

           // [DB 인서트 실행]
           dao.SignupDao(dto); 
           System.out.println(">>> [성공] DB 인서트 완료!");

           return "redirect:/main";

       } catch (Exception e) {
           System.err.println(">>> 회원가입 실패!");
           e.printStackTrace();
           model.addAttribute("msg", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
           return "user/member/signup";
       }
   }
 
   // 회원 정보 조회
   @RequestMapping("/alist")
   public String alist(Model model) {
      model.addAttribute("member", dao.listDao());
      return "admin/list";
   }
   
   // 회원 정보 삭제
   @RequestMapping("/adelete")
   public String adelete(HttpServletRequest request){
      int m_no = Integer.parseInt(request.getParameter("m_no"));
      dao.DeleteMemberDao(m_no);
      return "redirect:/alist";
      }
   
   // 회원 정보 수정 폼
   @RequestMapping("/mupdateForm")
   public String mupdateForm(HttpServletRequest request, Model model) {
      int m_no = Integer.parseInt(request.getParameter("m_no"));
      model.addAttribute("update", dao.getMember(m_no));
      return "user/member/updateForm";
   }
   
   
   // 회원정보 수정
   @RequestMapping("/mupdate")
   public String update(HttpServletRequest request,memberDTO dto,@RequestParam("old_passwd")String oldPasswd,@RequestParam("old_addr") String oldAddr) throws Exception {
      
       // 1. DTO에서 업로드된 파일 꺼내기
       MultipartFile file = dto.getM_image_file();

       // 2. 외부 저장 경로 직접 지정 (프로젝트 내부가 아닌 C드라이브)
       String uploadPath = "C:/upload"; 
       File uploadDir = new File(uploadPath);

       // 3. 폴더가 없으면 생성
       if (!uploadDir.exists()) {
           uploadDir.mkdirs();
           System.out.println(">>> 외부 저장소 폴더 생성 완료: " + uploadPath);
       }

       if (file != null && !file.isEmpty()) {
           // 4. 원본 파일명 가져오기
           String filename = file.getOriginalFilename();
           
           // 5. C:/upload/파일명 경로로 저장 준비
           File saveFile = new File(uploadPath, filename);
           
           // 6. 실제 물리적 파일 저장
           file.transferTo(saveFile);

           // 7. DB(m_image 컬럼)에는 파일 이름 문자열만 저장
           dto.setM_image(filename);
           System.out.println(">>> 외부 저장 성공: " + saveFile.getAbsolutePath());
       }   
          
       // 비밀번호 암호화
       // 사용자가 새 비밀번호를 입력했는지 확인
       if (dto.getM_passwd() == null || dto.getM_passwd().equals("")) {
           // 비어있다면 암호화 과정을 거치지 않고 "기존 암호문"을 그대로 세팅
           dto.setM_passwd(oldPasswd);
       } else {
           // 새 비밀번호를 입력했을 때만 암호화(passwordEncoder)를 진행!
           String encPw = passwordEncoder.encode(dto.getM_passwd());
           dto.setM_passwd(encPw);
       }
       
    // 주소 처리 (JS파일에서 합쳐진 m_addr이 비어있다면 기존 주소 유지)
       if (dto.getM_addr() == null || dto.getM_addr().trim().equals("")) {
           dto.setM_addr(oldAddr);
       }
       
       dao.updateDao(dto); // dto에 저장된 값을 updateDao 메서드를 통해 최종적으로 DB에 저장
       
       return "redirect:/myinfo";  // 수정 완료 후 내 정보 보기로 회귀
   }
   
   // 회원 정보 수정 폼 (관리자 페이지)
   @RequestMapping("/adminUpdateForm")
   public String adminUpdateForm(HttpServletRequest request, Model model) {
      int m_no = Integer.parseInt(request.getParameter("m_no"));
      model.addAttribute("adminUpdate", dao.getMember(m_no));
      return "admin/adminUpdateForm";
   }
   
   // 회원정보 수정 (관리자 페이지)
   @RequestMapping("/adminUpdate")
   public String adminUpdate(HttpServletRequest request, memberDTO dto,@RequestParam("old_passwd")String oldPasswd,@RequestParam("old_addr") String oldAddr) throws Exception{
      
       // 1. DTO에서 업로드된 파일 꺼내기
       MultipartFile file = dto.getM_image_file();

       // 2. 외부 저장 경로 직접 지정 (프로젝트 내부가 아닌 C드라이브)
       String uploadPath = "C:/upload"; 
       File uploadDir = new File(uploadPath);

       // 3. 폴더가 없으면 생성
       if (!uploadDir.exists()) {
           uploadDir.mkdirs();
           System.out.println(">>> 외부 저장소 폴더 생성 완료: " + uploadPath);
       }

       if (file != null && !file.isEmpty()) {
           // 4. 원본 파일명 가져오기
           String filename = file.getOriginalFilename();
           
           // 5. C:/upload/파일명 경로로 저장 준비
           File saveFile = new File(uploadPath, filename);
           
           // 6. 실제 물리적 파일 저장
           file.transferTo(saveFile);

           // 7. DB(m_image 컬럼)에는 파일 이름 문자열만 저장
           dto.setM_image(filename);
           System.out.println(">>> 외부 저장 성공: " + saveFile.getAbsolutePath());
       }
       
       // 비밀번호 암호화
       // 사용자가 새 비밀번호를 입력했는지 확인
       if (dto.getM_passwd() == null || dto.getM_passwd().equals("")) {
           // 비어있다면 암호화 과정을 거치지 않고 "기존 암호문"을 그대로 세팅
           dto.setM_passwd(oldPasswd);
       } else {
           // 새 비밀번호를 입력했을 때만 암호화(passwordEncoder)를 진행!
           String encPw = passwordEncoder.encode(dto.getM_passwd());
           dto.setM_passwd(encPw);
       } 
       

       
       // 주소 처리 (JS파일에서 합쳐진 m_addr이 비어있다면 기존 주소 유지)
       if (dto.getM_addr() == null || dto.getM_addr().trim().equals("")) {
           dto.setM_addr(oldAddr);
       }
       
       dao.updateDao(dto); // dto에 저장된 값을 updateDao 메서드를 통해 최종적으로 DB에 저장
       
       return "redirect:/alist";  // 수정 완료 후 내 정보 보기로 회귀
   }
   
   
   //로그인
   @RequestMapping("/login")
   public String loginForm (memberDTO dto, Model model) {
      model.addAttribute("dto", dto);
      return "user/member/login";
   }
   
   @RequestMapping("/accessDenied")
   public String accessDenied() {
       return "error/accessDenied";
   }
   
   // 비밀번호 확인폼 (수정/탈퇴 공용)
   @RequestMapping("/passwordCheckForm")
   // 회원별 비밀 번호 확인을 위해 회원의 고유한 데이터값인 m_no(회원 번호)를 가져오고 회원 정보 수정인지 회원 탈퇴를 할지 (mode)를 결정
   public String passwordCheckForm(HttpServletRequest request,Model model,Authentication authentication,
         HttpServletResponse response) {
      
      int mno = Integer.parseInt(request.getParameter("m_no"));
      // <input name = 'm_no'>에 입력된 값(회원 번호)을 'mno'라는 변수에 저장, xml 파일에 'member_seq.nextval'으로 자동 생성
      String mode = request.getParameter("mode");// <input name = 'mode'>에 입력된 값(update or delete)을 'mode'라는 변수에 저장
      
      model.addAttribute("m_no", mno);
      model.addAttribute("mode", mode);
      //비밀번호 확인폼에는 m_no와 mode값이 넘겨져 있음, view에서 type입에 hidden으로 화면상에 출력되지는 않으면서 데이터값을 가져올 수 있게 해줌
      
      // DB에서 회원 정보 조회
       memberDTO dto = dao.getMember(mno);
      // 카카오 소셜 유저인지 확인 (비밀번호가 OAUTH2_USER인 경우)
       if ("OAUTH2_USER".equals(dto.getM_passwd())) {
           
           if ("update".equals(mode)) {
               // 카카오 유저 수정, 비번확인 과정 무시하고 바로 수정폼 이동
               model.addAttribute("update", dto);
               return "user/member/updateForm";
               
           } else if ("delete".equals(mode)) {
               // 카카오 유저 탈퇴 확인 과정 무시하고 여기서 바로 삭제 처리!
               dao.DeleteMemberDao(mno); // DB 삭제
               
               if (authentication != null) {
                   // 현재 로그인된 세션 강제 로그아웃
                   new SecurityContextLogoutHandler().logout(request, response, authentication);
               }
               // 탈퇴 완료 후 메인으로 리다이렉트
               return "redirect:/main"; 
           }
       }
   
      return "user/member/passwordCheckForm"; // passwordCheckForm 비밀번호 확인 페이지로 회귀
   }
   
   // 비밀번호 확인 처리
   @RequestMapping("/passwordCheck")
   public String passwordCheck(HttpServletRequest request,HttpServletResponse response,
         Authentication authentication,Model model) {
      // 'Authentication authentication'는 로그인한 사람이 누구인지, 어떤 권한을 가졌는지에 대한 정보를 가지고 있는 객체
   
       int m_no = Integer.parseInt(request.getParameter("m_no"));
       // model.addAttribute("m_no", mno);로 가져온 회원번호(m_no)를 'm_no'라는 변수에 저장
       String mode = request.getParameter("mode");
       // model.addAttribute("mode", mode);로 가져온 모드를(mode)를 'mode'라는 변수에 저장
       String m_passwd = request.getParameter("m_passwd"); // 사용자가 입력한 m_passwd값을 'm_passwd'라는 변수에 저장
       memberDTO dto = dao.getMember(m_no); // 'm_no'라는 변수에 저장된 데이터와 DB에 저장된 m_no가 일치하는 회원의 정보를 memberDTO에 저장 
       boolean pwdchk = passwordEncoder.matches(m_passwd,dto.getM_passwd());
       // memberDTO에 저장된 비밀번호를 get으로 끌고온 후 m_passwd에 저장, 암호화된 비밀번호 데이터가 저장된 변수(passwordEncoder)와 비교 후 'pwdchk'라는 변수에 저장
       //일치하면 true, 불일치면 false   
       
       if (pwdchk) { // 만약 비교한 값이 일치한다면
   
           if (mode.equals("update")) { // 'mode' 변수가 update라면
   
               // 수정할 회원 정보를 memberDTO에서 가져오기 
               model.addAttribute("update", dto); 
               
               return "user/member/updateForm";
           }
           else if (mode.equals("delete")) { // 'mode' 변수가 'delete'라면
              
              // DeleteMemberDAO 메서드를 통해 회원 정보 삭제
               dao.DeleteMemberDao(m_no);
               if (authentication != null) { // DeleteMemberDAO 메서드 요청을 한 사용자가 식별이 된다면, authentication != null이라면 = 누구인지 알 수 있다면 
                   new SecurityContextLogoutHandler() 
                      .logout(request, response, authentication); // 강제 로그아웃
               }
               return "redirect:/main"; // 홈으로 회귀
           }
       }
   
       model.addAttribute("msg", "비밀번호가 틀렸습니다."); // if문 이외의 경우(pwdchk)값이 false라면 '비밀번호가 틀렸습니다'라는 문구를 'msg'로 보냄
       model.addAttribute("m_no", m_no); // 페이지를 다시 방문한 회원의 회원 번호를 가져옴 
       model.addAttribute("mode", mode); // 이전에 회원 정보 수정 페이지를 방문했으면 회원 정보 수정 페이지로, 회원 정보 삭제 페이지를 방문했으면 회원 정보 삭제 페이지로
   
       return "user/member/passwordCheckForm"; // 비밀 번호 체크 페이지로 회귀
   }
   
   // 회원 정보 조회
   @RequestMapping("/myinfo")
   public String myinfo(HttpServletRequest request, Model model) {
   
       String loginId = request.getUserPrincipal().getName();  //  현재 로그인한 사용자의 로그인 아이디를 'loginId'라는 변수에 저장
   
       // 로그인한 아이디로 회원 정보 조회
       memberDTO dto = dao.getMemberByIdDao(loginId); // getMemberIdDao 메서드로 가져온 loginId라는 변수를 memberDTO에 저장
       
       model.addAttribute("m_no", dto.getM_no()); // memberDTO에서 m_no를 가져오고
       model.addAttribute("member", dto); // 컨트롤러에 있는 dto 객체를JSP에서 ${member}라는 이름으로 사용할 수 있게 가져옴
   
       return "user/member/myinfo"; // 내 정보 보기로 회귀
   }
   
   // 관리자 인증 번호 확인 폼 (비밀 번호 확인과 같은 동작 방식)
   @RequestMapping("/adminCheckForm")
   public String adminCheckForm(HttpServletRequest request,Model model) {
           
       int m_no = Integer.parseInt(request.getParameter("m_no"));
       String mode = request.getParameter("mode");
       
       model.addAttribute("m_no", m_no);
       model.addAttribute("mode", mode);
       
       return "admin/adminCheckForm";
   }
   
    // 관리자 번호 확인 처리
      @RequestMapping("/adminCheck")
      public String adminCheck(HttpServletRequest request,HttpServletResponse response,Model model) {
   
       String inputAdminCode = request.getParameter("adminCode");
       int m_no = Integer.parseInt(request.getParameter("m_no"));
       String mode = request.getParameter("mode");
       boolean adminchk = adminCodeValue.equals(inputAdminCode);
   
       // 여기서 처음으로 검증
          if (adminchk == true) {
             // 인증 성공
             if ("update".equals(mode)) {
                 memberDTO dto = dao.getMember(m_no);
                 model.addAttribute("adminUpdate", dto);
                 return "admin/adminUpdateForm"; 
             } else if ("delete".equals(mode)) {
                 dao.DeleteMemberDao(m_no);
                 return "redirect:/alist";
             }
          }else {
              model.addAttribute("msg", "관리자 인증키가 틀렸습니다.");
              model.addAttribute("m_no", m_no);
              model.addAttribute("mode", mode);
              return "admin/adminCheckForm";
              
          }
          return "redirect:/alist";
      }
      
      // 아이디 확인
      @ResponseBody // 문자열 그대로 출력 어노테이션
      @GetMapping("/idCheck")
      public String idCheck(@RequestParam("m_id") String m_id) { // 사용자가 m_id값을 입력하고 서버에 요청을 보내면 'm_id'라는 변수에 저장해주세욥
   
          int cnt = dao.idCheck(m_id); 
          // idCheckDAO 메서드(select count(*) from member where m_id = #{m_id})를 실행하여
          // 사용자가 입력한 m_id데이터와 같은 m_id열의 데이터 개수를 'cnt'라는 변수에 저장한다
   
          if (cnt > 0) { // 개수가 0보다 많으면
              return "DUPLICATE";   // 이미 존재
          }
          return "OK";             // 아니면 사용 가능
      }
      
      // 아이디 찾기 폼
      @GetMapping("/findIdForm")
      public String findIdForm() {
         return "user/member/findIdForm";
      }
      
      // 아이디 찾기
      @PostMapping("/findId")
      public String findIdByEmail(@RequestParam("m_email") String m_email, Model model) {

          List<memberDTO> list = dao.findAllByEmail(m_email);

          if (list.isEmpty()) {
              model.addAttribute("msg", "해당 이메일로 가입된 계정이 없습니다.");
              return "user/member/findIdForm";
          }

          //  *** 마스킹 처리 로직
          for (memberDTO m : list) {
              String rawId = m.getM_id();
              // 여기서 바로 마스킹해서 리스트에 다시 세팅
              m.setM_id(rawId.substring(0, 3) + "***"); 
          }

          model.addAttribute("idList", list);
          // JSP의 c:if 조건을 위해 필요한 변수
          model.addAttribute("foundId", true); 

          return "user/member/findIdForm";
      }
      
      // 비밀 번호 재설정
      @RequestMapping("/resetPasswordForm")
      public String resetpasswordForm() {
         return "user/member/resetPasswordForm";
      }
   // 아이디와 이메일 확인
      @PostMapping("/findPwAuth")
      @ResponseBody
      public String findPwAuth(@RequestParam("m_id") String m_id, 
                               @RequestParam("m_email") String email, 
                               HttpSession session) {
          
          // [추가] 전달받은 파라미터 확인용 로그
          System.out.println("비밀번호 찾기 시도 - ID: " + m_id + ", Email: " + email);

          // 아이디로 회원 정보 가져오기
          memberDTO dto = dao.getMemberByIdDao(m_id);

          // 아이디가 있고, 입력한 이메일이 DB의 이메일과 일치하는지 확인
          if (dto != null && dto.getM_email().equals(email)) {
              // 인증번호 발송 (기존에 만든 EmailService 활용)
        	  String authKey = emailService.sendAuthMail(email, "reset");
              
              // 인증 성공 시 비밀번호를 바꿀 대상 아이디를 세션에 저장
              session.setAttribute("resetId", m_id);
              session.setAttribute("authKey", authKey); // 인증번호 비교용
              
              return "success";
          } else {
              // [추가] 실패 원인 파악을 위한 로그
              if(dto == null) {
                  System.out.println("결과: 존재하지 않는 아이디입니다.");
              } else {
                  System.out.println("결과: 아이디는 일치하나 이메일 정보가 다릅니다.");
              }
              return "fail"; // 일치하는 정보 없음 -> JS의 else 문에서 alert를 띄우게 됨
          }
      }
      
      // 비밀번호 재설정
      @PostMapping("/updatePassword")
      @ResponseBody
      public String updatePassword(@RequestParam("m_passwd") String newPw, HttpSession session) {
          // 세션에 저장해둔 '누구의 비번을 바꿀 것인가' 정보 가져오기
          String m_id = (String) session.getAttribute("resetId");
          
          if (m_id != null) {
              // 새 비밀번호 암호화
              String encoded = passwordEncoder.encode(newPw);
              // DB 업데이트
              dao.updatePassword(m_id, encoded);
              
              // 작업 끝났으니 세션 비우기
              session.removeAttribute("resetId");
              session.removeAttribute("authKey");
              
              return "success";
          }
          return "fail";
      }
      
      // 카카오에서 회원 데이터 받아오기
      @GetMapping("/kakao")
      public String kakaoCallback(@AuthenticationPrincipal OAuth2User oAuth2User, HttpSession session) {
          // 카카오로부터 원본 데이터 뭉치 받기
          Map<String, Object> attributes = oAuth2User.getAttributes();
          
          // 계정 정보 및 프로필 정보 꺼내기
          Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
          Map<String, Object> properties = (Map<String, Object>) attributes.get("properties");

          // 카카오 키값을 우리 DB 컬럼명(m_...)으로 매핑해서 추출
          String m_email = (kakaoAccount != null) ? (String) kakaoAccount.get("email") : "";
          // kakaoAccount나 properties가 null인 경우를 대비한 안전한 추출
          String m_image_file = "";
          if (kakaoAccount != null && kakaoAccount.get("profile_image") != null) {
             m_image_file = kakaoAccount.get("profile_image").toString();
          }

          String m_nickname = "";
          if (properties != null && properties.get("nickname") != null) {
              m_nickname = properties.get("nickname").toString();
          }

          // 우리 프로젝트에서 쓸 이름으로 세션에 저장
          session.setAttribute("m_email", m_email);
          session.setAttribute("m_nickname", m_nickname);
          session.setAttribute("m_image_file", m_image_file);
          session.setAttribute("isKakao", true);
          
          // 기존 회원가입 페이지로 이동
          return "redirect:/main";
      }
      
  
      
   // 이메일 인증
      @Autowired
      private EmailService emailService;

      @PostMapping("/mailCheck")
      @ResponseBody // 페이지 이동 없이 데이터만 보냄
      public String mailCheck(@RequestParam("m_email") String email, HttpSession session,@RequestParam("type") String type) {
          // 1. 이메일로 인증번호 발송
    	  String authKey = emailService.sendAuthMail(email, type);
    	  
          
          // 2. 서버 세션에 인증번호 저장 (나중에 사용자가 입력한 값과 비교용)
          session.setAttribute("authKey", authKey);
          // 세션 유지 시간 설정 (예: 3분)
          session.setMaxInactiveInterval(3 * 60); 
          
          return "success"; // 프론트엔드에 성공 알림
      }
      
      @PostMapping("/verifyCode")
      @ResponseBody
      public boolean verifyCode(@RequestParam("code") String code, HttpSession session) {
          String serverCode = (String) session.getAttribute("authKey");
          if (serverCode != null && serverCode.equals(code)) {
              return true; // 인증 성공
          }
          return false; // 인증 실패
      }
      
   }