package com.study.springboot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.memberDAO;
import com.study.springboot.dto.memberDTO;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
    private memberDAO dao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        memberDTO dto = dao.findByMid(username);
        if (dto == null) {
            throw new UsernameNotFoundException("사용자 없음");
        }

        return User.builder()
                .username(dto.getM_id())
                .password(dto.getM_passwd())
                .roles(dto.getM_authority()) // DB에 'USER' 또는 'ADMIN'
                .build();
    }
}
