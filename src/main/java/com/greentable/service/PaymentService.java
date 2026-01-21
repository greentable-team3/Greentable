package com.greentable.service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {

    // [중요] 포트원 콘솔 -> 연동 관리에서 확인한 본인의 키를 넣으세요
    private final String API_KEY = "8087834071254606";
    private final String API_SECRET = "kIsrikR3swEypHGHCRCdwVbOINTuRvpMIUcUfQUO6ZgF2vcnkqjGqMSUiio6aQnsmA80eLzv9sBUu690";

    // 1. 포트원으로부터 액세스 토큰(접속 권한) 발급받기
    public String getToken() throws Exception {
        URL url = new URL("https://api.iamport.kr/users/getToken");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        JSONObject obj = new JSONObject();
        obj.put("imp_key", API_KEY);
        obj.put("imp_secret", API_SECRET);

        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))) {
            bw.write(obj.toString());
            bw.flush();
        }

        if (conn.getResponseCode() == 200) {
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            JSONParser parser = new JSONParser();
            JSONObject response = (JSONObject) parser.parse(br.readLine());
            JSONObject res = (JSONObject) response.get("response");
            return res.get("access_token").toString();
        } else {
            throw new RuntimeException("포트원 토큰 발급 실패");
        }
    }

    // 2. 실제 환불(결제 취소) 실행
    public void refund(String token, String tid, String reason) throws Exception {
        URL url = new URL("https://api.iamport.kr/payments/cancel");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", token);
        conn.setDoOutput(true);

        JSONObject obj = new JSONObject();
        obj.put("imp_uid", tid); // DB에 저장된 o_pay_tid (결제 고유번호)
        obj.put("reason", reason);

        try (BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()))) {
            bw.write(obj.toString());
            bw.flush();
        }

        if (conn.getResponseCode() == 200) {
            System.out.println("포트원 환불 요청 성공");
        } else {
            System.out.println("환불 실패: " + conn.getResponseMessage());
        }
    }
}