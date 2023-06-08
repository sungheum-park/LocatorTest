package kr.co.msync.web.module.store;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.ExcelDownType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.store.model.req.StoreReqVO;
import kr.co.msync.web.module.store.model.res.StoreResVO;
import kr.co.msync.web.module.store.service.StoreService;
import kr.co.msync.web.module.util.SessionUtil;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import javax.net.ssl.HttpsURLConnection;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Controller
public class StoreController extends BaseController {


    public static final String NAME = "/store";
    public static final String MAIN = NAME + "/admin";

    /** 매장 기본 */
    public static final String STORE = MAIN + "/store";

    /** 매장 리스트 */
    public static final String STORE_LIST = MAIN + "/storeList";

    /** 매장 등록 화면 */
    public static final String STORE_REG_FORM = MAIN + "/storeRegForm";

    /** 매장 등록 */
    public static final String STORE_REG_ACTION = MAIN + "/storeRegAction";

    /** 매장 복사 등록 화면 */
    public static final String STORE_COPY_REG_FORM = MAIN + "/storeCopyRegForm";

    /** 매장 복사 등록 */
    public static final String STORE_COPY_REG_ACTION = MAIN + "/storeCopyRegAction";

    /** 매장 수정 화면 */
    public static final String STORE_MOD_FORM = MAIN + "/storeModForm";

    /** 매장 수정 */
    public static final String STORE_MOD_ACTION = MAIN + "/storeModAction";

    /** 매장 삭제 */
    public static final String STORE_DEL_ACTION = MAIN + "/storeDelAction";

    /** 판매 기기 리스트 */
    public static final String STORE_SELL_DEVICE_LIST = MAIN + "/storeSellDeviceModal";

    /** 교환 기기 리스트 */
    public static final String STORE_EXCG_DEVICE_LIST = MAIN + "/storeExcgDeviceModal";

    /** 판매 기기 리스트 */
    public static final String STORE_OFFER_SERVICE_LIST = MAIN + "/storeServiceModal";

    /** 상품 코드표 리스트 */
    public static final String STORE_DEVICE_CODE_LIST = MAIN + "/storeDeviceCodeModal";

    /** 매장 일괄 수정 기본 */
    public static final String STORE_ALL = MAIN + "/storeAll";

    /** 매장 일괄 수정 리스트 */
    public static final String STORE_ALL_LIST = MAIN + "/storeAllList";

    /** 매장 일괄 등록 화면 */
    public static final String STORE_ALL_REG = MAIN + "/storeAllReg";

    /** 매장 일괄 등록 */
    public static final String STORE_All_REG_ACTION = MAIN + "/storeAllRegAction";

    /** 매장 지도 좌표 선택 */
    public static final String STORE_POSITION_MAP_MODAL = MAIN + "/storePositionModal";

    /** 키워드로 주소 검색 */
    public static final String ADDRESS_BY_KEYWORD = MAIN + "/addressByKeyword";

    /** 동기화 */
    public static final String STORE_SYNC_ACTION = MAIN + "/storeSyncAction";

    /** 서비스 엑셀 다운로드 */
    public static final String STORE_LIST_EXCEL_DOWNLOAD = MAIN + "/storeListExcelDownload";

    /** 이하 일괄 수정 모달 */

    // 모달 호출
    public static final String STORE_ALL_MOD_PARKING_FORM = MAIN + "/storeAllModParkingModal";
    public static final String STORE_ALL_MOD_TREAT_FORM = MAIN + "/storeAllModTreatModal";
    public static final String STORE_ALL_MOD_OPER_WEEK_TIME_FORM = MAIN + "/storeAllModOperWeekTimeModal";
    public static final String STORE_ALL_MOD_OPER_TIME_FORM = MAIN + "/storeAllModOperTimeModal";
    public static final String STORE_ALL_MOD_CLOSED_DATE_FORM = MAIN + "/storeAllModClosedDateModal";
    public static final String STORE_ALL_MOD_SELL_DEVICE_FORM = MAIN + "/storeAllModSellDeviceModal";
    public static final String STORE_ALL_MOD_EXCG_DEVICE_PARENT_FORM = MAIN + "/storeAllModExcgDeviceParentModal";
    public static final String STORE_ALL_MOD_EXCG_DEVICE_FORM = MAIN + "/storeAllModExcgDeviceModal";
    public static final String STORE_ALL_MOD_SERVICE_FORM = MAIN + "/storeAllModServiceModal";
    public static final String STORE_ALL_MOD_STATUS_FORM = MAIN + "/storeAllModStoreStatusModal";

