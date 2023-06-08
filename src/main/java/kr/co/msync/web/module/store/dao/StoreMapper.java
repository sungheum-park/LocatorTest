package kr.co.msync.web.module.store.dao;

import kr.co.msync.web.module.store.model.req.StoreFileReqVO;
import kr.co.msync.web.module.store.model.req.StoreReqVO;
import kr.co.msync.web.module.store.model.res.StoreResVO;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface StoreMapper {

	List<StoreResVO> getStoreList(StoreReqVO reqVO);
	List<StoreResVO> getStoreExcelList(StoreReqVO reqVO);
	int getStoreListCnt(StoreReqVO reqVO);
	int storeRegAction(StoreReqVO reqVO);
	int storeModAction(StoreReqVO reqVO);
	int storePhotoRegAction(StoreFileReqVO reqVO);
	int storeSellDeviceRegAction(StoreReqVO reqVO);
	int storeExcgDeviceRegAction(StoreReqVO reqVO);
	int storeServiceRegAction(StoreReqVO reqVO);
	StoreResVO getStoreInfo(StoreReqVO reqVO);
	int storeDelAction(StoreReqVO reqVO);
	int storePastFileDelAction(StoreReqVO reqVO);
	List<StoreResVO> getStoreSellDeviceList(StoreReqVO reqVO);
	List<StoreResVO> getStoreExcgDeviceList(StoreReqVO reqVO);
	List<StoreResVO> getOfferServiceList(StoreReqVO reqVO);
	int storeAllParkingModAction(StoreReqVO reqVO);
	int storeAllTreatModAction(StoreReqVO reqVO);
	int storeAllStatusModAction(StoreReqVO reqVO);
	int storeAllOperTimeModAction(StoreReqVO reqVO);
	int storeAllStoreOperTimeModAction(StoreReqVO reqVO);
	int storeAllClosedDateModAction(StoreReqVO reqVO);
	int storeAllSellDeviceModAction(StoreReqVO reqVO);
	int storeAllExcgDeviceModAction(StoreReqVO reqVO);
	int storeAllServiceModAction(StoreReqVO reqVO);
	int updateStoreModDateUpdate(StoreReqVO reqVO);
	void storeAllSellDeviceDelAction(StoreReqVO reqVO);
	void storeAllExcgDeviceDelAction(StoreReqVO reqVO);
	void storeAllServiceDelAction(StoreReqVO reqVO);
	String getStoreSyncDate();
	String getMaxModStore();
	String getMaxRegStore();
	int storeRetailCodeCnt(Map map);
	int storeDeviceColorCnt(Map map);
	List<Map> getServiceList();
	List<Map> getColorCodeList();
}
