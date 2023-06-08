package kr.co.msync.web.module.kakao.controller;


import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.kakao.service.KaKaoService;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoXYToAddressReqVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@Slf4j
@RestController
public class KaKaoActionController extends BaseController{

    public static final String NAME = "kakao";
    public static final String MAIN = "/" + NAME;

    public static final String ADDRESS_BY_XY = MAIN + "/addressByXY";
    public static final String ADDRESS_BY_KEYWORD = MAIN + "/addressByKeyword";

    @Autowired
    private KaKaoService kakaoService;

    @RequestMapping(value = ADDRESS_BY_XY, method = RequestMethod.POST)
    public String getAddressNameByXY(KaKaoXYToAddressReqVO reqVO) throws Exception {
        String result = kakaoService.getAddressNameByXY(reqVO);
        return result;
    }

    @RequestMapping(value = ADDRESS_BY_KEYWORD, method = RequestMethod.POST)
    public List<KaKaoAddressResVO> getAddressByKeyword(KaKaoAddressReqVO reqVO){
        List<KaKaoAddressResVO> resultList = kakaoService.getAddressNameByKeyword(reqVO);
        return resultList;
    }
}
