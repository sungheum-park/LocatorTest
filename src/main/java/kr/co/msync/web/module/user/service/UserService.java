package kr.co.msync.web.module.user.service;

import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import kr.co.msync.web.module.user.model.req.UserReqVO;
import kr.co.msync.web.module.user.model.res.UserInfoResVO;
import kr.co.msync.web.module.user.model.res.UserResVO;

import java.util.List;
import java.util.Map;

public interface UserService {

    int userModAction(UserReqVO reqVO);
    int userRegAction(UserReqVO reqVO);
    List<UserResVO> getUserList(UserReqVO reqVO);
    List<UserResVO> getUserExcelList(UserReqVO reqVO);
    int getUserListCnt(UserReqVO reqVO);
    UserInfoResVO getUserInfo(UserInfoReqVO reqVO);
    int userDelAction(UserReqVO reqVO);
    int userApprovedAction(UserReqVO reqVO);
    int userDeniedAction(UserReqVO reqVO);
    int getUserPasswordCount(UserReqVO reqVO);
    int getUserCount(String login_id);
    int userPasswordConfirm(String no_user);
    int userPasswordModConfirm(String no_user);

}
