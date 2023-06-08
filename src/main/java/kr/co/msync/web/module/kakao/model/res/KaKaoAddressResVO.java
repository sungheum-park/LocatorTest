package kr.co.msync.web.module.kakao.model.res;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoAddressResVO implements Serializable{
    private int id;                     // 장소ID
    private String placeName;           // 장소명, 업체명
    private String placeUrl;            // 장소 상세페이지 URL
    private String categoryName;        // 카테고리 이름
    private String addressName;         // 전체 지번 주소
    private String roadAddressName;     // 전체 도로명 주소
    private String phone;               // 전화번호
    private String longitude;           // X좌표값 혹은 longitude
    private String latitude;            // Y좌표값 혹은 latitude
    private String distance;            // 중심좌표까지의 거리(x,y 파라미터를 준 경우에만 존재). 단위 meter

    private String title;
    private String subTitle;
}
