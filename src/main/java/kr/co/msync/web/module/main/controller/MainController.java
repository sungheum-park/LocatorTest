package kr.co.msync.web.module.main.controller;

import com.google.gson.Gson;
import com.sun.org.apache.xpath.internal.operations.Mod;
import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.faq.model.FaqVO;
import kr.co.msync.web.module.faq.service.FaqService;
import kr.co.msync.web.module.main.model.NoticeVO;
import kr.co.msync.web.module.main.model.RegionVO;
import kr.co.msync.web.module.main.model.StoreDetailVO;
import kr.co.msync.web.module.main.service.MainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;

@Slf4j
@Controller
public class MainController extends BaseController{

    public static final String NAME = "main";

    public static final String MAIN = "/" + NAME;

    public static final String INDEX = "/main";

    //[메인화면] 지도 -> 메뉴서비스 화면 변경작업 19.10.14
    //[메인화면] 메뉴서비스 -> 지도로 다시 변경 20.11.02
    public static final String MAIN_SERVICE = "/mainService";

    /* 2022-11-14 외부 링크로 변경하면서 해당 경로로 접속 시 main으로 redirect
    public static final String SELF_CHECK = "/selfCheck";
    public static final String DEVICE_TUTORIAL = "/tutorial";
    public static final String SERVICE_TERMS = "/terms";

    //[메인화면] - [케어 플러스] 메뉴 추가 19.10.14
    public static final String CARE_PLUS = "/carePlus";

    //[메인화면] - [자주 묻는 질문] 메뉴 추가 19.10.14
    public static final String FAQ = "/faq";
    public static final String FAQ_LIST = "/faqList";*/


    @Autowired
    private MainService mainService;

    @Autowired
    private kr.co.msync.web.module.faq.service.FaqService faqService;

    @Autowired
    private Gson gson;

    /**
    *  메인화면 서비스 메뉴로 진입(19.10.14)
    *  메인화면 지도로 다시 변경되면서 사용안함(20.11.02)
    * */
    //@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
    @Deprecated
    public String mainService(){
        return MAIN + MAIN_SERVICE + MAIN_SUFFIX;
    }

    @RequestMapping(value = {"/", INDEX}, method = {RequestMethod.GET, RequestMethod.POST})
    public String index(@RequestParam(required = false) String serviceName, StoreDetailVO reqVO, Model model, HttpServletRequest request) throws ParseException {
        /* 기간 지나면 삭제 */
        String requestIp = getRequestIp();
        String[] exceptionIp = {"13.124.152.243", "15.164.43.183", "134.238.4.185", "134.238.4.184", "15.164.43.156"};
        boolean isExist = Arrays.stream(exceptionIp).anyMatch(requestIp::equals);

        String str1 = "2023-03-29 00:00:00.000";
        String str2 = "2023-03-29 04:00:00.000";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
        LocalDateTime today = LocalDateTime.now();
        LocalDateTime date1 = LocalDateTime.parse(str1, formatter);
        LocalDateTime date2 = LocalDateTime.parse(str2, formatter);

        if (!isExist && date1.isBefore(today) && date2.isAfter(today)) {
            return MAIN + "/notice" + EMPTY_SUFFIX;
        }
        /* // 기간 지나면 삭제 */

        // 공유하기로 진입시
        if(reqVO.getStore_code() != null){
            log.info("공유하기로 진입 상점 코드 : {}", reqVO.getStore_code());
            // 공유하기로 입장
            StoreDetailVO storeDetailVO = this.mainService.getStoreDetailByStoreCode(reqVO);
            if(storeDetailVO != null){
                model.addAttribute("storeDetailResVO", gson.toJson(storeDetailVO));
            }
        }
        // 지역 리스트
        model.addAttribute("regionList", this.mainService.getRegionList(new RegionVO(null, 1,"000", null)));
        // 필터
        // 필터 서비스 리스트
        model.addAttribute("serviceList", this.mainService.getServiceAll());
        // 필터 교환기기/판매기기
        model.addAttribute("categoryList", this.mainService.getCategoryList());
        // 공지사항
        NoticeVO notice = this.mainService.getNotice();
        if(notice != null){
            NoticeVO noticeVO = mainService.getNotice();
            noticeVO.setNotice_contents(noticeVO.getNotice_contents().replace("\n", "<br>").replace("\\n", "<br>").replace("\r", ""));
            model.addAttribute("noticeData", gson.toJson(noticeVO));
        }
        model.addAttribute("serviceName", serviceName);

        return MAIN + INDEX + STORE_LOCATOR_SUFFIX;
    }

