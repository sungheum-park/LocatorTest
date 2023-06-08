package kr.co.msync.web.module.security;

import kr.co.msync.web.module.util.BCryptCipherUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.security.SecureRandom;

@Slf4j
public class CustomPasswordEncoder extends BCryptPasswordEncoder implements PasswordEncoder {
	public CustomPasswordEncoder() {
		super();
	}

	public CustomPasswordEncoder(int strength) {
		super(strength, new SecureRandom());
	}

	@Override
	public String encode(CharSequence rawPassword) {
		rawPassword = BCryptCipherUtil.encode(rawPassword.toString());
		return super.encode(rawPassword);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		return BCryptCipherUtil.matches(rawPassword.toString(), encodedPassword);
	}
}