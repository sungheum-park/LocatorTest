package kr.co.msync.web.module.security;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class CustomUserDetails implements UserDetails {
	public CustomUserDetails(Collection<? extends GrantedAuthority> authorities,
                             String no_user, String login_id, String user_name, String user_company, String user_channel, String password, String user_grt, String reg_way, String user_status, String reg_date, String mod_date,
                             boolean accountNonExpired, boolean accountNonLocked, boolean credentialsNonExpired, boolean enabled) {
		this.authorities = authorities;
		this.no_user = no_user;
		this.login_id = login_id;
		this.user_name = user_name;
		this.user_company = user_company;
		this.user_channel = user_channel;
		this.password = password;
		this.user_grt = user_grt;
		this.reg_way = reg_way;
		this.user_status = user_status;
		this.reg_date = reg_date;
		this.mod_date = mod_date;
		this.accountNonExpired = accountNonExpired;
		this.accountNonLocked = accountNonLocked;
		this.credentialsNonExpired = credentialsNonExpired;
		this.enabled = enabled;
	}

	@Getter
	private final Collection<? extends GrantedAuthority> authorities;
	@Getter
	private final String no_user;
	@Getter
	private final String login_id;
	@Getter
	private final String user_name;
	@Getter
	private final String user_company;
	@Getter
	private final String user_channel;
	@Getter
	private final String password;
	@Getter
	private final String user_grt;
	@Getter
	private final String reg_way;
	@Getter
	private final String user_status;
	@Getter
	private final String reg_date;
	@Getter
	private final String mod_date;

	@Getter
	private final boolean accountNonExpired;
	@Getter
	private final boolean accountNonLocked;
	@Getter
	private final boolean credentialsNonExpired;
	@Getter
	private final boolean enabled;

	@Override
	public String getUsername() {
		return this.login_id;
	}

	@Override
	public String getPassword() {
		return this.password;
	}
}
