package kr.co.msync.web.module.cate;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.cate.model.req.CateReqVO;
import kr.co.msync.web.module.cate.model.res.CateResVO;
import kr.co.msync.web.module.cate.service.CateService;
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
public class CateController extends BaseController {


    public static final String NAME = "/cate";
    public static final String MAIN = NAME + "/admin";

    /** 카테고리 기본 */
    public static final String CATE = MAIN + "/cate";

    /** 카테고리 리스트 */
    public static final String CATE_LIST = MAIN + "/cateList";

    /** 카테고리 등록 화면 */
    public static final String CATE_REG_FORM = MAIN + "/cateRegForm";

    /** 카테고리 등록 */
    public static final String CATE_REG_ACTION = MAIN + "/cateRegAction";

    /** 카테고리 수정 화면 */
    public static final String CATE_MOD_FORM = MAIN + "/cateModForm";

    /** 카테고리 수정 */
    public static final String CATE_MOD_ACTION = MAIN + "/cateModAction";

    /** 카테고리 삭제 */
    public static final String CATE_DEL_ACTION = MAIN + "/cateDelAction";

    /** 카테고리 엑셀 다운로드 */
    public static final String CATE_LIST_EXCEL_DOWNLOAD = MAIN + "/cateListExcelDownload";

    @Autowired
    private CateService cateService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = CATE, method = {RequestMethod.GET, RequestMethod.POST})
    public String cate(Model model) {

        CateReqVO reqVO = new CateReqVO();
        int total_cnt = cateService.getCateListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return CATE + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = CATE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateList(@ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<CateResVO> list = cateService.getCateList(reqVO);
        int listCnt = cateService.getCateListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("cateList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("CateReqVO", reqVO);

        return CATE_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = CATE_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateRegForm(Model model) {

        model.addAttribute("cate_name","카테고리 등록");
        return CATE_REG_FORM + ADMIN_DEFAULT_SUFFIX;

    }


    @RequestMapping(value = CATE_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateRegAction(MultipartRequest req, @ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        Map<String, Object> map = commonService.getSequence("TB_CATEGORY");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            reqVO.setNo_cate((String) map.get("seq"));
        }

        boolean isRegister = cateService.cateRegAction(fileMap, reqVO);

        if(isRegister) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = CATE_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String CATE_MOD_FORM(@ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        CateResVO resVO = cateService.getCateInfo(reqVO);

        model.addAttribute("vo", resVO);

        return CATE_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = CATE_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateModAction(MultipartRequest req, @ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        boolean isModify = cateService.cateModAction(fileMap, reqVO);

        if(isModify) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = CATE_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateDelAction(@ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = cateService.cateDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = CATE_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String cateListExcelDownload(@ModelAttribute("CateReqVO")CateReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<CateResVO> list = cateService.getCateExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.카테고리리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }

}
