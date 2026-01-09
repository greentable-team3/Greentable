package com.greentable.Controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

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

import com.greentable.DAO.memberDAO;
import com.greentable.DTO.memberDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
	public class memberController {
	@Autowired
		memberDAO dao;
	
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    // 愿�由ъ옄 �씤利�
    @Value("${admin.code}")
    private String adminCodeValue;

	// 泥� �솕硫�
	@RequestMapping("/")
		public String root() {
		return "user/member/main";
	}
	
	//�쉶�썝 �젙蹂� �엯�젰
	@RequestMapping("/signup")
		public String writeForm() {
		return "user/member/signup";
	}
	
	@GetMapping("/findIdForm")
	public String findIdForm() {
		return "user/member/findIdForm";
	}
	
	// �쉶�썝 �젙蹂� ���옣
	@PostMapping("/write")
		public String write(@ModelAttribute memberDTO dto,HttpServletRequest request,Model model) throws Exception { // �빐�떦 硫붿냼�뱶媛� �삁�쇅 泥섎━媛� �맂�떎硫� �븘�옒 諛⑸쾿�쑝濡� 泥섎━�빐二쇱꽭�슖
	    	MultipartFile file = dto.getM_image_file(); // DTO�뿉�꽌 �씠誘몄� �뙆�씪(m_imge_file)�쓣 爰쇰궡�꽌 'file'蹂��닔�뿉 ���옣, 吏�湲덈��꽩 file�씠�씪�뒗 蹂��닔媛� �씠誘몄� �뙆�씪(�엫�떆)
	    	
	    	 // �씠誘몄� �뙆�씪 泥섎━
	          if (!file.isEmpty()) { //type�씠 'file'�씤 �엯�젰���뿉 怨듬갚�씠 �뾾�떎硫�
	        	// �빐�떦 �엯�젰���뿉 �엯�젰�맂 �씠誘몄� �뙆�씪�쓣 ���옣�븷 寃쎈줈(�뤃�뜑)瑜� 'uploadDir' 蹂��닔�뿉 ���옣, images �뤃�뜑�뿉 ���옣
	              Path uploadDir = Paths.get("C:\\Users\\KH\\Desktop\\Teamtproject\\src\\main\\resources\\static\\images");
	              if (!Files.exists(uploadDir)) { // 留뚯빟 �쐞�쓽 寃쎈줈媛� 議댁옱 �븯吏� �븡�뒗�떎硫� 
	                  Files.createDirectories(uploadDir); // �깉濡� �뤃�뜑瑜� 留뚮뱾�뼱二쇱꽭�슖
	              }

	              String filename = file.getOriginalFilename(); // type�씠 file�씤 �씠誘몄� �뙆�씪�쓽 �씠由꾩쓣 異붿텧�븯�뿬 'filename'�씠�씪�뒗 蹂��닔�뿉 ���옣
	              Path filePath = uploadDir.resolve(filename); // 'uploadDir' 蹂��닔(寃쎈줈) �뮘�뿉 �뙆�씪紐낆쓣 �빀移� �쟾泥� 寃쎈줈瑜� 'filePath'�씪�뒗 蹂��닔�뿉 ���옣
	              Files.write(filePath, file.getBytes());
	              // �씠誘몄� �뙆�씪(file 蹂��닔)�쓽 �겕湲� �뜲�씠�꽣瑜� �씠誘몄� �뙆�씪�씠 ���옣�맂 �쟾泥� 寃쎈줈('filePath')�뿉 ���옣, 洹몃윭硫� filePath�씪�뒗 寃쎈줈�뿉 �떎�젣 �씠誘몄� �뙆�씪�씠 ���옣
	              dto.setM_image(filename); // dto�뿉�뒗 �뙆�씪紐낆씠 ���옣�맂'filename'蹂��닔留� ���옣
	          }
	    	
	    
		    // 鍮꾨�踰덊샇 �븫�샇�솕
		 	String encodedPassword = passwordEncoder.encode(dto.getM_passwd());
	        // dto�뿉 ���옣�맂 鍮꾨�踰덊샇 �뜲�씠�꽣(m_passwd)瑜� get�쑝濡� 遺덈윭�삤怨� �븫�샇�솕�븳 鍮꾨�踰덊샇 �뜲�씠�꽣瑜� 'encodedPassword'�씪�뒗 �뜲�씠�꽣�뿉 ���옣
		 	dto.setM_passwd(encodedPassword); // �븫�샇�솕�맂 鍮꾨�踰덊샇 �뜲�씠�꽣(encodedPassword)瑜� dto�뿉 ���옣
	
		 	// 愿�由ъ옄 肄붾뱶 �엯�젰媛� (�엫�떆)
		    String inputAdminCode = request.getParameter("adminCode");
		    // application.properties�뿉 ���옣�빐�넃�� 愿�由ъ옄 肄붾뱶(admin.code = f1234)瑜� 'inputAdninCode'�씪�뒗 蹂��닔�뿉 ���옣
	
		    // 湲곕낯 沅뚰븳
		    String authority = "USER";
		    // �씪諛섑쉶�썝(USER)�씠�씪�뒗 媛믪쓣 'authority'�씪�뒗 蹂��닔�뿉 ���옣
	
		    // 愿�由ъ옄 肄붾뱶 寃�利�
		    if (inputAdminCode != null && !inputAdminCode.isBlank()) { // 留뚯빟 'inputAdminCode'�씪�뒗 蹂��닔媛� null媛믪씠 �븘�땲怨� 怨듬갚�룄 議댁옱�븯吏� �븡�뒗�떎硫�
		        if (inputAdminCode.equals(adminCodeValue)) { 
		        // 'inputAdnimCode' 蹂��닔�� �궗�슜�옄媛� �엯�젰�븳 'adminCodeValue'(signup.jsp �뙆�씪�뿉 name = 'adminCodeValue')媛� 媛숇떎硫�
		            authority = "ADMIN"; // 'authority'�씪�뒗 蹂��닔�뿉 愿�由ъ옄(ADMIN)�씪�뒗 媛믪쓣 ���옣
		        } else {
		            model.addAttribute("msg", "愿�由ъ옄 �씤利� 肄붾뱶媛� �삱諛붾Ⅴ吏� �븡�뒿�땲�떎.");
		            // 洹� �쇅�쓽 寃쎌슦�뿉�뒗 "愿�由ъ옄 �씤利� 肄붾뱶媛� �삱諛붾Ⅴ吏� �븡�뒿�땲�떎"�씪�뒗 臾멸뎄瑜� "msg"�뿉 �꽔�쓬
		            return "user/member/signup"; // �떎�떆 signup.jsp濡� �룎�븘媛��꽌 insert 留됯린, �씠寃껋쓣 �븞 �븯硫� 愿�由ъ옄 肄붾뱶媛� �씪移섑븯吏� �븡�뜑�씪�룄 洹몃깷 媛��엯�씠 �맖
		        }
		    }
		    
	
		    // 'authority' 蹂��닔�뿉 ���옣�맂 �뜲�씠�꽣(USER�씤吏� ADMIN�씤吏�)瑜� memberDto�뿉 m_authority�뿉 ���옣
		    dto.setM_authority(authority);
	
		    // dto�뿉 �엳�뒗 媛믪쓣 理쒖쥌�쟻�쑝濡� signupDao 硫붿꽌�뱶瑜� �넻�빐�꽌 DB�뿉 ���옣
		    dao.SignupDao(dto);
		    
		    // �솃 �솕硫댁쑝濡� �쉶洹�
		    return "redirect:/";
	} 
	
	
	// �쉶�썝 �젙蹂� 議고쉶
	@RequestMapping("/admin/list")
	public String list(Model model) {
		model.addAttribute("member", dao.listDao());
		return "admin/list";
	}
	
	// �쉶�썝 �젙蹂� �궘�젣
	@RequestMapping("/delete")
	public String delete(HttpServletRequest request){
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		dao.DeleteMemberDao(m_no);
		return "redirect:list";
		}
	
    // �쉶�썝 �젙蹂� �닔�젙 �뤌
	@RequestMapping("/updateForm")
	public String updateForm(HttpServletRequest request, Model model) {
		int m_no = Integer.parseInt(request.getParameter("m_no"));
		model.addAttribute("update", dao.getMember(m_no));
		return "user/member/updateForm";
	}
	

 
	// �쉶�썝�젙蹂� �닔�젙
    @RequestMapping("/update")
    public String update(HttpServletRequest request, memberDTO dto) throws Exception {
    	MultipartFile file = dto.getM_image_file();
    	
   	 // �씠誘몄� �뙆�씪 泥섎━
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
    	
	    // 鍮꾨�踰덊샇 �븫�샇�솕
	    String encodedPassword = passwordEncoder.encode(dto.getM_passwd()); // memberDto�뿉 ���옣�맂 m_passwd瑜� 遺덈윭�� �븫�샇�솕�븳 �썑 'encodedPassword' 蹂��닔�뿉 ���옣
	    dto.setM_passwd(encodedPassword); // 'encodedPassword' 蹂��닔瑜� memberDto�뿉 m_passwd濡� ���옣
	    
        dao.updateDao(dto); // dto�뿉 ���옣�맂 媛믪쓣 updateDao 硫붿꽌�뱶瑜� �넻�빐 理쒖쥌�쟻�쑝濡� DB�뿉 ���옣
        
        return "redirect:myinfo";  // �닔�젙 �셿猷� �썑 �궡 �젙蹂� 蹂닿린濡� �쉶洹�
    }
    
	// �쉶�썝�젙蹂� �닔�젙 (愿�由ъ옄�슜)
    @RequestMapping("/adminUpdate")
    public String adminUpdate(HttpServletRequest request, memberDTO dto) {
	    
	    // 鍮꾨�踰덊샇 �븫�샇�솕
	    String encodedPassword = passwordEncoder.encode(dto.getM_passwd());
	    dto.setM_passwd(encodedPassword);
	    
        dao.updateDao(dto); // memberDto�뿉 ���옣�맂 紐⑤뱺 媛믪쓣 updateDao 硫붿꽌�뱶瑜� �넻�빐 理쒖쥌�쟻�쑝濡� DB�뿉 ���옣 
        
        return "redirect:/admin/list";  // �닔�젙 �셿猷� �썑 �궡 �젙蹂� 蹂닿린濡� �쉶洹�
    }
    
	
	//濡쒓렇�씤
	@RequestMapping("/login")
	public String loginForm (memberDTO dto, Model model) {
		model.addAttribute("dto", dto);
		return "user/member/login";
	}
	
    @RequestMapping("/accessDenied")
    public String accessDenied() {
        return "error/accessDenied";
    }

	// 鍮꾨�踰덊샇 �솗�씤�뤌 (�닔�젙/�깉�눜 怨듭슜)
	@RequestMapping("/passwordCheckForm")
	// �쉶�썝蹂� 鍮꾨� 踰덊샇 �솗�씤�쓣 �쐞�빐 �쉶�썝�쓽 怨좎쑀�븳 �뜲�씠�꽣媛믪씤 m_no(�쉶�썝 踰덊샇)瑜� 媛��졇�삤怨� �쉶�썝 �젙蹂� �닔�젙�씤吏� �쉶�썝 �깉�눜瑜� �븷吏� (mode)瑜� 寃곗젙
	public String passwordCheckForm(HttpServletRequest request, Model model) {
		int mno = Integer.parseInt(request.getParameter("m_no"));
		// <input name = 'm_no'>�뿉 �엯�젰�맂 媛�(�쉶�썝 踰덊샇)�쓣 'mno'�씪�뒗 蹂��닔�뿉 ���옣, xml �뙆�씪�뿉 'member_seq.nextval'�쑝濡� �옄�룞 �깮�꽦
		String mode = request.getParameter("mode");// <input name = 'mode'>�뿉 �엯�젰�맂 媛�(update or delete)�쓣 'mode'�씪�뒗 蹂��닔�뿉 ���옣
		
		model.addAttribute("m_no", mno);
		model.addAttribute("mode", mode);
		//鍮꾨�踰덊샇 �솗�씤�뤌�뿉�뒗 m_no�� mode媛믪씠 �꽆寃⑥졇 �엳�쓬, view�뿉�꽌 type�엯�뿉 hidden�쑝濡� �솕硫댁긽�뿉 異쒕젰�릺吏��뒗 �븡�쑝硫댁꽌 �뜲�씠�꽣媛믪쓣 媛��졇�삱 �닔 �엳寃� �빐以�
		
		return "user/member/passwordCheckForm"; // passwordCheckForm �럹�씠吏�濡� �쉶洹�
	}
	
	// 鍮꾨�踰덊샇 �솗�씤 泥섎━
	@RequestMapping("/passwordCheck")
	public String passwordCheck(HttpServletRequest request,HttpServletResponse response,
			Authentication authentication,Model model) {
		// 'Authentication authentication'�뒗 濡쒓렇�씤�븳 �궗�엺�씠 �늻援ъ씤吏�, �뼱�뼡 沅뚰븳�쓣 媛�議뚮뒗吏��뿉 ���븳 �젙蹂대�� 媛�吏�怨� �엳�뒗 媛앹껜

	    int m_no = Integer.parseInt(request.getParameter("m_no"));
	    // model.addAttribute("m_no", mno);濡� 媛��졇�삩 �쉶�썝踰덊샇(m_no)瑜� 'm_no'�씪�뒗 蹂��닔�뿉 ���옣
	    String mode = request.getParameter("mode");
	    // model.addAttribute("mode", mode);濡� 媛��졇�삩 紐⑤뱶瑜�(mode)瑜� 'mode'�씪�뒗 蹂��닔�뿉 ���옣
	    String m_passwd = request.getParameter("m_passwd"); // �궗�슜�옄媛� �엯�젰�븳 m_passwd媛믪쓣 'm_passwd'�씪�뒗 蹂��닔�뿉 ���옣
	    memberDTO dto = dao.getMember(m_no); // 'm_no'�씪�뒗 蹂��닔�뿉 ���옣�맂 �뜲�씠�꽣�� DB�뿉 ���옣�맂 m_no媛� �씪移섑븯�뒗 �쉶�썝�쓽 �젙蹂대�� memberDTO�뿉 ���옣 
	    boolean pwdchk = passwordEncoder.matches(m_passwd,dto.getM_passwd());
	    // memberDTO�뿉 ���옣�맂 鍮꾨�踰덊샇瑜� get�쑝濡� �걣怨좎삩 �썑 m_passwd�뿉 ���옣, �븫�샇�솕�맂 鍮꾨�踰덊샇 �뜲�씠�꽣媛� ���옣�맂 蹂��닔(passwordEncoder)�� 鍮꾧탳 �썑 'pwdchk'�씪�뒗 蹂��닔�뿉 ���옣
	    //�씪移섑븯硫� true, 遺덉씪移섎㈃ false   
	    
	    if (pwdchk) { // 留뚯빟 鍮꾧탳�븳 媛믪씠 �씪移섑븳�떎硫�

	        if (mode.equals("update")) { // 'mode' 蹂��닔媛� update�씪硫�

	            // �닔�젙�븷 �쉶�썝 �젙蹂대�� memberDTO�뿉�꽌 媛��졇�삤湲�
	            dto = dao.getMember(m_no); 
	            model.addAttribute("update", dto); 
	            
	            return "user/member/updateForm";
	        }
	        else if (mode.equals("delete")) { // 'mode' 蹂��닔媛� 'delete'�씪硫�
	        	
	        	// DeleteMemberDAO 硫붿꽌�뱶瑜� �넻�빐 �쉶�썝 �젙蹂� �궘�젣
	            dao.DeleteMemberDao(m_no);
	            if (authentication != null) { // DeleteMemberDAO 硫붿꽌�뱶 �슂泥��쓣 �븳 �궗�슜�옄媛� �떇蹂꾩씠 �맂�떎硫�, authentication != null�씠�씪硫� = �늻援ъ씤吏� �븣 �닔 �엳�떎硫� 
	                new SecurityContextLogoutHandler() 
	                	.logout(request, response, authentication); // 媛뺤젣 濡쒓렇�븘�썐
	            }
	            return "redirect:/"; // �솃�쑝濡� �쉶洹�
	        }
	    }

	    model.addAttribute("msg", "鍮꾨�踰덊샇媛� ���졇�뒿�땲�떎."); // if臾� �씠�쇅�쓽 寃쎌슦(pwdchk)媛믪씠 false�씪硫� '鍮꾨�踰덊샇媛� ���졇�뒿�땲�떎'�씪�뒗 臾멸뎄瑜� 'msg'濡� 蹂대깂
	    model.addAttribute("m_no", m_no); // �럹�씠吏�瑜� �떎�떆 諛⑸Ц�븳 �쉶�썝�쓽 �쉶�썝 踰덊샇瑜� 媛��졇�샂 
	    model.addAttribute("mode", mode); // �씠�쟾�뿉 �쉶�썝 �젙蹂� �닔�젙 �럹�씠吏�瑜� 諛⑸Ц�뻽�쑝硫� �쉶�썝 �젙蹂� �닔�젙 �럹�씠吏�濡�, �쉶�썝 �젙蹂� �궘�젣 �럹�씠吏�瑜� 諛⑸Ц�뻽�쑝硫� �쉶�썝 �젙蹂� �궘�젣 �럹�씠吏�濡�

	    return "user/member/passwordCheckForm"; // 鍮꾨� 踰덊샇 泥댄겕 �럹�씠吏�濡� �쉶洹�
	}
	
	// �쉶�썝 �젙蹂� 議고쉶
	@RequestMapping("/myinfo")
	public String myinfo(HttpServletRequest request, Model model) {

	    String loginId = request.getUserPrincipal().getName();  //  �쁽�옱 濡쒓렇�씤�븳 �궗�슜�옄�쓽 濡쒓렇�씤 �븘�씠�뵒瑜� 'loginId'�씪�뒗 蹂��닔�뿉 ���옣

	    // 濡쒓렇�씤�븳 �븘�씠�뵒濡� �쉶�썝 �젙蹂� 議고쉶
	    memberDTO dto = dao.getMemberByIdDao(loginId); // getMemberIdDao 硫붿꽌�뱶濡� 媛��졇�삩 loginId�씪�뒗 蹂��닔瑜� memberDTO�뿉 ���옣
	    
	    model.addAttribute("m_no", dto.getM_no()); // memberDTO�뿉�꽌 m_no瑜� 媛��졇�삤怨�
	    model.addAttribute("member", dto); // 而⑦듃濡ㅻ윭�뿉 �엳�뒗 dto 媛앹껜瑜퍳SP�뿉�꽌 ${member}�씪�뒗 �씠由꾩쑝濡� �궗�슜�븷 �닔 �엳寃� 媛��졇�샂

	    return "user/member/myinfo"; // �궡 �젙蹂� 蹂닿린濡� �쉶洹�
	}
	
	// 愿�由ъ옄 �씤利� 踰덊샇 �솗�씤 �뤌 (鍮꾨� 踰덊샇 �솗�씤怨� 媛숈� �룞�옉 諛⑹떇)
	@RequestMapping("/adminCheckForm")
	public String adminCheckForm(HttpServletRequest request,Model model) {
	        
	    int m_no = Integer.parseInt(request.getParameter("m_no"));
	    String mode = request.getParameter("mode");
	    
	    model.addAttribute("m_no", m_no);
		model.addAttribute("mode", mode);
	    
	    return "admin/adminCheckForm";
	}
	
	 // 愿�由ъ옄 踰덊샇 �솗�씤 泥섎━
		@RequestMapping("/adminCheck")
		public String adminCheck(HttpServletRequest request,HttpServletResponse response,Model model) {

	    String inputAdminCode = request.getParameter("adminCode");
	    int m_no = Integer.parseInt(request.getParameter("m_no"));
	    String mode = request.getParameter("mode");
	    boolean adminchk = adminCodeValue.equals(inputAdminCode);

	    // �뿬湲곗꽌 泥섏쓬�쑝濡� 寃�利�
		    if (adminchk == true) {
			    // �씤利� �꽦怨�
			    if ("update".equals(mode)) {
			        memberDTO dto = dao.getMember(m_no);
			        model.addAttribute("adminUpdate", dto);
			        return "admin/adminUpdateForm"; 
			    } else if ("delete".equals(mode)) {
			        dao.DeleteMemberDao(m_no);
			        return "redirect:/admin/list";
			    }
		    }else {
		        model.addAttribute("msg", "愿�由ъ옄 �씤利앺궎媛� ���졇�뒿�땲�떎.");
		        model.addAttribute("m_no", m_no);
		        model.addAttribute("mode", mode);
		        return "admin/adminCheckForm";
		        
		    }
		    return "redirect:/admin/list";
		}
		
		// �븘�씠�뵒 �솗�씤
		@ResponseBody // 臾몄옄�뿴 洹몃�濡� 異쒕젰 �뼱�끂�뀒�씠�뀡
		@GetMapping("/idCheck")
		public String idCheck(@RequestParam("m_id") String m_id) { // �궗�슜�옄媛� m_id媛믪쓣 �엯�젰�븯怨� �꽌踰꾩뿉 �슂泥��쓣 蹂대궡硫� 'm_id'�씪�뒗 蹂��닔�뿉 ���옣�빐二쇱꽭�슖

		    int cnt = dao.idCheck(m_id); 
		    // idCheckDAO 硫붿꽌�뱶(select count(*) from member where m_id = #{m_id})瑜� �떎�뻾�븯�뿬
		    // �궗�슜�옄媛� �엯�젰�븳 m_id�뜲�씠�꽣�� 媛숈� m_id�뿴�쓽 �뜲�씠�꽣 媛쒖닔瑜� 'cnt'�씪�뒗 蹂��닔�뿉 ���옣�븳�떎

		    if (cnt > 0) { // 媛쒖닔媛� 0蹂대떎 留롮쑝硫�
		        return "DUPLICATE";   // �씠誘� 議댁옱
		    }
		    return "OK";             // �븘�땲硫� �궗�슜 媛��뒫
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
		
		@RequestMapping("/resetPasswordForm")
		public String resetpasswordForm() {
			return "user/member/resetPasswordForm";
		}

		@PostMapping("/resetPassword")
		public String resetPassword(@RequestParam("m_id") String m_id,HttpSession session,Model model,HttpServletRequest request) {
				
		    memberDTO dto = dao.getMemberByIdDao(m_id);

		    if (dto == null) {
		        model.addAttribute("msg", "아이디가 존재하지 않습니다.");
		        return "user/member/resetPasswordForm";
		    }

		    // 아이디를 세션에 저장
		    session.setAttribute("resetId", m_id);

		    // 임시 비밀번호 생성
		    String tempPw = UUID.randomUUID().toString().substring(0, 8); // 비밀번호 8자리 이하
		    String encoded = passwordEncoder.encode(tempPw);

		    dao.updatePassword(m_id, encoded);

		    // 임시 비번도 세션에 저장
		    session.setAttribute("tempPw", tempPw);

		    return "redirect:/resultPassword";
		}
		
		@GetMapping("/resultPassword")
		public String resultPassword() {
			return "user/member/resultPassword";
		}
	}