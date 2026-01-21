package com.greentable.service;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    // 인증번호 생성 및 메일 발송 (type 매개변수 추가: join 또는 reset)
    public String sendAuthMail(String toEmail, String type) {
        // 6자리 랜덤 숫자 생성
        Random random = new Random();
        String authKey = String.valueOf(random.nextInt(888888) + 111111);

        // 용도에 따른 제목과 문구 설정
        String subject = "[Green Table] 인증번호 안내입니다.";
        String messageBody = "안녕하세요! Green Table입니다.\n\n";
        
        if ("join".equals(type)) {
            subject = "[Green Table] 회원가입 인증번호입니다.";
            messageBody += "회원가입을 위한 인증번호는 [" + authKey + "] 입니다.";
        } else if ("reset".equals(type)) {
            subject = "[Green Table] 비밀번호 재설정 인증번호입니다.";
            messageBody += "비밀번호 재설정을 위한 인증번호는 [" + authKey + "] 입니다.";
        }
        
        messageBody += "\n해당 번호를 인증창에 입력해주세요.";

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject(subject);
        message.setText(messageBody);
        message.setFrom("ytaeug43@gmail.com");

        mailSender.send(message);
        return authKey; // 생성된 번호를 컨트롤러에서 세션에 저장할 수 있게 반환
    }
}