package com.greentable.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.greentable.DAO.memberDAO;
import com.greentable.DTO.memberDTO;

import jakarta.servlet.http.HttpSession;

@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    @Autowired
    private memberDAO dao; // MyBatis DAO 주입
    
    @Autowired
    private HttpSession session;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);
        
        // 카카오 전체 정보 가져오기
        Map<String, Object> attributes = oAuth2User.getAttributes();
        
        // 카카오 계정 정보(이메일 등)와 프로필 정보(닉네임, 사진 등) 추출
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

        String kakaoId = attributes.get("id").toString();
        String nickname = (String) profile.get("nickname"); // 카카오 닉네임
        String email = (String) kakaoAccount.get("email");   // 카카오 이메일

        memberDTO member = dao.findByMid(kakaoId);
        
        if (member == null) {
            memberDTO newMember = new memberDTO();
            newMember.setM_id(kakaoId);
            newMember.setM_passwd("OAUTH2_USER");
            
            // 카카오에서 프로필 이미지를 가져오려고 시도
            Object kakaoImage = oAuth2User.getAttribute("properties"); 
            String profileImg = "default_profile.png"; // 준비해둔 기본 이미지 파일명
            
            newMember.setM_image(profileImg);
            
            // 카카오에서 받은 진짜 정보를 넣기
            newMember.setM_name(nickname);      // 이름에 닉네임 넣기
            newMember.setM_nickname(nickname);  // 닉네임에 닉네임 넣기
            newMember.setM_email(email);        // 이메일
            
            // 그래도 여전히 NOT NULL인 주소와 전화번호는 채워줘야 함
            newMember.setM_addr("카카오 가입자(주소미입력)");
            newMember.setM_tel("010-0000-0000");
            newMember.setM_authority("KAKAO");
            

            dao.SignupDao(newMember);
            System.out.println(">>> [자동 가입 완료] 닉네임: " + nickname);
        }
        
        session.setAttribute("m_authority",member.getM_authority());
        
        return oAuth2User;
    }
}