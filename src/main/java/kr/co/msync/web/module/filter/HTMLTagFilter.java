package kr.co.msync.web.module.filter;


import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class HTMLTagFilter extends OncePerRequestFilter{
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        try{
            filterChain.doFilter(new XSSHtmlRequestWrapper(request), response);
        }catch(Exception e){
            log.info("## HTMLTagFilter 작업중 에러");
            e.printStackTrace();
        }
    }
}
