package kr.co.msync.web.module.common.model.req;

import lombok.Data;

@Data
public class CloseDateReqVO {

	private String login_id;
	private String close_date;
	private String closed_user_date;
}
