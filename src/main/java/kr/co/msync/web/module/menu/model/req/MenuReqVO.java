package kr.co.msync.web.module.menu.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class MenuReqVO extends Criteria {

	private String no_menu;
	private String menu_name;
	private String menu_level;
	private String menu_p_no;
	private String menu_sno;
	private String menu_url;
	private String use_yn;
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
	private String no_user;
	private String write_grt;
}
