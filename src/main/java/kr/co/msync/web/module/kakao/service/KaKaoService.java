package kr.co.msync.web.module.kakao.service;

import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoXYToAddressReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;

import java.util.List;

public interface KaKaoService {

    String getAddressNameByXY(KaKaoXYToAddressReqVO reqVO);

    List<KaKaoAddressResVO> getAddressNameByKeyword(KaKaoAddressReqVO reqVO);

    KaKaoAddressToXYResVO getAddressByKeyword(KaKaoAddressToXYReqVO reqVO);


}
