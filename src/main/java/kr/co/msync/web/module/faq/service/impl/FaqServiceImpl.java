package kr.co.msync.web.module.faq.service.impl;

import kr.co.msync.web.module.faq.dao.FaqMapper;
import kr.co.msync.web.module.faq.model.FaqVO;
import kr.co.msync.web.module.faq.service.FaqService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by MSYNC-CMH on 2019-10-15.
 */
@Slf4j
@Service("FaqService")
@Transactional
public class FaqServiceImpl implements FaqService {

    @Autowired
    private FaqMapper faqMapper;

    @Override
    public List<FaqVO> getFaqItemList() {
        List<FaqVO> faqItemList = this.faqMapper.getFaqItemList();
        return faqItemList;
    }

    @Override
    public List<FaqVO> getFaqList(FaqVO faqVO) {
        List<FaqVO> faqList = this.faqMapper.getFaqList(faqVO);

        for(int i=0;i <faqList.size(); i++){
            faqList.get(i).setFaq_a(faqList.get(i).getFaq_a().replace("\n", "<br>").replace("\\n", "<br>").replace("\r", ""));
            //FAQ 내용 중에 서브 내용 조회
            List<FaqVO> faqSubList = faqList.get(i).getFaqItemSubList();

            for(int j = 0; j < faqSubList.size() ; j++){
                faqSubList.get(j).setFaq_a(faqSubList.get(j).getFaq_a().replace("\n", "<br>").replace("\\n", "<br>").replace("\r", ""));
            }
        }
        return faqList;
    }

    @Override
    public int getFaqListCnt(FaqVO faqVO) {
        int result = this.faqMapper.getFaqListCnt(faqVO);
        return result;
    }

}
