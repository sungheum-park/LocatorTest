package kr.co.msync.web.module.common.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class SampleCodeReqVO extends Criteria {

	/** 로그 테스트 */
	private String ipAddr;
	private String uId;
	private final int MAX_SMS_CALL_CNT = 10;

}
