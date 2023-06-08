package kr.co.msync.web.module.user.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class UserReqVO extends Criteria {
	private String no_user;
	private String check_no_user;
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
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String reg_date_start;
	private String reg_date_end;
	private String mod_id;
	private String mod_name;
	private String mod_date;
	private String mod_date_start;
	private String mod_date_end;
	private String last_pwd_mod_date;
	private String no_menu;
	private String write_grt;
}