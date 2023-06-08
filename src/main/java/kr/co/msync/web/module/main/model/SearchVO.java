package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchVO implements Serializable{

    // 필터 항목
    private String service;
    private String sell_device;
    private String excg_device_cate;
    private String excg_device_device;
    private String excg_device_color;

    // 직접검색 keyword
    private String keyword;

    // 근처 매장 바로보기 위/경도
    private double latitude = 0;
    private double longitude = 0;
    private double myLat = 0;
    private double myLng = 0;
    
    private int distance;   // 반경 몇 KM이내 매장 보여줄지

    // 지역 검색
    private String regionDepth1;
    private String regionDepth2;
}
