package kr.co.msync.web.module.survey;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.survey.model.req.SurveyReqVO;
import kr.co.msync.web.module.survey.model.res.SurveyResVO;
import kr.co.msync.web.module.survey.service.SurveyService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class SurveyController extends BaseController {


    public static final String NAME = "/survey";
    public static final String MAIN = NAME + "/admin";

    /** 로그 기본 */
    public static final String SURVEY = MAIN + "/survey";

    /** 로그 리스트 */
    public static final String SURVEY_LIST = MAIN + "/surveyList";
    
    @Autowired
    private SurveyService surveyService;

    @RequestMapping(value = SURVEY, method = {RequestMethod.GET, RequestMethod.POST})
    public String survey(Model model) {

        SurveyReqVO reqVO = new SurveyReqVO();
        int total_cnt = surveyService.getSurveyListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return SURVEY + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = SURVEY_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String surveyList(@ModelAttribute("SurveyReqVO")SurveyReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("id");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<SurveyResVO> list = surveyService.getSurveyList(reqVO);
        int listCnt = surveyService.getSurveyListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("surveyList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("SurveyReqVO", reqVO);

        return SURVEY_LIST + ADMIN_EMPTY_SUFFIX;

    }
    
}
