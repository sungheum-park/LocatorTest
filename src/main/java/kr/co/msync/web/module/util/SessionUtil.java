package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * 세션 관련 유틸
 *
 * @author swpark
 */
@Slf4j
public class SessionUtil {

	/**
	 * 세션을 생성한다.
	 *
	 * @param name  세션 이름
	 * @param value 세션 값
	 */
	public static void setSession(String name, Object value) {
		try {
			RequestContextHolder.getRequestAttributes().setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
		} catch (IllegalStateException e) {
			log.error("## setSession() 에러 발생", e);
		}
	}

	/**
	 * 세션을 삭제한다.
	 *
	 * @param name 세션 이름
	 */
	public static void removeSession(String name) {
		try {
			RequestContextHolder.getRequestAttributes().removeAttribute(name, RequestAttributes.SCOPE_SESSION);
		} catch (IllegalStateException e) {
			log.error("## removeSession() 에러 발생", e);
		}
	}

	/**
	 * 세션 값을 가져온다.
	 *
	 * @param name 세션 이름
	 * @return
	 */
	public static Object getSession(String name) {
		try {
			return RequestContextHolder.getRequestAttributes().getAttribute(name, RequestAttributes.SCOPE_SESSION);
		} catch (IllegalStateException e) {
			log.error("## getSession() 에러 발생", e);
			return null;
		}
	}
}
