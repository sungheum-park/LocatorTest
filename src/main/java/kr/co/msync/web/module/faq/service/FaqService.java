package kr.co.msync.web.module.faq.service;

import kr.co.msync.web.module.faq.model.FaqVO;

import java.util.List;

/**
 * Created by MSYNC-CMH on 2019-10-15.
 */
public interface FaqService {
    // FAQ 항목 조회
    List<FaqVO> getFaqItemList();

    // FAQ 질문 리스트 조회
    List<FaqVO> getFaqList(FaqVO faqVO);
    // FAQ 질문 리스트 개수
    int getFaqListCnt(FaqVO faqVO);

}
