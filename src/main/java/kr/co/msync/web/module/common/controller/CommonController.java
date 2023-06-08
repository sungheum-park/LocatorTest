package kr.co.msync.web.module.common.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Controller
public class CommonController extends BaseController {

    /** 404 페이지 */
    public static final String ERROR_404 = "/common/error404";
    /** 500 페이지 */
    public static final String ERROR_500 = "/common/error500";
    /** 메인 페이지 */
    public static final String MAIN = "/";

    @RequestMapping(value = {ERROR_500})
    public String error500(HttpServletRequest request, HttpServletResponse response) {
//		log.info("ERROR_500 진입");
//		log.info("ERROR_500 404경로 ::: {}", request.getRequestURI());
        return "redirect:" + MAIN;
    }

    @RequestMapping(value = {ERROR_404})
    public String error404(HttpServletRequest request, HttpServletResponse response) {
//		log.info("ERROR_404 진입");
//		log.info("ERROR_404 404경로 ::: {}", request.getRequestURI());
        return "redirect:" + MAIN;
    }
}
