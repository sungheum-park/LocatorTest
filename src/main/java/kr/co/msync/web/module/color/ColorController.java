package kr.co.msync.web.module.color;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.color.model.req.ColorReqVO;
import kr.co.msync.web.module.color.model.res.ColorResVO;
import kr.co.msync.web.module.color.service.ColorService;
import kr.co.msync.web.module.common.type.YesNoType;
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
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class ColorController extends BaseController {


    public static final String NAME = "/color";
    public static final String MAIN = NAME + "/admin";

    /** 컬러 기본 */
    public static final String COLOR = MAIN + "/color";

    /** 컬러 리스트 */
    public static final String COLOR_LIST = MAIN + "/colorList";

    /** 컬러 순번 리스트 */
    public static final String COLOR_SNO_EXCG_LIST = MAIN + "/colorSnoExcgModal";

    /** 컬러 순번 리스트 */
    public static final String COLOR_SNO_EXCG_ACTION = MAIN + "/colorSnoExcgAction";

    /** 컬러 등록 화면 */
    public static final String COLOR_REG_FORM = MAIN + "/colorRegForm";

    /** 컬러 등록 */
    public static final String COLOR_REG_ACTION = MAIN + "/colorRegAction";

    /** 컬러 수정 화면 */
    public static final String COLOR_MOD_FORM = MAIN + "/colorModForm";

    /** 컬러 수정 */
    public static final String COLOR_MOD_ACTION = MAIN + "/colorModAction";

    /** 컬러 삭제 */
    public static final String COLOR_DEL_ACTION = MAIN + "/colorDelAction";

    /** 컬러 리스트 엑셀 다운로드 */
    public static final String COLOR_LIST_EXCEL_DOWNLOAD = MAIN + "/colorListExcelDownload";

    @Autowired
    private ColorService colorService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = COLOR, method = {RequestMethod.GET, RequestMethod.POST})
    public String color(Model model) {

        ColorReqVO reqVO = new ColorReqVO();

        int total_cnt = colorService.getColorListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return COLOR + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = COLOR_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorList(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_color");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<ColorResVO> list = colorService.getColorList(reqVO);
        int listCnt = colorService.getColorListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("colorList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("ColorReqVO", reqVO);

        return COLOR_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = COLOR_SNO_EXCG_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorSnoList(Model model) {

        List<ColorResVO> list = colorService.getColorSnoExcgList();

        model.addAttribute("colorSnoExcgList", list);

        return COLOR_SNO_EXCG_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = COLOR_SNO_EXCG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorSnoExcgAction(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int updateCnt = colorService.colorSnoExcgAction(reqVO);

        if(updateCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }
        return "jsonView";

    }


    @RequestMapping(value = COLOR_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorRegForm(Model model) {

        model.addAttribute("color_name","매장 등록");
        return COLOR_REG_FORM + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = COLOR_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorRegAction(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        reqVO.setDel_yn(YesNoType.NO.getValue());

        int insertCnt = 0;
        Map<String, Object> map = commonService.getSequence("TB_DEVICE_COLOR");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            reqVO.setNo_color((String) map.get("seq"));
            insertCnt = colorService.colorRegAction(reqVO);
        }

        if(insertCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }
        return "jsonView";

    }

    @RequestMapping(value = COLOR_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String COLOR_MOD_FORM(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        ColorResVO resVO = colorService.getColorInfo(reqVO);

        model.addAttribute("vo", resVO);

        return COLOR_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = COLOR_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorModAction(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int insertCnt = colorService.colorModAction(reqVO);

        if(insertCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }
        return "jsonView";

    }

    @RequestMapping(value = COLOR_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorDelAction(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = colorService.colorDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = COLOR_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String colorListExcelDownload(@ModelAttribute("ColorReqVO")ColorReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_color");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<ColorResVO> list = colorService.getColorExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.색상리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }

}
