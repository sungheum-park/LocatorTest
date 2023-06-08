package kr.co.msync.web.module.kakao.model.res;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoXYToAddressResVo implements Serializable{

    // roadAddress
    private String roadAddressName;
    private String roadRegion1DepthName;
    private String roadRegion2DepthName;
    private String roadRegion3DepthName;
    private String roadName;
    private String roadUnderGroundYn;
    private String roadMainBuildingNo;
    private String roadSubBuildingNo;
    private String roadBuildingName;
    private String roadZoneNo;

    // address
    private String addressName;
    private String region1DepthName;
    private String region2DepthName;
    private String region3DepthName;
    private String mountainYn;
    private String mainAddressNo;
    private String subAddressNo;
    private String zipCode;
}
