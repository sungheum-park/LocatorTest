package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StoreMasterVO implements Serializable{
    private String store_code;
    private String store_type;
    private String store_name;
    private String store_addr;
    private String store_addr_dtl;
    private String latitude;
    private String longitude;
    private String come_way;
    private String tel_num;
    private String closed_date;
    private String oper_week_time;
    private String as_time;
    private String parking_yn;
    private String treat_yn;
    private String cust_desc;
    private String notice;
    private String del_yn;

    //임시
    private String store_type_name;

    // 길찾기에서 사용
    private String title;
    private String subTitle;

}
