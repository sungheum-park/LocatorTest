package kr.co.msync.web.module.user.model.res;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class UserInfoResVO extends Criteria {
	private String no_user;
	private String login_id;
	private String user_name;
	private String user_en_name;
	private String email_addr;
	private String user_company;
	private String user_channel;
	private String password;
	private String user_grt;
	private String reg_way;
	private String del_yn;
	private String user_status;
	private String reg_date;
	private String mod_date;
}