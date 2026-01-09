package com.study.springboot.auth;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import jakarta.servlet.DispatcherType;

@Configuration
public class WebSecurityConfig {

	// 비밀번호 암호화
	@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http.csrf((csrf) -> csrf.disable()) // CSRF 보호 비활성화
			.cors((cors) -> cors.disable()) // CORS 비활성화
			.authorizeHttpRequests(request -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() // 내부 포워드 요청 허용
					.requestMatchers("/","/main","/write","/login","/updateForm","/signup","/passwordCheckForm","/css/**",
							"/js/**","/images/**","/idCheck").permitAll() // 정적 리소스, member 폴더의 페이지는 모두에게 허용
					.requestMatchers("/product/**").hasAnyRole("USER","ADMIN") // product 폴더는 'USER', 'ADMIN' 권한을 가진 사람에게만 접근 허용
					.requestMatchers("/admin/**").hasAnyRole("ADMIN") // admin 폴더의 페이지는 'ADMIN'만 권한을 가진 사람에게만 접근 허용
					.anyRequest().authenticated() // 나머지는 모두 인증 필요
			);
		


		
		// 로그인
		http.formLogin((formLogin) -> formLogin
				.loginPage("/login") // 기본값  : /login
				.loginProcessingUrl("/j_spring_security_check")
				.failureUrl("/login?error=true") //기본값 : /login?error 로그인 에러 페이지
				.usernameParameter("j_username")
				.passwordParameter("j_password")
				.defaultSuccessUrl("/", true)
				// .failureUrl("/login?error") 기본값 : login?error
				.permitAll()
				);
		
		// 로그아웃
		http.logout((logout) -> logout		
		.logoutUrl("/logout")
		.logoutSuccessUrl("/") // 로그아웃 시 홈화면(/)으로 회귀
		.permitAll()
		);
		return http.build();
	}
	
}