package kr.co.msync.web.module.user;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.common.model.PageMaker;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.*;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.store.StoreController;
import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import kr.co.msync.web.module.user.model.req.UserReqVO;
import kr.co.msync.web.module.user.model.res.UserInfoResVO;
import kr.co.msync.web.module.user.model.res.UserResVO;
import kr.co.msync.web.module.user.service.UserService;
import kr.co.msync.web.module.util.DateUtil;
import kr.co.msync.web.module.util.SessionUtil;
import kr.co.msync.web.module.util.Sha256Util;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
public class UserController extends BaseController{


    public static final String NAME = "/user";
    public static final String MAIN = NAME + "/admin";

    /** 로그인 페이지 */
    public static final String LOGIN = MAIN + "/login";

    /** 로그아웃 페이지 */
    public static final String LOGOUT = MAIN + "/logout";

    /** 로그인 액션 */
    public static final String LOGIN_ACTION = MAIN + "/loginAction";

    /** 운영자 페이지 */
    public static final String USER = MAIN + "/user";

    /** 운영자 리스트 페이지 */
    public static final String USER_LIST = MAIN + "/userList";

    /** 운영자 등록 폼 */
    public static final String USER_REG_FORM = MAIN + "/userRegForm";

    /** 운영자 등록 */
    public static final String USER_REG_ACTION = MAIN + "/userRegAction";

    /** 운영자 수정 폼 */
    public static final String USER_MOD_FORM = MAIN + "/userModForm";

    /** 운영자 수정 */
    public static final String USER_MOD_ACTION = MAIN + "/userModAction";

    /** 운영자 수정 */
    public static final String IS_PWD_MOD = MAIN + "/isPasswordMod";

    /** 운영자 삭제 */
    public static final String USER_DEL_ACTION = MAIN + "/userDelAction";

    /** 승인 */
    public static final String USER_APPROVED_ACTION = MAIN + "/userApprovedAction";

    /** 반려 */
    public static final String USER_DENIED_ACTION = MAIN + "/userDeniedAction";

    /** 운영자 엑셀 다운로드 */
    public static final String USER_LIST_EXCEL_DOWNLOAD = MAIN + "/userListExcelDownload";

