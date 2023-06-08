package kr.co.msync.web.module.faq.model;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by MSYNC-CMH on 2019-10-15.
 */
@Data
public class FaqVO extends Criteria {
    private String no_faq;
    private String no_item;
    private String item_name;       //FAQ 항목
    private String item_name_en;    //FAQ 항목(영문) - css class name
    private String faq_q;           //FAQ 질문
    private String faq_a;           //FAQ 답변
    private String faq_keyword;     //FAQ 항목 키워드
    private String wordSearch;      //FAQ 검색시

    //FAQ항목 내용 중에 서브 내용 있는 경우
    //EX) 아이코스는 어떤 제품인가요?
    List<FaqVO> faqItemSubList = new ArrayList<>();

    //FAQ 키워드 리스트
    List<FaqVO> faqKeywordList = new ArrayList<>();
}
