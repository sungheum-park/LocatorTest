package kr.co.msync.web.module.scheduler.service;

import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;

import java.util.List;

public interface StoreInfoService {
    List<StoreInfoResVO> getStoreInfoList(String final_sync_date);
    int updateSyncDate(String final_sync_date);
}
