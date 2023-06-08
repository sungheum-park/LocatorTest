package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;

@Slf4j
public class ClientUtil {

    public static String getRemoteIP(HttpServletRequest request){
        String clientIP = request.getHeader("X-Forwarded-For");

        if(clientIP == null){
            clientIP = request.getHeader("Proxy-Client-IP");
        }
        if(clientIP == null){
            clientIP = request.getHeader("WL-Proxy-Client-IP");
        }
        if(clientIP == null){
            clientIP = request.getHeader("HTTP_CLIENT_IP");
        }
        if(clientIP == null){
            clientIP = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if(clientIP == null){
            clientIP = request.getRemoteAddr();
        }

        return clientIP;
    }
}
