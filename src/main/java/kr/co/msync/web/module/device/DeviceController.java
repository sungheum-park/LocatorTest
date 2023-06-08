package kr.co.msync.web.module.device;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.device.model.req.DeviceReqVO;
import kr.co.msync.web.module.device.model.res.DeviceResVO;
import kr.co.msync.web.module.device.service.DeviceService;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import java.util.List;
import java.util.Map;

@Controller
public class DeviceController extends BaseController {


    public static final String NAME = "/device";
    public static final String MAIN = NAME + "/admin";

    /** 상품 기본 */
    public static final String DEVICE = MAIN + "/device";

    /** 상품 리스트 */
    public static final String DEVICE_LIST = MAIN + "/deviceList";

    /** 상품 등록 화면 */
    public static final String DEVICE_REG_FORM = MAIN + "/deviceRegForm";

    /** 상품 등록 */
    public static final String DEVICE_REG_ACTION = MAIN + "/deviceRegAction";

    /** 상품 수정 화면 */
    public static final String DEVICE_MOD_FORM = MAIN + "/deviceModForm";

    /** 상품 수정 */
    public static final String DEVICE_MOD_ACTION = MAIN + "/deviceModAction";

    /** 상품 삭제 */
    public static final String DEVICE_DEL_ACTION = MAIN + "/deviceDelAction";

    /** 상품 컬러 리스트 */
    public static final String DEVICE_COLOR_LIST = MAIN + "/colorSettingModal";

    /** 상품 엑셀 다운로드 */
    public static final String DEVICE_LIST_EXCEL_DOWNLOAD = MAIN + "/deviceListExcelDownload";

    @Autowired
    private DeviceService deviceService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = DEVICE, method = {RequestMethod.GET, RequestMethod.POST})
    public String device(Model model) {

        DeviceReqVO reqVO = new DeviceReqVO();
        int total_cnt = deviceService.getDeviceListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return DEVICE + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = DEVICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceList(@ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_device");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<DeviceResVO> list = deviceService.getDeviceList(reqVO);
        int listCnt = deviceService.getDeviceListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("deviceList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("DeviceReqVO", reqVO);

        return DEVICE_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = DEVICE_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceRegForm(Model model) {

        return DEVICE_REG_FORM + ADMIN_DEFAULT_SUFFIX;

    }


    @RequestMapping(value = DEVICE_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceRegAction(MultipartRequest req, @ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        reqVO.setDel_yn(YesNoType.NO.getValue());

        Map<String, Object> map = commonService.getSequence("TB_DEVICE_MASTER");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            reqVO.setNo_device((String) map.get("seq"));
        }

        boolean isRegister = false;
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            isRegister = deviceService.deviceRegAction(fileMap, reqVO);
        }

        if(isRegister) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = DEVICE_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceModForm(@ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        DeviceResVO resVO = deviceService.getDeviceInfo(reqVO);

        model.addAttribute("vo", resVO);

        return DEVICE_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = DEVICE_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceModAction(MultipartRequest req, @ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        boolean isModify = false;

        isModify = deviceService.deviceModAction(fileMap, reqVO);

        if(isModify) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = DEVICE_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceDelAction(@ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        /** tb_device_master */
        int deleteCnt = deviceService.deviceDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = DEVICE_COLOR_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeServiceList(@ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        List<DeviceResVO> deviceColorList = deviceService.getDeviceColorList(reqVO);

        model.addAttribute("deviceColorList", deviceColorList);

        return DEVICE_COLOR_LIST + ADMIN_MODAL_SUFFIX;

    }

    @RequestMapping(value = DEVICE_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String deviceListExcelDownload(@ModelAttribute("DeviceReqVO")DeviceReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_device");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<DeviceResVO> list = deviceService.getDeviceExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.상품리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }
}
