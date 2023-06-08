package kr.co.msync.web.module.util;

import kr.co.msync.web.module.common.type.AuthType;
import kr.co.msync.web.module.user.model.req.UserInfoReqVO;
import org.apache.commons.lang.StringUtils;

public class UserValidationUtil {
	// 회원가입 유효성 검사
	public static boolean isValidationUserInfo(UserInfoReqVO userInfoReqVO) {
		if (userInfoReqVO.getLogin_id() == null || userInfoReqVO.getPassword() == null) {
			return true;
		}
		if (userInfoReqVO.getLogin_id().length() < 5 || userInfoReqVO.getLogin_id().length() > 16) {
			return true;
		}
		if (userInfoReqVO.getPassword().length() < 5 || userInfoReqVO.getPassword().length() > 16) {
			return true;
		}
		return false;
	}

	// 회원정보 암호화
	public static UserInfoReqVO encryptedUserInfo(UserInfoReqVO userInfoReqVO) {
		if (userInfoReqVO.getUser_grt() == null || userInfoReqVO.getUser_grt().equals(AuthType.ADMIN.getValue())) {
			userInfoReqVO.setUser_grt(AuthType.USER.getValue());
		}
		if (userInfoReqVO.getPassword() != null || !(userInfoReqVO.getPassword().equals(""))) {
			userInfoReqVO.setPassword(StringUtils.defaultString(userInfoReqVO.getPassword()).replaceAll("\\p{Z}", ""));
			userInfoReqVO.setPassword(Sha256Util.encrypt(userInfoReqVO.getPassword()));
		}
		return userInfoReqVO;
	}

	// Tag 공격 방지
	public static UserInfoReqVO convertUserInfo(UserInfoReqVO userInfoReqVO) {
		if (userInfoReqVO.getLogin_id() != null || !(userInfoReqVO.getLogin_id().equals(""))) {
			userInfoReqVO.setLogin_id(StringUtils.defaultString(userInfoReqVO.getLogin_id()).replaceAll("\\p{Z}", ""));
			userInfoReqVO.setLogin_id(userInfoReqVO.getLogin_id().replace("<", "&lt;").replace(">", "&gt;"));
			userInfoReqVO.setLogin_id(userInfoReqVO.getLogin_id().replace("'", "&quot;").replace("\"", "&#39;"));
		}
		if (userInfoReqVO.getUser_name() != null || !(userInfoReqVO.getUser_name().equals(""))) {
			userInfoReqVO.setUser_name(StringUtils.defaultString(userInfoReqVO.getUser_name()).replaceAll("\\p{Z}", ""));
			userInfoReqVO.setUser_name(userInfoReqVO.getUser_name().replace("<", "&lt;").replace(">", "&gt;"));
			userInfoReqVO.setUser_name(userInfoReqVO.getUser_name().replace("'", "&quot;").replace("\"", "&#39;"));
		}
		return userInfoReqVO;
	}
}