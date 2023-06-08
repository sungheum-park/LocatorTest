package kr.co.msync.web.module.notice;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.notice.model.req.NoticeReqVO;
import kr.co.msync.web.module.notice.model.res.NoticeResVO;
import kr.co.msync.web.module.notice.service.NoticeService;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.util.SessionUtil;
import kr.co.msync.web.module.util.StringUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import java.util.List;
import java.util.Map;

@Controller
public class NoticeController extends BaseController {


    public static final String NAME = "/notice";
    public static final String MAIN = NAME + "/admin";

    /** 공지사항 기본 */
    public static final String NOTICE = MAIN + "/notice";

    /** 공지사항 리스트 */
    public static final String NOTICE_LIST = MAIN + "/noticeList";

    /** 공지사항 등록 화면 */
    public static final String NOTICE_REG_FORM = MAIN + "/noticeRegForm";

    /** 공지사항 등록 */
    public static final String NOTICE_REG_ACTION = MAIN + "/noticeRegAction";

    /** 공지사항 수정 화면 */
    public static final String NOTICE_MOD_FORM = MAIN + "/noticeModForm";

    /** 공지사항 수정 */
    public static final String NOTICE_MOD_ACTION = MAIN + "/noticeModAction";

    /** 공지사항 삭제 */
    public static final String NOTICE_DEL_ACTION = MAIN + "/noticeDelAction";

    /** 공지사항 미리보기 */
    public static final String NOTICE_PREVIEW_FORM = MAIN + "/noticePreviewModal";

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = NOTICE, method = {RequestMethod.GET, RequestMethod.POST})
    public String notice(Model model) {

        NoticeReqVO reqVO = new NoticeReqVO();
        int total_cnt = noticeService.getNoticeListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return NOTICE + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = NOTICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeList(@ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_notice");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<NoticeResVO> list = noticeService.getNoticeList(reqVO);
        int listCnt = noticeService.getNoticeListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("noticeList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("NoticeReqVO", reqVO);

        return NOTICE_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = NOTICE_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeRegForm(Model model) {
        return NOTICE_REG_FORM + ADMIN_DEFAULT_SUFFIX;

    }


    @RequestMapping(value = NOTICE_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeRegAction(MultipartRequest req, @ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setDel_yn(YesNoType.NO.getValue());

        boolean isRegister = noticeService.noticeRegAction(fileMap, reqVO);

        if(isRegister) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = NOTICE_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String NOTICE_MOD_FORM(@ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        NoticeResVO resVO = noticeService.getNoticeInfo(reqVO);

        model.addAttribute("vo", resVO);

        return NOTICE_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = NOTICE_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeModAction(MultipartRequest req, @ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        boolean isModify = noticeService.noticeModAction(fileMap, reqVO);

        if(isModify) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = NOTICE_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticeDelAction(@ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = noticeService.noticeDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = NOTICE_PREVIEW_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String noticePreview(@ModelAttribute("NoticeReqVO")NoticeReqVO reqVO, Model model) {

        NoticeResVO resVO = noticeService.getNoticeInfo(reqVO);

        model.addAttribute("vo", resVO);

        return NOTICE_PREVIEW_FORM + ADMIN_MODAL_SUFFIX;

    }

}
