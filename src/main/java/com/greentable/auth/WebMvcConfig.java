package com.greentable.auth;

// 인터셉터 (모든 페이지의 공유 파일을 전송할 때 다룸)
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.greentable.interceptor.FoodListInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    private FoodListInterceptor foodListInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(foodListInterceptor)
                .addPathPatterns("/main")
                .excludePathPatterns("/css/**", "/js/**", "/image/**", "/upload/**", "/profile_images/**");
    }
}