package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Slf4j
public class BCryptCipherUtil {

	private static BCryptPasswordEncoder bCryptPasswordEncoder;

	/**
	 * 평문을 암호화하여 암호문으로 반환한다.
	 *
	 * @param plainText 평문
	 * @return
	 */
	public static String encode(String plainText) {
		// BCryptPasswordEncoder 인스턴스 생성
		if (bCryptPasswordEncoder == null) {
			bCryptPasswordEncoder = new BCryptPasswordEncoder();
		}

		// 평문 값이 없을 경우 빈값 리턴
		if (StringUtils.isBlank(plainText)) {
			return "";
		}

		return bCryptPasswordEncoder.encode(plainText);
	}

	/**
	 * 평문과 암호문 일치여부를 확인한다.
	 *
	 * @param plainText  평문
	 * @param cipherText 암호문
	 * @return
	 */
	public static boolean matches(String plainText, String cipherText) {
		// BCryptPasswordEncoder 인스턴스 생성
		if (bCryptPasswordEncoder == null) {
			bCryptPasswordEncoder = new BCryptPasswordEncoder();
		}

		// 평문,암호문 값 존재 여부 확인
		if (StringUtils.isBlank(plainText)) {
			return false;
		} else if (StringUtils.isBlank(cipherText)) {
			return false;
		}

		return bCryptPasswordEncoder.matches(plainText, cipherText);
	}
}