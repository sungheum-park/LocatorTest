package kr.co.msync.web.module.common.model.req;

import lombok.Data;

@Data
public class CommonReqVO {

    /** 이력 마스터 테이블 저장*/
    private String no_hist;
    private String no_menu;
    private String no_user;
    private String action_time;
    private String action_status;
    private String no_seq;

}
