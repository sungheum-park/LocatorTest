package kr.co.msync.web.module.main.service;


import kr.co.msync.web.module.main.model.*;

import java.util.List;
import java.util.Map;

public interface MainService {
    List<RegionVO> getRegionList(RegionVO reqVO);

    List<ServiceVO> getServiceAll();

    List<CategoryVO> getCategoryList();

    List<StoreMasterVO> getStoreListByKeyword(String keyword);

    List<StoreMasterVO> getStoreListByRegion(SearchVO searchVO);

    StoreDetailVO getStoreDetailByStoreCode(StoreDetailVO storeDetailVO);

    int updateStoreXY();

    Map<String, Object> surveyRegAction(SurveyVO reqVO);

    NoticeVO getNotice();
}
