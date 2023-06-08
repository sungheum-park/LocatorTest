package kr.co.msync.web.module.user.model.req;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AuthReqVO {
	private String no_user;
	private String user_grt;
}