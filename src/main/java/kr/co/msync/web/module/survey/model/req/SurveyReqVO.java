package kr.co.msync.web.module.survey.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class SurveyReqVO extends Criteria {

    private String id;
    private String ip_addr;
    private String score;
    private String device_type;
    private String reg_date;
    private String reg_date_start;
    private String reg_date_end;

}
