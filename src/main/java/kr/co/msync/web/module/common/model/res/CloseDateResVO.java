package kr.co.msync.web.module.common.model.res;

import lombok.Data;

@Data
public class CloseDateResVO {

	private String login_id;
	private String close_date;
	private String closed_user_date;
	private int cnt;
}