    @Autowired
    private UserService userService;

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = USER, method = {RequestMethod.GET, RequestMethod.POST})
    public String user(Model model) {
        UserReqVO reqVO = new UserReqVO();
        int total_cnt = userService.getUserListCnt(reqVO);
        model.addAttribute("total_cnt", total_cnt);
        return USER + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = USER_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String userList(@ModelAttribute("UserReqVO")UserReqVO reqVO, Model model) {
        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_user");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<UserResVO> list = userService.getUserList(reqVO);
        int listCnt = userService.getUserListCnt(reqVO);

        PageMaker pageMaker = new PageMaker();
        pageMaker.setPage(reqVO.getPage());
        pageMaker.setPerPageNum(reqVO.getPerPageNum());
        pageMaker.setTotalCount(listCnt);

        model.addAttribute("userList", list);
        model.addAttribute("pageMaker", pageMaker);
        model.addAttribute("UserReqVO", reqVO);

        return USER_LIST + ADMIN_EMPTY_SUFFIX;
    }

    @RequestMapping(value = LOGIN, method = {RequestMethod.GET, RequestMethod.POST})
    public String login() {
        if (SessionUtil.getSession("userInfo") == null) {
            log.info("## Login {}", DateUtil.getCurrentDateTime(DateUtil.DATE_MSC_PATTERN));

            return LOGIN + ADMIN_LOGIN_SUFFIX;
        } else {
            String redirectUrl = StoreController.STORE;
            CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
            if(cud.getUser_grt().equals(AuthType.MANAGER.getValue())){
                redirectUrl = UserController.USER;
            }
            return "redirect:" + redirectUrl;
        }
    }

    @RequestMapping(value = LOGOUT, method = {RequestMethod.GET, RequestMethod.POST})
    public String logout() {
        log.info("## Logout {}", DateUtil.getCurrentDateTime(DateUtil.DATE_MSC_PATTERN));

        return "redirect:" + LOGIN;
    }

    @RequestMapping(value = USER_REG_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String userRegForm(Model model) {
        model.addAttribute("userInfo", SessionUtil.getSession("userInfo"));
        return USER_REG_FORM + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = USER_REG_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String userRegAction(UserReqVO reqVO, Model model) {
        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setReg_id(cud.getNo_user());
        reqVO.setReg_name(cud.getUser_name());
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        reqVO.setLast_pwd_mod_date(reqVO.getReg_date());

        reqVO.setUser_status(UserStatusType.대기.getValue());

        reqVO.setDel_yn(YesNoType.NO.getValue());
        reqVO.setReg_way("01");

        int insertCnt = 0;

        int idCnt = userService.getUserCount(reqVO.getLogin_id());

        if(idCnt>0) {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
            model.addAttribute("resultMessage", "이미 존재하는 아이디 입니다.");
        } else {
            Map<String, Object> map = commonService.getSequence("TB_USER");
            if(ResultType.SUCCESS.getValue().equals(map.get("code"))){
                reqVO.setNo_user((String) map.get("seq"));
                insertCnt = userService.userRegAction(reqVO);
            }

            if(insertCnt > 0) {
                model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            } else {
                model.addAttribute("resultCode", ResultType.FAIL.getValue());
                model.addAttribute("resultMessage", "다시 시도해 주세요.");
            }
        }

        return "jsonView";
    }

    @RequestMapping(value = USER_MOD_FORM, method = {RequestMethod.GET, RequestMethod.POST})
    public String userModForm(@ModelAttribute("UserInfoReqVO")UserInfoReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        UserInfoResVO resVO = userService.getUserInfo(reqVO);
        model.addAttribute("vo", resVO);
        return USER_MOD_FORM + ADMIN_DEFAULT_SUFFIX;
    }

    @RequestMapping(value = USER_MOD_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String userModAction(UserReqVO reqVO, Model model) {

        int passwordCount = 0;
        int passwordModCount = 0;

        if(StringUtils.isNotBlank(reqVO.getPassword())) {
            passwordCount = userService.getUserPasswordCount(reqVO);
            passwordModCount = userService.userPasswordModConfirm(reqVO.getNo_user());
        }

        if(passwordCount>0) {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
            model.addAttribute("resultMessage", "최근 10회 이전에 설정한 비밀번호는 재설정 할 수 없습니다.");
        } else if(passwordModCount>0) {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
            model.addAttribute("resultMessage", "비밀번호 변경 후, 24시간 이내에는 변경하실 수 없습니다.");
        } else {
            int updateCnt = userService.userModAction(reqVO);
            if(updateCnt > 0) {
                model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
            } else {
                model.addAttribute("resultCode", ResultType.FAIL.getValue());
                model.addAttribute("resultMessage", "저장 중 에러가 발생했습니다.");
            }
        }

        return "jsonView";
    }

    @RequestMapping(value = IS_PWD_MOD, method = RequestMethod.POST)
    public String isPasswordMod(Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");

        int updateCnt = userService.userPasswordConfirm(cud.getNo_user());

        if(updateCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }
        return "jsonView";
    }

    @RequestMapping(value = USER_DEL_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String userDelAction(@ModelAttribute("UserReqVO")UserReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = userService.userDelAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }


    @RequestMapping(value = USER_APPROVED_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String userApprovedAction(@ModelAttribute("UserReqVO")UserReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = userService.userApprovedAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = USER_DENIED_ACTION, method = {RequestMethod.GET, RequestMethod.POST})
    public String userDeniedAction(@ModelAttribute("UserReqVO")UserReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        int deleteCnt = userService.userDeniedAction(reqVO);

        if(deleteCnt > 0) {
            model.addAttribute("resultCode", ResultType.SUCCESS.getValue());
        } else {
            model.addAttribute("resultCode", ResultType.FAIL.getValue());
        }

        return "jsonView";

    }

    @RequestMapping(value = USER_LIST_EXCEL_DOWNLOAD, method = {RequestMethod.GET, RequestMethod.POST})
    public String userListExcelDownload(@ModelAttribute("UserReqVO")UserReqVO reqVO, Model model) {

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("no_user");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("desc");
        }

        List<UserResVO> list = userService.getUserExcelList(reqVO);

        model.addAttribute("excelDownType", ExcelDownType.운영자리스트.getValue());
        model.addAttribute("excelList", list);

        return "excelDownload";

    }

}
