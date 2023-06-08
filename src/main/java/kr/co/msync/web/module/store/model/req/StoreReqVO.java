package kr.co.msync.web.module.store.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class StoreReqVO extends Criteria {

    private String store_code;
    private String[] del_store_code;
    private String[] store_code_array;
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
    private String oper_week_time_0;
    private String oper_week_time_1;
    private String oper_week_time_2;
    private String oper_week_time_3;
    private String oper_week_time_4;
    private String oper_week_time_5;
    private String oper_week_time_6;
    private String oper_time;
    private String as_time;
    private String parking_yn;
    private String treat_yn;
    private String cust_desc;
    private String notice;
    private String store_status;
    private String store_due_date;
    private String retail_store_code;
    private String del_yn;

    private String user_grt;

    /** 공통 */
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

    private String[] selected_no_cate;
    private String[] selected_excg_no_device;
    private String[] selected_sell_no_cate;
    private String[] selected_no_service;
    private String[] selected_no_color;
    private String[] selected_cate_sno;
    private String[] selected_device_qty;
    private String[] device_color_length;
    private String[] no_file_array;
    private String no_service;
    private String no_cate;
    private String no_color;
    private String no_device;
    private String cate_sno;
    private String device_qty;
    private String[] store_type_arr;
    private int file_sno;
}
