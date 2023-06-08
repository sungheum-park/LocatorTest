package kr.co.msync.web.module.kakao.model.req;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoAddressReqVO implements Serializable {
    private String query;               // 검색을 원하는 질의
    private String categoryGroupCode;   // 카테고리 그룹코드. 결과를 카테고리로 필터링을 원하는 경우 사용
    private String latitude;            // 중심 좌표의 X값 혹은 latitude. 특정 지역을 중심으로 검색하려 할 경우 radius와 함께 사용 가능
    private String longitude;           // 중심 좌표의 Y값 혹은 longitude. 특정 지역을 중심으로 검색하려 할 경우 radius와 함께 사용 가능
    private String radius;              // 중심좌표로부터의 반경거리. 특정지역을 중심으로 검색하려고 할 경우 중심좌표로 쓰일 x,y와 함께 사용. 단위 meter
    private String rect;                // 사각형 범위내에서 제한 검색을 위한 좌표. 지도 화면 내 검색시 등 제한 검색에서 사용 가능
    private String size;                // 결과 페이지 번호
    private String page;                // 한 페이지에서 보여질 문서의 개수
    private String sort;                // 결과 정렬순서. distance정렬을 원할때는 기준 좌표로 쓰일 x,y와 함께 사용
}
