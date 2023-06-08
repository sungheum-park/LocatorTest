package kr.co.msync.web.module.store.model.res;

import kr.co.msync.web.module.color.model.res.ColorResVO;
import lombok.Data;

import java.util.List;

@Data
public class StoreResVO {

	private String store_code;
	private String store_type;
	private String store_name;
	private String store_addr;
	private String store_addr_dtl;
	private String store_total_addr;
	private double latitude;
	private double longitude;
	private String lat_long_spot;
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
	private String cate_reg_date;

	/** 공통 */
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String mod_id;
	private String mod_name;
	private String mod_date;

	/** 파일 맵핑 */
	private List<StoreFileResVO> photo_files;
	/** 컬러 맵핑 */
	private List<ColorResVO> color_array;
	/** 판매기기 맵핑 */
	private List<StoreResVO> sell_device_array;
	/** 교환기기 맵핑 */
	private List<StoreResVO> excg_device_array;
	/** 서비스 맵핑 */
	private List<StoreResVO> service_array;

	/** 카테고리 */
	private String no_cate;
	private String cate_name;
	private String cate_sno;
	private String isMap;

	/** 모달 */
	private String no_service;
	private String no_device;
	private String service_name;
	private String excg_device_name;
	private String device_name;
	private String use_yn;

	private String color_length;

	private String file_map_array;
	private String sell_array;
	private String excg_array;
	private String service_map_array;

}
