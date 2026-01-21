package com.greentable.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.greentable.DAO.foodDAO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class FoodListInterceptor implements HandlerInterceptor {

    @Autowired
    private foodDAO fDao; 

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, 
                            Object handler, ModelAndView modelAndView) throws Exception {
        
        // 컨트롤러가 끝나고 JSP를 그리기 직전에 실행
        if (modelAndView != null) {
            // 모든 페이지에서 사용할 수 있게 list를 강제로 심어줌
            modelAndView.addObject("list", fDao.flistDao(null));
        }
    }
}