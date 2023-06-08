package kr.co.msync.web.module.user.service.impl;

import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.AuthType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.common.type.UserStatusType;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import kr.co.msync.web.module.user.model.req.UserReqVO;
import kr.co.msync.web.module.user.model.res.UserInfoResVO;
import kr.co.msync.web.module.user.dao.UserMapper;
import kr.co.msync.web.module.user.model.res.UserResVO;
import kr.co.msync.web.module.user.service.UserService;
import kr.co.msync.web.module.util.BCryptCipherUtil;
import kr.co.msync.web.module.util.SessionUtil;
import kr.co.msync.web.module.util.Sha256Util;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service("userService")
@Transactional
public class UserServiceImpl implements UserService{

    @Autowired
    private CommonService commonService;

    @Autowired
    private UserMapper userMapper;

    @Override
    public int userRegAction(UserReqVO reqVO) {

        reqVO.setPassword(Sha256Util.encrypt(reqVO.getPassword()));

        int resultCnt =userMapper.userRegAction(reqVO);
        userMapper.userRegPwdHist(reqVO);


        /** 메뉴 권한 하드코딩 */
        List<String> no_menu_array = new ArrayList<String>();

        if(AuthType.ADMIN.getValue().equals(reqVO.getUser_grt())) {
            no_menu_array.add("001");
            no_menu_array.add("002");
            no_menu_array.add("003");
            no_menu_array.add("004");
            no_menu_array.add("005");
            no_menu_array.add("006");
            no_menu_array.add("007");
            no_menu_array.add("008");
            no_menu_array.add("009");
            no_menu_array.add("010");
            no_menu_array.add("011");
            no_menu_array.add("012");
            no_menu_array.add("013");
            no_menu_array.add("014");
            no_menu_array.add("015");
            no_menu_array.add("016");
            no_menu_array.add("017");
            no_menu_array.add("018");
            no_menu_array.add("019");
            no_menu_array.add("020");
            no_menu_array.add("021");
            no_menu_array.add("022");
            no_menu_array.add("023");
            no_menu_array.add("024");
            no_menu_array.add("025");
            no_menu_array.add("026");
            no_menu_array.add("027");
            no_menu_array.add("028");
            no_menu_array.add("029");
            no_menu_array.add("031");
        } else if(AuthType.MANAGER.getValue().equals(reqVO.getUser_grt())) {
            no_menu_array.add("018");
            no_menu_array.add("019");
            no_menu_array.add("020");
            no_menu_array.add("021");
            no_menu_array.add("022");
            no_menu_array.add("023");
            no_menu_array.add("024");
            no_menu_array.add("025");
            no_menu_array.add("026");
            no_menu_array.add("027");
            no_menu_array.add("028");
            no_menu_array.add("029");
            no_menu_array.add("030");
        } else if(AuthType.USER.getValue().equals(reqVO.getUser_grt())) {
            no_menu_array.add("012");
            no_menu_array.add("013");
            no_menu_array.add("014");
            no_menu_array.add("015");
            no_menu_array.add("016");
            no_menu_array.add("017");
            no_menu_array.add("031");
        }

        for(int i = 0 ; i < no_menu_array.size() ; i++) {
            UserReqVO grtVO = new UserReqVO();
            grtVO.setNo_menu(no_menu_array.get(i));
            grtVO.setNo_user(reqVO.getNo_user());
            grtVO.setWrite_grt("01");
            resultCnt += userMapper.userGrtRegAction(grtVO);
        }

        CommonReqVO histVO = new CommonReqVO();

        histVO.setNo_menu(HistMenuType.사용자.getValue());
        histVO.setNo_user(reqVO.getReg_id());
        histVO.setAction_time(reqVO.getReg_date());
        histVO.setAction_status(ActionType.REG.getValue());
        histVO.setNo_seq(reqVO.getNo_user());

        commonService.regHistoryAction(histVO);

        return resultCnt;
    }

