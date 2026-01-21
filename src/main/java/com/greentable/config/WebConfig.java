package com.greentable.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        // 사용자 업로드 파일용 (C드라이브 외부 폴더)
        // 브라우저에서 /upload/파일명 으로 접근하면 C:/upload/ 에서 파일을 찾음
        registry.addResourceHandler("/upload/**")
                .addResourceLocations("file:///C:/upload/");

        // 기본 프로필 이미지용 (프로젝트 내부 static 폴더)
        // 브라우저에서 /profile_images/파일명 으로 접근하면 resources/static/profile_images/ 에서 파일을 찾음
        registry.addResourceHandler("/profile_images/**")
                .addResourceLocations("classpath:/static/profile_images/");
    }
}