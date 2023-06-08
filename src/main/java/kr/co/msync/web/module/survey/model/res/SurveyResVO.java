package kr.co.msync.web.module.survey.model.res;

import lombok.Data;

@Data
public class SurveyResVO {

	private String id;
	private String ip_addr;
	private String score;
	private String device_type;
	private String reg_date;

}
