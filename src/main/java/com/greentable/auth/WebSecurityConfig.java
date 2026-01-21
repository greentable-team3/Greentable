package com.greentable.auth;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    // 비밀번호 암호화 빈
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 1. 보안 방화벽 설정을 "한글/특수문자 허용"으로 완화합니다.
    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedSlash(true);
        firewall.setAllowSemicolon(true);
        firewall.setAllowUrlEncodedPercent(true); // 한글(%인코딩) 허용 핵심!
        firewall.setAllowBackSlash(true);
        firewall.setAllowUrlEncodedDoubleSlash(true);
        return firewall;
    }

    // 2. 위에서 만든 설정을 시큐리티에 적용합니다.
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.httpFirewall(allowUrlEncodedSlashHttpFirewall());
    }
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf.disable()) // CSRF 비활성화 (개발 편의성)
            .cors(cors -> cors.disable()) // CORS 비활성화
            .authorizeHttpRequests(request -> request
                // 1. 내부 포워딩 요청은 무조건 허용 (JSP 렌더링에 필수)
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                
                // 2. 정적 리소스 (CSS, JS, 이미지) - 시큐리티 검사 없이 모두 허용
                .requestMatchers("/css/**", "/js/**", "/image/**", "/user/**", "/profile_images/**", "/upload/**").permitAll()
                
                // 3. 누구나 접근 가능한 페이지 (메인, 로그인, 회원가입, 상품목록 등)
                .requestMatchers("/", "/main", "/login", "/signup", "/write", "/findIdForm", "/findId", "/findPwAuth", 
                                 "/updatePassword", "/idCheck", "/mailCheck", "/resetPasswordForm", 
                                 "/resetPassword", "/kakao", "/verifyCode", "/foodlist", "/fdetail", "/searchResult").permitAll()
                
                // 4. [보안 강화] 관리자 전용 기능 (주문관리, 배송상태변경, 상품등록 등)
                // /admin/으로 시작하는 모든 경로와 배송 상태 업데이트 기능을 관리자만 가능하게 묶었습니다.
                .requestMatchers("/admin/**", "/updateStatus", "/admin/approveRequest", "/finsertForm", "/finsert", 
                                 "/fupdate", "/fdelete", "/fedit", "/alist", "/adminOrderList").hasAnyAuthority("ADMIN")
                
                // 5. 로그인한 사용자(일반유저+관리자) 공통 기능 (마이페이지, 주문상세, 장바구니 등)
                .requestMatchers("/myinfo", "/updateForm", "/passwordCheckForm", "/passwordCheck", "/adelete",
                                 "/odetail", "/olist", "/oinsertForm", "/oinsert", "/cartlist", "/binsert/**").authenticated()
                
                // 6. 그 외 모든 요청은 인증(로그인)이 필요함
                .anyRequest().authenticated()
            );

        // 카카오 로그인 설정
        http.oauth2Login(oauth2 -> oauth2
            .loginPage("/login")
            .defaultSuccessUrl("/kakao", true)
        );

        // 일반 폼 로그인 설정
        http.formLogin(formLogin -> formLogin
            .loginPage("/login")
            .loginProcessingUrl("/j_spring_security_check")
            .failureUrl("/login?error=true")
            .usernameParameter("j_username")
            .passwordParameter("j_password")
            .defaultSuccessUrl("/main", true)
            .permitAll()
        );

        // 로그아웃 설정
        http.logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/main")
            .invalidateHttpSession(true) // 세션 무효화
            .permitAll()
        );

        return http.build();
    }
}