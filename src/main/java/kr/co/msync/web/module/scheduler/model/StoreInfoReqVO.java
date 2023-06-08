package kr.co.msync.web.module.scheduler.model;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class StoreInfoReqVO extends Criteria{

    private String store_code;
    private String store_type;
    private String store_name;
    private String store_addr;
    private String store_addr_dtl;
    private String store_total_addr;
    private double latitude;
    private double longitude;
    private String come_way;
    private String tel_num;
    private String closed_date;
    private String oper_week_time;
    private String oper_time_start;
    private String oper_time_end;
    private String as_time;
    private String parking_yn;
    private String treat_yn;
    private String cust_desc;
    private String notice;
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

}
