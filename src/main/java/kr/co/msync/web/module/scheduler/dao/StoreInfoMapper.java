package kr.co.msync.web.module.scheduler.dao;

import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StoreInfoMapper {
	List<StoreInfoResVO> getStoreInfoList(String final_sync_date);
	int updateSyncDate(String final_sync_date);
}