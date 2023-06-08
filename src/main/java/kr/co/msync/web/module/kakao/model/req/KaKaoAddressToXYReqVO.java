package kr.co.msync.web.module.kakao.model.req;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class KaKaoAddressToXYReqVO implements Serializable{
    private String query;       // 검색을 원하는 질의어
}

