package kr.co.msync.web.module.hist;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.hist.model.req.HistReqVO;
import kr.co.msync.web.module.hist.model.res.HistResVO;
import kr.co.msync.web.module.hist.service.HistService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class HistController extends BaseController {


    public static final String NAME = "/hist";
    public static final String MAIN = NAME + "/admin";

    /** 로그 기본 */
    public static final String HIST = MAIN + "/hist";

    /** 로그 리스트 */
    public static final String HIST_LIST = MAIN + "/histList";
    
    /** 로그 조회 모달 */
    public static final String HIST_VIEW_MODAL = MAIN + "/histViewModal";

    @Autowired
    private HistService histService;

    @RequestMapping(value = HIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String hist(Model model) {

        HistReqVO reqVO = new HistReqVO();
        int total_cnt = histService.getHistListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return HIST + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = HIST_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String histList(@ModelAttribute("HistReqVO")HistReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_hist");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<HistResVO> list = histService.getHistList(reqVO);
        int listCnt = histService.getHistListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("histList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("HistReqVO", reqVO);

        return HIST_LIST + ADMIN_EMPTY_SUFFIX;

    }
    
    @RequestMapping(value = HIST_VIEW_MODAL, method = {RequestMethod.GET, RequestMethod.POST})
    public String histViewModal(@ModelAttribute("HistReqVO")HistReqVO reqVO, Model model) {

        // 기본 정렬_컬럼, 기본 정렬 타입
        reqVO.setOrder_column("no_hist");
        reqVO.setOrder_type("desc");

        List<HistResVO> list = histService.getHistViewInfo(reqVO);

        model.addAttribute("list", list);

        return HIST_VIEW_MODAL + ADMIN_MODAL_SUFFIX;

    }

}
