package kr.co.msync.web.module.service;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.service.model.res.ServiceResVO;
import kr.co.msync.web.module.service.service.ServiceService;
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
public class ServiceController extends BaseController {


    public static final String NAME = "/service";
    public static final String MAIN = NAME + "/admin";

    /** 서비스 기본 */
    public static final String SERVICE = MAIN + "/service";

    /** 서비스 리스트 */
    public static final String SERVICE_LIST = MAIN + "/serviceList";

    /** 서비스 등록 화면 */
    public static final String SERVICE_REG_FORM = MAIN + "/serviceRegForm";

    /** 서비스 등록 */
    public static final String SERVICE_REG_ACTION = MAIN + "/serviceRegAction";

    /** 서비스 수정 화면 */
    public static final String SERVICE_MOD_FORM = MAIN + "/serviceModForm";

    /** 서비스 수정 */
    public static final String SERVICE_MOD_ACTION = MAIN + "/serviceModAction";

    /** 서비스 삭제 */
    public static final String SERVICE_DEL_ACTION = MAIN + "/serviceDelAction";
    
    /** 서비스 엑셀 다운로드 */
    public static final String SERVICE_LIST_EXCEL_DOWNLOAD = MAIN + "/serviceListExcelDownload";
    
    @Autowired
    private ServiceService serviceService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = SERVICE, method = {RequestMethod.GET, RequestMethod.POST})
    public String service(Model model) {

        ServiceReqVO reqVO = new ServiceReqVO();
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");


        int total_cnt = serviceService.getServiceListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);

        return SERVICE + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = SERVICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceList(@ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_service");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<ServiceResVO> list = serviceService.getServiceList(reqVO);
        int listCnt = serviceService.getServiceListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("serviceList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("ServiceReqVO", reqVO);

        return SERVICE_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = SERVICE_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceRegForm(Model model) {

        model.addAttribute("service_name","서비스 등록");
        return SERVICE_REG_FORM + ADMIN_DEFAULT_SUFFIX;

    }


    @RequestMapping(value = SERVICE_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceRegAction(MultipartRequest req, @ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        Map<String, Object> map = commonService.getSequence("TB_SERVICE");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            reqVO.setNo_service((String) map.get("seq"));
        }

        boolean isRegister = serviceService.serviceRegAction(fileMap, reqVO);

        if(isRegister) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = SERVICE_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String SERVICE_MOD_FORM(@ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        ServiceResVO resVO = serviceService.getServiceInfo(reqVO);

        model.addAttribute("vo", resVO);

        return SERVICE_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = SERVICE_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceModAction(MultipartRequest req, @ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        boolean isModify = serviceService.serviceModAction(fileMap, reqVO);

        if(isModify) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = SERVICE_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceDelAction(@ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = serviceService.serviceDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = SERVICE_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String serviceListExcelDownload(@ModelAttribute("ServiceReqVO")ServiceReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_service");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<ServiceResVO> list = serviceService.getServiceExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.서비스리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }

}
