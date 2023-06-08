package kr.co.msync.web.module.security;

import kr.co.msync.web.module.common.model.req.CloseDateReqVO;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.model.res.CloseDateResVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.AuthType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.store.StoreController;
import kr.co.msync.web.module.user.UserController;
import kr.co.msync.web.module.util.SessionUtil;
import kr.co.msync.web.module.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Autowired
	private CommonService commonService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res, Authentication auth) throws IOException, ServletException {
		resetLoginRetryCount(req);
		String redirectUrl;
		String roleRule = (String) SessionUtil.getSession("roleRule");

		// 잠김 계정인지 확인
		String login_id = req.getParameter("login_id");
		CloseDateReqVO vo = new CloseDateReqVO();
		vo.setLogin_id(login_id);

		CloseDateResVO resVO = commonService.getCloseUser(vo);

		if(resVO.getCnt()>0){
			SessionUtil.removeSession("roleRule");
			SessionUtil.setSession("alertMsg", resVO.getClosed_user_date() + "이후에 다시 시도해 주세요.");
			redirectUrl = UserController.LOGIN;
		} else if (roleRule == null) {
			SessionUtil.removeSession("roleRule");
			SessionUtil.setSession("alertMsg", "접근권한이 없습니다.\\n관리자에게 문의하세요.");
			redirectUrl = UserController.LOGIN;

		} else {
			SessionUtil.removeSession("roleRule");
			SessionUtil.setSession("userInfo", auth.getPrincipal());
			redirectUrl = StoreController.STORE;
			CustomUserDetails cud = (CustomUserDetails) auth.getPrincipal();
			if(cud.getUser_grt().equals(AuthType.MANAGER.getValue())){
				redirectUrl = UserController.USER;
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_user(cud.getNo_user());
			histVO.setNo_menu(HistMenuType.사용자.getValue());
			histVO.setAction_time(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
			histVO.setAction_status(ActionType.CON.getValue());
			histVO.setNo_seq(cud.getNo_user());

			commonService.regHistoryAction(histVO);

			commonService.initCloseUser(cud.getLogin_id());

		}

		redirectStrategy.sendRedirect(req, res, redirectUrl);
	}

	/**
	 * 로그인 시도 횟수 초기화
	 */
	private void resetLoginRetryCount(HttpServletRequest req) {
		req.getSession(true).removeAttribute("loginFailCount");
	}
}