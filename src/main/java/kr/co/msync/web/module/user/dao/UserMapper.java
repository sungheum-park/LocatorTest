package kr.co.msync.web.module.user.dao;

import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import kr.co.msync.web.module.user.model.req.UserReqVO;
import kr.co.msync.web.module.user.model.res.UserInfoResVO;
import kr.co.msync.web.module.user.model.res.UserResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {

    List<UserResVO> getUserList(UserReqVO reqVO);
    List<UserResVO> getUserExcelList(UserReqVO reqVO);
    int getUserListCnt(UserReqVO reqVO);
	Integer userRegAction(UserReqVO reqVO);
	Integer userModAction(UserReqVO reqVO);
    UserInfoResVO getUserInfo(UserInfoReqVO reqVO);
    int userDelAction(UserReqVO reqVO);
    int userApprovedAction(UserReqVO reqVO);
    int userDeniedAction(UserReqVO reqVO);
    int getUserCount(String login_id);
    int userGrtRegAction(UserReqVO reqVO);
    int userRegPwdHist(UserReqVO reqVO);
    int getUserPasswordCount(UserReqVO reqVO);
    int userPasswordConfirm(String no_user);
    int userPasswordModConfirm(String no_user);

}