package com.greentable.auth;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import jakarta.servlet.DispatcherType;

@Configuration
public class WebSecurityConfig {

	// ?��꾨�踰덊?�� �븫�샇�솕
	@Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http.csrf((csrf) -> csrf.disable()) // CSRF 蹂댄?�� ?��꾪솢�꽦�솕
			.cors((cors) -> cors.disable()) // CORS ?��꾪솢�꽦�솕
			.authorizeHttpRequests(request -> request
					.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
					.requestMatchers("/","/main","/write","/login","/updateForm","/signup","/passwordCheckForm","/findIdForm","/findId",
							"/idCheck","/resetPassword","/resultPassword","/css/**","/js/**","/images/**","/user/**").permitAll()
					.requestMatchers("/admin/**").hasAnyRole("ADMIN")
			);
		


		
		// 濡쒓?���씤
		http.formLogin((formLogin) -> formLogin
				.loginPage("/login") // 湲곕?��媛�  : /login
				.loginProcessingUrl("/j_spring_security_check")
				.failureUrl("/login?error=true") //湲곕?��媛� : /login?error 濡쒓?���씤 �뿉�윭 �럹�씠吏�
				.usernameParameter("j_username")
				.passwordParameter("j_password")
				.defaultSuccessUrl("/", true)
				// .failureUrl("/login?error") 湲곕?��媛� : login?error
				.permitAll()
				);
		
		// 濡쒓?���븘�썐
		http.logout((logout) -> logout		
		.logoutUrl("/logout")
		.logoutSuccessUrl("/") // 濡쒓?���븘�썐 �떆 �솃�솕硫�(/)�쑝濡� �쉶洹�
		.permitAll()
		);
		return http.build();
	}
	
}