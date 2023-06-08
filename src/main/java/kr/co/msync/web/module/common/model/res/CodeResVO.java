package kr.co.msync.web.module.common.model.res;

import lombok.Data;

@Data
public class CodeResVO {

	private String code_group;
	private String code_value;
	private String code_name;
	private int code_sno;
	private String use_yn;
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String mod_id;
	private String mod_name;
	private String mod_date;

	private String column_name;
	private String column_pk;

}
