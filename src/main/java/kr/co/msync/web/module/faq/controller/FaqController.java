/*
package kr.co.msync.web.module.faq.controller;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.faq.model.FaqVO;
import kr.co.msync.web.module.faq.service.FaqService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Slf4j
@Controller
public class FaqController extends BaseController{

    public static final String NAME = "/faq";

    public static final String MAIN = "/" + NAME;

    //[자주 묻는 질문] 메뉴 추가 19.10.28
    public static final String FAQ = "/faq";
    public static final String FAQ_LIST = MAIN + "/faqList";
    public static final String FAQ_SEARCH = "/faqSearchList";

    @Autowired
    private FaqService faqService;


    */
/**
     *  FAQ : 자주 묻는 질문(항목)
     * @return
     *//*

    @RequestMapping(value = FAQ, method = {RequestMethod.GET, RequestMethod.POST})
    public String faq(@ModelAttribute("FaqVO")FaqVO faqVO, Model model){

        //FAQ 항목 카테고리
        List<FaqVO> faqItemList = faqService.getFaqItemList();

        model.addAttribute("faqItemList", faqItemList);

        return MAIN + FAQ + DEFAULT_SUFFIX;
    }
    */
/**
     *  FAQ : 자주 묻는 질문(FAQ 리스트)
     * @return
     *//*

    @RequestMapping(value = FAQ_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String faqList(@ModelAttribute("FaqVO")FaqVO faqVO, Model model){

        //FAQ 리스트
        List<FaqVO> faqList = faqService.getFaqList(faqVO);
        int faqListCnt = faqService.getFaqListCnt(faqVO);

        //페이징
        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(faqVO.getPage());
        pageMaker.setPerPageNum(faqVO.getPerPageNum());
        pageMaker.setTotalCount(faqListCnt);

        model.addAttribute("faqItem", faqList.get(0).getItem_name() == null ? "전체보기" : faqList.get(0).getItem_name());
        model.addAttribute("faqList", faqList);
        model.addAttribute("faqListCnt", faqListCnt);
        model.addAttribute("pageMaker", pageMaker);

        return MAIN + FAQ_LIST + EMPTY_SUFFIX;
    }

    */
/**
     *  FAQ : FAQ 검색
     * @return
     *//*

    @RequestMapping(value = FAQ_SEARCH, method = {RequestMethod.GET, RequestMethod.POST})
    public String faqSearch(@ModelAttribute("FaqVO")FaqVO faqVO, Model model){

        //FAQ 검색 조회 리스트
        List<FaqVO> searchList = faqService.getSearchList(faqVO);
        int searchListCnt = faqService.getSearchListCnt(faqVO);

        //페이징
        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(faqVO.getPage());
        pageMaker.setPerPageNum(faqVO.getPerPageNum());
        pageMaker.setTotalCount(searchListCnt);

        model.addAttribute("keywordList", searchList);
        model.addAttribute("pageMaker", pageMaker);

        return MAIN + FAQ_SEARCH + MAIN_SUFFIX;
    }
}
*/
