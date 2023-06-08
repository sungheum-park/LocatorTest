package kr.co.msync.web.module.security;

import kr.co.msync.web.module.common.model.req.CloseDateReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.user.UserController;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Autowired
	private CommonService commonService;

	@Setter
	private Integer loginFailureLimit;

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res, AuthenticationException exception) throws IOException, ServletException {
		if (updateLoginRetryCount(req) > loginFailureLimit) {
			// 계정 잠김
			String login_id = req.getParameter("login_id");
			CloseDateReqVO vo = new CloseDateReqVO();
			vo.setLogin_id(login_id);
			commonService.updateClosedUser(vo);

			req.getSession().setAttribute("alertMsg", vo.getClosed_user_date() + "이후에 다시 시도해 주세요.");
			redirectStrategy.sendRedirect(req, res, UserController.LOGIN);
		} else {
			req.getSession().setAttribute("alertMsg", "로그인 실패");
			redirectStrategy.sendRedirect(req, res, UserController.LOGIN);
		}
	}

	/**
	 * 로그인 시도 횟수 증가
	 */
	private int updateLoginRetryCount(HttpServletRequest req) {
		Object loginFailCountObj = req.getSession().getAttribute("loginFailCount");
		int failCount;
		if (loginFailCountObj == null) {
			failCount = 0;
		} else {
			failCount = (int) loginFailCountObj;
		}
		failCount++;
		req.getSession().setAttribute("loginFailCount", failCount);

		return failCount;
	}
}