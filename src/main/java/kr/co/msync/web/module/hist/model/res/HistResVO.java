package kr.co.msync.web.module.hist.model.res;

import lombok.Data;

import java.util.List;

@Data
public class HistResVO {

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

	private List<MasterResVO> masterVO;

}
