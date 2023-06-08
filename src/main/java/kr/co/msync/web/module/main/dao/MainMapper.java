package kr.co.msync.web.module.main.dao;

import kr.co.msync.web.module.main.model.*;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


@Repository
public interface MainMapper {
    List<RegionVO> getRegionList(RegionVO reqVO);

    List<ServiceVO> getServiceAll(ServiceVO reqVO);

    List<CategoryVO> getCategoryList(CategoryVO reqVO);
    List<DeviceVO> getDeviceList(DeviceVO reqVO);
    List<DeviceColorVO> getDeviceColorList(DeviceVO reqVO);

    List<StoreMasterVO> getStoreListByKeyword(String keyword);
    List<StoreMasterVO> getStoreListByRegion(SearchVO searchVO);

    StoreDetailVO getStoreDetailByStoreCode(StoreDetailVO reqVO);
    List<StorePhoto> getStorePhotoByStoreCode(StoreDetailVO reqVO);
    List<ServiceVO> getStoreServiceByStoreCode(StoreDetailVO reqVO);
    List<CategoryVO> getStoreSellDeviceList(StoreDetailVO reqVO);
    List<Map<String, Object>> getStoreExcgDeviceList(StoreDetailVO reqVO);

    int getSurveyCount(SurveyVO reqVO);
    int surveyRegAction(SurveyVO reqVO);

    NoticeVO getNotice();


    // 좌표값 갖고오는거
    List<StoreMasterVO> getStoreAll();
    int updateStoreXY(StoreMasterVO storeMasterVO);
}
