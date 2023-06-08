package kr.co.msync.web.module.faq.dao;

import kr.co.msync.web.module.faq.model.FaqVO;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by MSYNC-CMH on 2019-10-15.
 */
@Repository
public interface FaqMapper {
    List<FaqVO> getFaqItemList();
    List<FaqVO> getFaqItemSubList(FaqVO faqVO);

    List<FaqVO> getFaqList(FaqVO faqVO);
    int getFaqListCnt(FaqVO faqVO);

}
