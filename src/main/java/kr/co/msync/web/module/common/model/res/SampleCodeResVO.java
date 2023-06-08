package kr.co.msync.web.module.common.model.res;

import lombok.Data;

@Data
public class SampleCodeResVO {

	/** SMS 테스트 */
	private int ipCnt;
	private String code;
	private String message;

	/** 공통 */
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String mod_id;
	private String mod_name;
	private String mod_date;

}
