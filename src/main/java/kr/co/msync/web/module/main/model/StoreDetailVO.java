package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.mobile.device.Device;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StoreDetailVO implements Serializable{

    private String store_code;
    private String store_type;
    private String store_type_name;
    private String store_name;
    private String store_addr;
    private String store_addr_dtl;
    private String latitude;
    private String longitude;
    private String come_way;
    private String tel_num;
    private String closed_date;
    private String oper_week_time;
    private String oper_time;
    private String oper_time_start;
    private String oper_time_end;
    private boolean oper_flag;
    private boolean closed_flag;
    private String as_time;
    private String parking_yn;
    private String treat_yn;
    private String cust_desc;
    private String notice;
    private String store_status;
    private String store_due_date;
    private String store_open_date;

    private String del_yn = "N";
    private String use_yn = "Y";

    private String excg_total_count;

    // 매장 사진 리스트
    List<StorePhoto> storePhotoList = new ArrayList<>();
    // 매장 서비스 리스트
    List<ServiceVO> storeServiceList = new ArrayList<>();
    // 매장 교환 제품 리스트
    List<CategoryVO> storeExcgDeviceList = new ArrayList<>();
    // 매장 판매 제품 리스트
    List<CategoryVO> storeSellDeviceList = new ArrayList<>();
}
