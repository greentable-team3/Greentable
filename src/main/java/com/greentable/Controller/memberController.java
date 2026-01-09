package com.study.springboot.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.study.springboot.dao.memberDAO;
import com.study.springboot.dto.memberDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

	@Controller
	public class memberController {
	@Autowired
		memberDAO dao;
	
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // 관리자 인증
    @Value("${admin.code}")
    private String adminCodeValue;

	// 첫 화면
	@RequestMapping("/")
		public String root() {
		return "member/main";
	}
	
	//회원 정보 입력
	@RequestMapping("/signup")
		public String writeForm() {
		return "member/signup";
	}
	
	// 회원 정보 저장
	@PostMapping("/write")
		public String write(@ModelAttribute memberDTO dto,HttpServletRequest request,Model model) throws Exception { // 해당 메소드가 예외 처리가 된다면 아래 방법으로 처리해주세욥
	    	MultipartFile file = dto.getM_image_file(); // DTO에서 이미지 파일(m_imge_file)을 꺼내서 'file'변수에 저장, 지금부턴 file이라는 변수가 이미지 파일(임시)
	    	
	    	 // 이미지 파일 처리
	          if (!file.isEmpty()) { //type이 'file'인 입력란에 공백이 없다면
	        	// 해당 입력란에 입력된 이미지 파일을 저장할 경로(폴더)를 'uploadDir' 변수에 저장, images 폴더에 저장
	              Path uploadDir = Paths.get("C:\\Users\\KH\\Desktop\\Teamtproject\\src\\main\\resources\\static\\images");
	              if (!Files.exists(uploadDir)) { // 만약 위의 경로가 존재 하지 않는다면 
	                  Files.createDirectories(uploadDir); // 새로 폴더를 만들어주세욥
	              }

	              String filename = file.getOriginalFilename(); // type이 file인 이미지 파일의 이름을 추출하여 'filename'이라는 변수에 저장
	              Path filePath = uploadDir.resolve(filename); // 'uploadDir' 변수(경로) 뒤에 파일명을 합친 전체 경로를 'filePath'라는 변수에 저장
	              Files.write(filePath, file.getBytes());
	              // 이미지 파일(file 변수)의 크기 데이터를 이미지 파일이 저장된 전체 경로('filePath')에 저장, 그러면 filePath라는 경로에 실제 이미지 파일이 저장
	              dto.setM_image(filename); // dto에는 파일명이 저장된'filename'변수만 저장
	          }
	    	
	    
		    // 비밀번호 암호화
		 	String encodedPassword = passwordEncoder.encode(dto.getM_passwd());
	        // dto에 저장된 비밀번호 데이터(m_passwd)를 get으로 불러오고 암호화한 비밀번호 데이터를 'encodedPassword'라는 데이터에 저장
		 	dto.setM_passwd(encodedPassword); // 암호화된 비밀번호 데이터(encodedPassword)를 dto에 저장
	
		 	// 관리자 코드 입력값 (임시)
		    String inputAdminCode = request.getParameter("adminCode");
		    // application.properties에 저장해놓은 관리자 코드(admin.code = f1234)를 'inputAdninCode'라는 변수에 저장
	
		    // 기본 권한
		    String authority = "USER";
		    // 일반회원(USER)이라는 값을 'authority'라는 변수에 저장
	
		    // 관리자 코드 검증
		    if (inputAdminCode != null && !inputAdminCode.isBlank()) { // 만약 'inputAdminCode'라는 변수가 null값이 아니고 공백도 존재하지 않는다면
		        if (inputAdminCode.equals(adminCodeValue)) { 
		        // 'inputAdnimCode' 변수와 사용자가 입력한 'adminCodeValue'(signup.jsp 파일에 name = 'adminCodeValue')가 같다면
		            authority = "ADMIN"; // 'authority'라는 변수에 관리자(ADMIN)라는 값을 저장
		        } else {
		            model.addAttribute("msg", "관리자 인증 코드가 올바르지 않습니다.");
		            // 그 외의 경우에는 "관리자 인증 코드가 올바르지 않습니다"라는 문구를 "msg"에 넣음
		            return "member/signup"; // 다시 signup.jsp로 돌아가서 insert 막기, 이것을 안 하면 관리자 코드가 일치하지 않더라도 그냥 가입이 됨
		        }
		    }
		    
	
		    // 'authority' 변수에 저장된 데이터(USER인지 ADMIN인지)를 memberDto에 m_authority에 저장
		    dto.setM_authority(authority);
	
		    // dto에 있는 값을 최종적으로 signupDao 메서드를 통해서 DB에 저장
		    dao.SignupDao(dto);
		    
		    // 홈 화면으로 회귀
		    return "redirect:/";
	} 
	
	
	// 회원 정보 조회
	@RequestMapping("/admin/list")
	public String list(Model model) {
		model.addAttribute("member", dao.listDao());
		return "admin/list";
	}
	
	// 회원 정보 삭제
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request){
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		dao.DeleteMemberDao(m_no);
		return "redirect:list";
		}
	
    // 회원 정보 수정 폼
	@RequestMapping("/updateForm")
	public String updateForm(HttpServletRequest request, Model model) {
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		model.addAttribute("update", dao.getMember(m_no));
		return "member/updateForm";
	}

 
	// 회원정보 수정
    @RequestMapping("/update")
    public String update(HttpServletRequest request, memberDTO dto) throws Exception {
    	MultipartFile file = dto.getM_image_file();
    	
   	 // 이미지 파일 처리
         if (!file.isEmpty()) {
             Path uploadDir = Paths.get("C:\\Users\\KH\\Desktop\\Teamtproject\\src\\main\\resources\\static\\images");
             if (!Files.exists(uploadDir)) {
                 Files.createDirectories(uploadDir);
             }

             String filename = file.getOriginalFilename();
             Path filePath = uploadDir.resolve(filename);
             Files.write(filePath, file.getBytes());

             dto.setM_image(filename);
         }
    	
	    // 비밀번호 암호화
	    String encodedPassword = passwordEncoder.encode(dto.getM_passwd()); // memberDto에 저장된 m_passwd를 불러와 암호화한 후 'encodedPassword' 변수에 저장
	    dto.setM_passwd(encodedPassword); // 'encodedPassword' 변수를 memberDto에 m_passwd로 저장
	    
        dao.updateDao(dto); // dto에 저장된 값을 updateDao 메서드를 통해 최종적으로 DB에 저장
        
        return "redirect:myinfo";  // 수정 완료 후 내 정보 보기로 회귀
    }
    
	// 회원정보 수정 (관리자용)
    @RequestMapping("/adminUpdate")
    public String adminUpdate(HttpServletRequest request, memberDTO dto) {
	    
	    // 비밀번호 암호화
	    String encodedPassword = passwordEncoder.encode(dto.getM_passwd());
	    dto.setM_passwd(encodedPassword);
	    
        dao.updateDao(dto); // memberDto에 저장된 모든 값을 updateDao 메서드를 통해 최종적으로 DB에 저장 
        
        return "redirect:/admin/list";  // 수정 완료 후 내 정보 보기로 회귀
    }
    
	
	//로그인
	@RequestMapping("/login")
	public String loginForm (memberDTO dto, Model model) {
		model.addAttribute("dto", dto);
		return "member/login";
	}
	
    @RequestMapping("/accessDenied")
    public String accessDenied() {
        return "error/accessDenied";
    }

	// 비밀번호 확인폼 (수정/탈퇴 공용)
	@RequestMapping("/passwordCheckForm")
	// 회원별 비밀 번호 확인을 위해 회원의 고유한 데이터값인 m_no(회원 번호)를 가져오고 회원 정보 수정인지 회원 탈퇴를 할지 (mode)를 결정
	public String passwordCheckForm(HttpServletRequest request, Model model) {
		int mno = Integer.parseInt(request.getParameter("m_no"));
		// <input name = 'm_no'>에 입력된 값(회원 번호)을 'mno'라는 변수에 저장, xml 파일에 'member_seq.nextval'으로 자동 생성
		String mode = request.getParameter("mode");// <input name = 'mode'>에 입력된 값(update or delete)을 'mode'라는 변수에 저장
		
		model.addAttribute("m_no", mno);
		model.addAttribute("mode", mode);
		//비밀번호 확인폼에는 m_no와 mode값이 넘겨져 있음, view에서 type입에 hidden으로 화면상에 출력되지는 않으면서 데이터값을 가져올 수 있게 해줌
		
		return "member/passwordCheckForm"; // passwordCheckForm 페이지로 회귀
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
	            dto = dao.getMember(m_no); 
	            model.addAttribute("update", dto); 
	            
	            return "member/updateForm";
	        }
	        else if (mode.equals("delete")) { // 'mode' 변수가 'delete'라면
	        	
	        	// DeleteMemberDAO 메서드를 통해 회원 정보 삭제
	            dao.DeleteMemberDao(m_no);
	            if (authentication != null) { // DeleteMemberDAO 메서드 요청을 한 사용자가 식별이 된다면, authentication != null이라면 = 누구인지 알 수 있다면 
	                new SecurityContextLogoutHandler() 
	                	.logout(request, response, authentication); // 강제 로그아웃
	            }
	            return "redirect:/"; // 홈으로 회귀
	        }
	    }

	    model.addAttribute("msg", "비밀번호가 틀렸습니다."); // if문 이외의 경우(pwdchk)값이 false라면 '비밀번호가 틀렸습니다'라는 문구를 'msg'로 보냄
	    model.addAttribute("m_no", m_no); // 페이지를 다시 방문한 회원의 회원 번호를 가져옴 
	    model.addAttribute("mode", mode); // 이전에 회원 정보 수정 페이지를 방문했으면 회원 정보 수정 페이지로, 회원 정보 삭제 페이지를 방문했으면 회원 정보 삭제 페이지로

	    return "member/passwordCheckForm"; // 비밀 번호 체크 페이지로 회귀
	}
	
	// 회원 정보 조회
	@RequestMapping("/myinfo")
	public String myinfo(HttpServletRequest request, Model model) {

	    String loginId = request.getUserPrincipal().getName();  //  현재 로그인한 사용자의 로그인 아이디를 'loginId'라는 변수에 저장

	    // 로그인한 아이디로 회원 정보 조회
	    memberDTO dto = dao.getMemberByIdDao(loginId); // getMemberIdDao 메서드로 가져온 loginId라는 변수를 memberDTO에 저장
	    
	    model.addAttribute("m_no", dto.getM_no()); // memberDTO에서 m_no를 가져오고
	    model.addAttribute("member", dto); // 컨트롤러에 있는 dto 객체를JSP에서 ${member}라는 이름으로 사용할 수 있게 가져옴

	    return "member/myinfo"; // 내 정보 보기로 회귀
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
			        return "redirect:/admin/list";
			    }
		    }else {
		        model.addAttribute("msg", "관리자 인증키가 틀렸습니다.");
		        model.addAttribute("m_no", m_no);
		        model.addAttribute("mode", mode);
		        return "admin/adminCheckForm";
		        
		    }
		    return "redirect:/admin/list";
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
}