    @Override
    public int userModAction(UserReqVO reqVO) {

        UserInfoReqVO infoReqVO = new UserInfoReqVO();
        infoReqVO.setNo_user(reqVO.getNo_user());

        UserInfoResVO infoVO = userMapper.getUserInfo(infoReqVO);

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setMod_id(cud.getNo_user());
        reqVO.setMod_name(cud.getUser_name());
        reqVO.setMod_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        if(StringUtils.isNotBlank(reqVO.getUser_channel())) {
            if(!infoVO.getUser_channel().equals(reqVO.getUser_channel())){
                reqVO.setUser_status(UserStatusType.대기.getValue());
            }
        }

        if(StringUtils.isNotBlank(reqVO.getPassword())){
            if(!infoVO.getPassword().equals(reqVO.getPassword())){
                reqVO.setLast_pwd_mod_date(reqVO.getMod_date());
            }
        }

        int resultCnt = userMapper.userModAction(reqVO);
        reqVO.setReg_date(reqVO.getMod_date());
        reqVO.setLogin_id(infoVO.getLogin_id());

        if(reqVO.getPassword()==null || reqVO.getPassword().equals("")){
            reqVO.setPassword(infoVO.getPassword());
        }
         userMapper.userRegPwdHist(reqVO);
        CommonReqVO histVO = new CommonReqVO();

        histVO.setNo_menu(HistMenuType.사용자.getValue());
        histVO.setNo_user(reqVO.getMod_id());
        histVO.setAction_time(reqVO.getMod_date());
        histVO.setAction_status(ActionType.MOD.getValue());
        histVO.setNo_seq(reqVO.getNo_user());

        commonService.regHistoryAction(histVO);

        return resultCnt;
    }

    @Override
    public List<UserResVO> getUserList(UserReqVO reqVO) {
        return userMapper.getUserList(reqVO);
    }

    @Override
    public List<UserResVO> getUserExcelList(UserReqVO reqVO) {
        return userMapper.getUserExcelList(reqVO);
    }

    @Override
    public int getUserListCnt(UserReqVO reqVO) {
        return userMapper.getUserListCnt(reqVO);
    }

    @Override
    public UserInfoResVO getUserInfo(UserInfoReqVO reqVO) {
        CommonReqVO histVO = new CommonReqVO();

        histVO.setNo_menu(HistMenuType.사용자.getValue());
        histVO.setNo_user(reqVO.getMod_id());
        histVO.setAction_time(reqVO.getMod_date());
        histVO.setAction_status(ActionType.SEL.getValue());
        histVO.setNo_seq(reqVO.getNo_user());

        commonService.regHistoryAction(histVO);

        return userMapper.getUserInfo(reqVO);
    }

    @Override
    public int userDelAction(UserReqVO reqVO) {
        int resultCnt = 0;

        for(String s : reqVO.getCheck_no_user().split(",")) {
            UserReqVO vo = new UserReqVO();
            vo.setNo_user(s);

            resultCnt += userMapper.userDelAction(vo);

            CommonReqVO histVO = new CommonReqVO();

            histVO.setNo_menu(HistMenuType.사용자.getValue());
            histVO.setNo_user(reqVO.getMod_id());
            histVO.setAction_time(reqVO.getMod_date());
            histVO.setAction_status(ActionType.DEL.getValue());
            histVO.setNo_seq(s);

            commonService.regHistoryAction(histVO);

        }

        return resultCnt;

    }

    @Override
    public int userApprovedAction(UserReqVO reqVO) {

        int resultCnt = 0;

        for(String s : reqVO.getCheck_no_user().split(",")) {
            UserReqVO vo = new UserReqVO();
            vo.setNo_user(s);

            resultCnt += userMapper.userApprovedAction(vo);

            CommonReqVO histVO = new CommonReqVO();

            histVO.setNo_menu(HistMenuType.사용자.getValue());
            histVO.setNo_user(reqVO.getMod_id());
            histVO.setAction_time(reqVO.getMod_date());
            histVO.setAction_status(ActionType.MOD.getValue());
            histVO.setNo_seq(s);

            commonService.regHistoryAction(histVO);

        }

        return resultCnt;
    }

    @Override
    public int userDeniedAction(UserReqVO reqVO) {

        int resultCnt = 0;

        for(String s : reqVO.getCheck_no_user().split(",")) {
            UserReqVO vo = new UserReqVO();
            vo.setNo_user(s);

            resultCnt += userMapper.userDeniedAction(vo);

            CommonReqVO histVO = new CommonReqVO();

            histVO.setNo_menu(HistMenuType.사용자.getValue());
            histVO.setNo_user(reqVO.getMod_id());
            histVO.setAction_time(reqVO.getMod_date());
            histVO.setAction_status(ActionType.MOD.getValue());
            histVO.setNo_seq(s);

            commonService.regHistoryAction(histVO);

        }

        return resultCnt;
    }

    @Override
    public int getUserPasswordCount(UserReqVO reqVO) {
        reqVO.setPassword(Sha256Util.encrypt(reqVO.getPassword()));

        return userMapper.getUserPasswordCount(reqVO);

    }

    @Override
    public int getUserCount(String login_id) {
        return userMapper.getUserCount(login_id);
    }

    @Override
    public int userPasswordConfirm(String no_user) {
        return userMapper.userPasswordConfirm(no_user);
    }

    @Override
    public int userPasswordModConfirm(String no_user) {
        return userMapper.userPasswordModConfirm(no_user);
    }

}