    /**
     *  접속 아이피 반환
    */
    public static String getRequestIp() {
        HttpServletRequest request = null;
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        if (attributes != null) {
            request = ((ServletRequestAttributes) attributes).getRequest();
        }

        if (request == null) return null;

        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }

        if (ip.indexOf(",") > -1) {
            return ip.split(",")[0].trim();
        } else if (ip.indexOf(";") > -1) {
            return ip.split(";")[0].trim();
        }

        return ip;
    }

//    /* - 2022-11-14 하위 메뉴 외부 링크로 변경하면서 해당 경로로 접속 시 main으로 redirect
//     * 자가 진단
//     * @return
//     */
//    @RequestMapping(value = SELF_CHECK, method = {RequestMethod.GET, RequestMethod.POST})
//    public String selfCheck(Model model){
//        // model.addAttribute("mt_id", "1464193");
//        // return MAIN + SELF_CHECK + DEFAULT_SUFFIX;
//        return "redirect:" + MAIN;
//    }
//
//    *//**
//     * 기기 사용법 - 2022-11-14 외부 링크로 변경하면서 해당 경로로 접속 시 main으로 redirect
//     * @return
//     *//*
//    @RequestMapping(value = DEVICE_TUTORIAL, method = {RequestMethod.GET, RequestMethod.POST})
//    public String deviceTutorial(Model model){
//        *//*model.addAttribute("mt_id", "1464191");
//        return MAIN + DEVICE_TUTORIAL + DEFAULT_SUFFIX;*//*
//        return "redirect:" + MAIN;
//    }
//
//    *//**
//     * 서비스 정책
//     * @return
//     *//*
//    @RequestMapping(value = SERVICE_TERMS, method = {RequestMethod.GET, RequestMethod.POST})
//    public String serviceTerms(Model model){
//        model.addAttribute("mt_id","1464195");
//        return MAIN + SERVICE_TERMS + DEFAULT_SUFFIX;
//    }
//
//    /**
//     * 케어 플러스
//     * @return
//     */
//    @RequestMapping(value = CARE_PLUS, method = {RequestMethod.GET, RequestMethod.POST})
//    public String carePlus(Model model){
//        model.addAttribute("mt_id", "1464192");
//        return MAIN + CARE_PLUS + DEFAULT_SUFFIX;
//    }
//
//    /**
//     *  FAQ : 자주 묻는 질문(항목)
//     * @return
//     */
//    @RequestMapping(value = FAQ, method = {RequestMethod.GET, RequestMethod.POST})
//    public String faq(@ModelAttribute("FaqVO")FaqVO faqVO, Model model){
//
//        //FAQ 항목 카테고리
//        List<FaqVO> faqItemList = faqService.getFaqItemList();
//
//        model.addAttribute("faqItemList", faqItemList);
//        model.addAttribute("mt_id", "1464194");
//        return MAIN + FAQ + DEFAULT_SUFFIX;
//    }
//
//    /**
//     *  FAQ : 자주 묻는 질문(FAQ 리스트)
//     * @return
//     */
//    @RequestMapping(value = FAQ_LIST, method = {RequestMethod.GET, RequestMethod.POST})
//    public String faqList(@ModelAttribute("FaqVO")FaqVO faqVO, Model model){
//
//        //FAQ 리스트
//        List<FaqVO> faqList = faqService.getFaqList(faqVO);
//        int faqListCnt = faqService.getFaqListCnt(faqVO);
//
//        //페이징
//        PageMaker pageMaker = new PageMaker();
//        pageMaker.setPage(faqVO.getPage());
//        pageMaker.setPerPageNum(faqVO.getPerPageNum());
//        pageMaker.setTotalCount(faqListCnt);
//
//        String faqItem = "";                                                            //faq_title
//        if(faqVO.getNo_item() != null && !"".equals(faqVO.getNo_item())){               //faq 항목으로 검색(아이코스란?/ 아이코스3 듀오 ...)
//            if(faqList.size() > 0){
//                faqItem = faqList.get(0).getItem_name();
//            }else{                                                                      //faq 검색시 결과 없는 경우
//                faqItem = "검색 결과";
//            }
//        }else if(faqVO.getWordSearch() != null && !"".equals(faqVO.getWordSearch()) ){  //faq 검색으로 조회한 경우
//            faqItem = "검색 결과";
//        }else{
//            faqItem = "전체보기";                                                       //맨 처음 진입시 또는 전체보기로 조회한 경우
//        }
//        model.addAttribute("faqItem", faqItem);
//        model.addAttribute("faqList", faqList);
//        model.addAttribute("faqListCnt", faqListCnt);
//        model.addAttribute("pageMaker", pageMaker);
//
//        return MAIN + FAQ_LIST + EMPTY_SUFFIX;
//    }

}
