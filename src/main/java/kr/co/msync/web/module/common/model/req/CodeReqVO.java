package kr.co.msync.web.module.common.model.req;

import lombok.Data;

@Data
public class CodeReqVO {

	private String code_group;
	private String code_value;
	private String use_yn;
	private String table_name;
	private String column_name;
	private String column_pk;
	private String del_yn;
}
