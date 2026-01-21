package com.greentable;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling // 스케줄러 기능을 켭니다
@SpringBootApplication
public class GreentableApplication {

	public static void main(String[] args) {
		SpringApplication.run(GreentableApplication.class, args);
	}

}
