package kr.co.msync.web.module.kakao.model.res;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoAddressToXYResVO implements Serializable{
    private String addressName;
    private String latitude;
    private String longitude;
    private String addressType;
}
