package kr.co.msync.web.module.scheduler.model;

import kr.co.msync.web.module.common.model.Criteria;
import kr.co.msync.web.module.main.model.ServiceVO;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class StoreInfoResVO implements Cloneable{

    private String store_code;
    private String store_type;
    private String store_type_name;
    private String store_name;
    private String store_addr;
    private String store_addr_dtl;
    private double latitude;
    private double longitude;
    private String tel_num;
    private String closed_date;
    private String oper_time;
    private String as_time;
    private String oper_week_time;
    private String oper_time_start;
    private String oper_time_end;
    private boolean oper_flag;
    private boolean closed_flag;
    private String parking_yn;
    private String treat_yn;

    private double distance = 0;        // 내위치와 매장 사이에 거리
    private double distance2 = 0;
    // 코드값으로 입력 (,)콤마로 구분
    private String sell_device;
    private String service;
    private String service_name;
    private String excg_device;

    private String title;
    private String subTitle;

    private String del_yn;
    private String store_status;

    // 매장 서비스 리스트
    List<ServiceVO> storeServiceList = new ArrayList<>();

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}
