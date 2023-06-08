package kr.co.msync.web.module.hist.model.res;

import lombok.Data;

@Data
public class MasterResVO {

	/* 공통 **/
	private String no_hist;

	private String no_user;
	private String login_id;
	private String user_name;
	private String user_en_name;
	private String email_addr;
	private String user_company;
	private String user_channel;
	private String password;
	private String user_grt;
	private String reg_way;

	private String no_color;
	private String color_name;
	private String color_rgb;
	private String color_sno;
	private String no_device;

	private String no_cate;
	private String cate_name;
	private String device_name;
	private String no_service;
	private String service_div;
	private String service_name;
	private String file_path;
	private String origin_name;
	private String save_name;
	private String file_size;
	private String width;
	private String height;
	private String file_ext;
	private String use_yn;

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
	private String oper_time;
	private String oper_week_time;
	private String oper_week_time_0;
	private String oper_week_time_1;
	private String oper_week_time_2;
	private String oper_week_time_3;
	private String oper_week_time_4;
	private String oper_week_time_5;
	private String oper_week_time_6;
	private String as_time;
	private String parking_yn;
	private String treat_yn;
	private String cust_desc;
	private String notice;
	private String store_status;
	private String store_due_date;
	private String del_yn;
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String mod_id;
	private String mod_name;
	private String mod_date;

	private String sell_yn;
	private String excg_yn;
	private String user_status;
	private String last_pwd_mod_date;

	private String file_map_array;
	private String service_map_array;
	private String sell_array;
	private String excg_array;
	private String color_name_array;
}
