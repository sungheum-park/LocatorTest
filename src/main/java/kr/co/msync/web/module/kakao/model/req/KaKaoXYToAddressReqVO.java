package kr.co.msync.web.module.kakao.model.req;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoXYToAddressReqVO implements Serializable{
    private String latitude;        // 경위도 Y좌표(필수)
    private String longitude;       // 경위도 X좌표(필수)
}
