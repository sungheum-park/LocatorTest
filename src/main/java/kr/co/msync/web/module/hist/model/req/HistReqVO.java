package kr.co.msync.web.module.hist.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class HistReqVO extends Criteria {

    private String no_hist;
    private String no_menu;
    private String no_user;
    private String action_status;
    private String action_time;
    private String action_time_start;
    private String action_time_end;
    private String login_id;
    private String user_name;
    private String user_grt;

    private String[] check_no_hist;
    private String select_action_status;

}