    // 수정
    public static final String STORE_ALL_MOD_PARKING_ACTION = MAIN + "/storeAllModParkingAction";
    public static final String STORE_ALL_MOD_TREAT_ACTION = MAIN + "/storeAllModTreatAction";
    public static final String STORE_ALL_MOD_OPER_WEEK_TIME_ACTION = MAIN + "/storeAllModOperWeekTimeAction";
    public static final String STORE_ALL_MOD_OPER_TIME_ACTION = MAIN + "/storeAllModOperTimeAction";
    public static final String STORE_ALL_MOD_CLOSED_DATE_ACTION = MAIN + "/storeAllModClosedDateAction";
    public static final String STORE_ALL_MOD_SELL_DEVICE_ACTION = MAIN + "/storeAllModSellDeviceAction";
    public static final String STORE_ALL_MOD_EXCG_DEVICE_ACTION = MAIN + "/storeAllModExcgDeviceAction";
    public static final String STORE_ALL_MOD_SERVICE_ACTION = MAIN + "/storeAllModServiceAction";
    public static final String STORE_ALL_MOD_STATUS_ACTION = MAIN + "/storeAllModStatusAction";
    
    @Autowired
    private StoreService storeService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = STORE, method = {RequestMethod.GET, RequestMethod.POST})
    public String store(Model model) {

        StoreReqVO reqVO = new StoreReqVO();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo"); // 로그인한 사용자 정보로 권한 및 관리채널 체크

        reqVO.setUser_grt(cud.getUser_grt());
        reqVO.setStore_type_arr(cud.getUser_channel().split(",")); // 관리채널 별 검색 개수 cnt
        reqVO.setDel_yn(YesNoType.NO.getValue());

        int total_cnt = storeService.getStoreListCnt(reqVO);
        String final_mod_date = storeService.getMaxModStore();
        String final_sync_date = storeService.getStoreSyncDate();
        String final_reg_date = storeService.getMaxRegStore();

        model.addAttribute("total_cnt", total_cnt);
        model.addAttribute("final_mod_date", final_mod_date);
        model.addAttribute("final_sync_date", final_sync_date);
        model.addAttribute("final_reg_date", final_reg_date);
        model.addAttribute("inclusive_code", cud.getUser_channel());
        return STORE + ADMIN_DEFAULT_SUFFIX;

    }

    @RequestMapping(value = STORE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("store_code");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        reqVO.setUser_grt(cud.getUser_grt());
        reqVO.setStore_type_arr(cud.getUser_channel().split(",")); // 관리채널 별 검색 개수 cnt
        reqVO.setDel_yn(YesNoType.NO.getValue());

        List<StoreResVO> list = storeService.getStoreList(reqVO);
        int listCnt = storeService.getStoreListCnt(reqVO);


        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("storeList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("StoreReqVO", reqVO);

        return STORE_LIST + ADMIN_EMPTY_SUFFIX;

    }

    @RequestMapping(value = STORE_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeRegForm(Model model) {
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        model.addAttribute("inclusive_code", cud.getUser_channel());
        model.addAttribute("store_name","매장 등록");
        return STORE_REG_FORM + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = STORE_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeRegAction(MultipartRequest req, @ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setDel_yn(YesNoType.NO.getValue());
        reqVO.setClosed_date(reqVO.getClosed_date().replaceAll("&#x2F;","/"));
        reqVO.setOper_week_time(reqVO.getOper_week_time().replaceAll("&#x2F;","/"));
        reqVO.setRetail_store_code(reqVO.getRetail_store_code());

        Map<String, Object> map = commonService.getSequence("TB_STORE_MASTER");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            reqVO.setStore_code((String) map.get("seq"));
        }

        String isRegister = storeService.storeRegAction(fileMap, reqVO);

        if(isRegister.equals("true")) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else if (isRegister.equals("RETAIL_CODE_DUE")){
            model.addAttribute("resultCode", "RETAIL_CODE_DUE");
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = STORE_COPY_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeCopyRegForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        StoreResVO resVO = storeService.getStoreInfo(reqVO, null);
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        Map<String, Object> map = commonService.getSequence("TB_STORE_MASTER");
        if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
            resVO.setStore_code((String) map.get("seq"));
        }

        model.addAttribute("inclusive_code", cud.getUser_channel());
        model.addAttribute("vo", resVO);

        return STORE_COPY_REG_FORM + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = STORE_COPY_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeCopyRegAction(MultipartRequest req, @ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setDel_yn(YesNoType.NO.getValue());
        reqVO.setClosed_date(reqVO.getClosed_date().replaceAll("&#x2F;","/"));
        reqVO.setOper_week_time(reqVO.getOper_week_time().replaceAll("&#x2F;","/"));
        reqVO.setRetail_store_code(reqVO.getRetail_store_code());

        String isRegister = storeService.storeRegAction(fileMap, reqVO);

        if(isRegister.equals("true")) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else if (isRegister.equals("RETAIL_CODE_DUE")){
            model.addAttribute("resultCode", "RETAIL_CODE_DUE");
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = STORE_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeModForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        StoreResVO resVO = storeService.getStoreInfo(reqVO, ActionType.SEL.getValue());

        model.addAttribute("inclusive_code",cud.getUser_channel());
        model.addAttribute("vo", resVO);

        return STORE_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }


    @RequestMapping(value = STORE_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeModAction(MultipartRequest req, @ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        Map<String, MultipartFile> fileMap = req.getFileMap();

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setClosed_date(reqVO.getClosed_date().replaceAll("&#x2F;","/"));
        reqVO.setOper_week_time(reqVO.getOper_week_time().replaceAll("&#x2F;","/"));
        reqVO.setRetail_store_code(reqVO.getRetail_store_code());

        String isRegister = storeService.storeModAction(fileMap, reqVO);

        if(isRegister.equals("true")) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else if (isRegister.equals("RETAIL_CODE_DUE")){
            model.addAttribute("resultCode", "RETAIL_CODE_DUE");
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = STORE_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeDelAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = STORE_SELL_DEVICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeSellDeviceList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> sellDeviceList = storeService.getStoreSellDeviceList(reqVO);

        model.addAttribute("sellDeviceList", sellDeviceList);

        return STORE_SELL_DEVICE_LIST + ADMIN_MODAL_SUFFIX;

    }

    @RequestMapping(value = STORE_EXCG_DEVICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeExcgDeviceList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> sellDeviceList = storeService.getStoreExcgDeviceList(reqVO);

        model.addAttribute("changeDeviceList", sellDeviceList);

        return STORE_EXCG_DEVICE_LIST + ADMIN_MODAL_SUFFIX;

    }

    @RequestMapping(value = STORE_OFFER_SERVICE_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeServiceList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> offerServiceList = storeService.getOfferServiceList(reqVO);

        model.addAttribute("offerServiceList", offerServiceList);

        return STORE_OFFER_SERVICE_LIST + ADMIN_MODAL_SUFFIX;

    }

    /** 이하 일괄 수정 메뉴 */

    @RequestMapping(value = STORE_ALL, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAll(Model model) {

        StoreReqVO reqVO = new StoreReqVO();
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        reqVO.setUser_grt(cud.getUser_grt());
        reqVO.setStore_type_arr(cud.getUser_channel().split(",")); // 관리채널 별 검색 개수 cnt
        reqVO.setDel_yn(YesNoType.NO.getValue());

        int total_cnt = storeService.getStoreListCnt(reqVO);
        String final_mod_date = storeService.getMaxModStore();
        String final_sync_date = storeService.getStoreSyncDate();

        model.addAttribute("total_cnt", total_cnt);
        model.addAttribute("final_mod_date", final_mod_date);
        model.addAttribute("final_sync_date", final_sync_date);
        model.addAttribute("inclusive_code",cud.getUser_channel());

        return STORE_ALL + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("store_code");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setStore_type_arr(cud.getUser_channel().split(",")); // 관리채널 별 검색 개수 cnt
        reqVO.setUser_grt(cud.getUser_grt());
        reqVO.setDel_yn(YesNoType.NO.getValue());

        List<StoreResVO> list = storeService.getStoreList(reqVO);
        int listCnt = storeService.getStoreListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("storeAllList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("StoreReqVO", reqVO);

        return STORE_ALL_LIST + ADMIN_EMPTY_SUFFIX;

    }

    /** 이하 일괄 수정 모달 */
    // 모달 호출
    @RequestMapping(value = STORE_ALL_MOD_PARKING_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModParkingForm(Model model) {
        return STORE_ALL_MOD_PARKING_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_TREAT_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModTreatForm(Model model) {
        return STORE_ALL_MOD_TREAT_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_OPER_WEEK_TIME_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModOperWeekTImeForm(Model model) {
        return STORE_ALL_MOD_OPER_WEEK_TIME_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_OPER_TIME_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModOperTImeForm(Model model) {
        return STORE_ALL_MOD_OPER_TIME_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_CLOSED_DATE_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModClosedDateForm(Model model) {
        return STORE_ALL_MOD_CLOSED_DATE_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_SELL_DEVICE_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModSellDeviceForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {
        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> sellDeviceList = storeService.getStoreSellDeviceList(reqVO);

        model.addAttribute("sellDeviceList", sellDeviceList);

        return STORE_ALL_MOD_SELL_DEVICE_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_EXCG_DEVICE_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModExcgDeviceForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {
        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> changeDeviceList = storeService.getStoreExcgDeviceList(reqVO);

        model.addAttribute("changeDeviceList", changeDeviceList);

        return STORE_ALL_MOD_EXCG_DEVICE_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_EXCG_DEVICE_PARENT_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModExcgDeviceParentForm(Model model) {
        return STORE_ALL_MOD_EXCG_DEVICE_PARENT_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_SERVICE_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModServiceForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {
        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_cate");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<StoreResVO> offerServiceList = storeService.getOfferServiceList(reqVO);

        model.addAttribute("offerServiceList", offerServiceList);

        return STORE_ALL_MOD_SERVICE_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_ALL_MOD_STATUS_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModStoreStatusForm(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {
        return STORE_ALL_MOD_STATUS_FORM + ADMIN_MODAL_SUFFIX;
    }

    @RequestMapping(value = STORE_POSITION_MAP_MODAL, method = {RequestMethod.GET, RequestMethod.POST})
    public String storePositionMapModal(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        model.addAttribute("mapVO", reqVO);

        return STORE_POSITION_MAP_MODAL + ADMIN_MODAL_SUFFIX;
    }

    // 수정
    @RequestMapping(value = STORE_ALL_MOD_PARKING_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModParkingAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllParkingModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_TREAT_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModTreatAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllTreatModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_OPER_WEEK_TIME_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModOperWeekTImeAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setOper_week_time(reqVO.getOper_week_time().replaceAll("&#x2F;","/"));

        int deleteCnt = storeService.storeAllOperTimeModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_OPER_TIME_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModOperTImeAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllStoreOperTimeModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_CLOSED_DATE_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModClosedDateAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllClosedDateModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_SELL_DEVICE_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModSellDeviceAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllSellDeviceModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_EXCG_DEVICE_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModExcgDeviceAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllExcgDeviceModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_SERVICE_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeAllModServiceAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = storeService.storeAllServiceModAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = STORE_ALL_MOD_STATUS_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String getStoreAllModStatusAction(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        int deleteCnt = storeService.storeAllStatusModAction(reqVO);
        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            model.addAttribute("resultDate", reqVO.getMod_date());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";
    }

    @RequestMapping(value = ADDRESS_BY_KEYWORD, method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String,Object> getAddressByKeyword(KaKaoAddressReqVO reqVO){
        Map<String,Object> resultMap = storeService.getAddressNameByKeyword(reqVO);
        return resultMap;
    }

    @RequestMapping(value = STORE_SYNC_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> storeSyncAction(Model model) {

        Map<String, Object> map = storeService.storeSyncAction();

        return map;

    }

    @RequestMapping(value = STORE_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String storeListExcelDownload(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("store_code");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        reqVO.setUser_grt(cud.getUser_grt());
        reqVO.setStore_type_arr(cud.getUser_channel().split(","));
        reqVO.setDel_yn(YesNoType.NO.getValue());

        List<StoreResVO> list = storeService.getStoreExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.매장리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }


    /** 대량 매장 업로드 화면 */
    @RequestMapping(value = STORE_ALL_REG)
    public String storeAllReg(){
        return STORE_ALL_REG + ADMIN_DEFAULT_SUFFIX;
    }

    /** 대량 매장 업로드 */
    @RequestMapping(value = STORE_All_REG_ACTION, method = RequestMethod.POST)
    public String storeAllRegAction(MultipartHttpServletRequest multipartFile, Model model) throws Exception {
        MultipartFile file = multipartFile.getFile("file_upload");
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        Map map = new HashMap<>();
        map.put("regId", cud.getNo_user());
        map.put("regName", cud.getUser_name());
        String result;

        try{
            result = storeService.getAllRegAction(file, map);
        }catch(Exception e){
            result = e.getMessage();
        }

        String final_reg_date = storeService.getMaxRegStore();
        model.addAttribute("result", result);
        model.addAttribute("final_reg_date", final_reg_date);

        return "jsonView";
    }

    /** 대량 매장 업로드 - 상품 코드표 확인 */
    @RequestMapping(value = STORE_DEVICE_CODE_LIST)
    public String storeDeviceCodeList(@ModelAttribute("StoreReqVO")StoreReqVO reqVO, Model model){
        List<StoreResVO> sellDeviceList = storeService.getStoreSellDeviceList(reqVO); // 판매기기
        List<StoreResVO> changeDeviceList = storeService.getStoreExcgDeviceList(reqVO); // 교환기기
        List<StoreResVO> offerServiceList = storeService.getOfferServiceList(reqVO); // 매장 서비스
        List<Map> colorAllList = storeService.getColorCodeList(); // 컬러
        model.addAttribute("sellDeviceList", sellDeviceList);
        model.addAttribute("changeDeviceList", changeDeviceList);
        model.addAttribute("offerServiceList", offerServiceList);
        model.addAttribute("colorAllList", colorAllList);
        return STORE_DEVICE_CODE_LIST + ADMIN_MODAL_SUFFIX;
    }

}
