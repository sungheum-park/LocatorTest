package kr.co.msync.web.module.store.service;

import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.store.model.req.StoreReqVO;
import kr.co.msync.web.module.store.model.res.StoreResVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface StoreService {
	List<StoreResVO> getStoreList(StoreReqVO reqVO);
	List<StoreResVO> getStoreExcelList(StoreReqVO reqVO);
	int getStoreListCnt(StoreReqVO reqVO);
	String storeRegAction(Map<String, MultipartFile> file, StoreReqVO reqVO);
	String storeModAction(Map<String, MultipartFile> file, StoreReqVO reqVO);
	StoreResVO getStoreInfo(StoreReqVO reqVO, String actionType);
	int storeDelAction(StoreReqVO reqVO);
	List<StoreResVO> getStoreSellDeviceList(StoreReqVO reqVO);
	List<StoreResVO> getStoreExcgDeviceList(StoreReqVO reqVO);
	List<StoreResVO> getOfferServiceList(StoreReqVO reqVO);
	int storeAllParkingModAction(StoreReqVO reqVO);
	int storeAllTreatModAction(StoreReqVO reqVO);
	int storeAllOperTimeModAction(StoreReqVO reqVO);
	int storeAllStoreOperTimeModAction(StoreReqVO reqVO);
	int storeAllClosedDateModAction(StoreReqVO reqVO);
	int storeAllSellDeviceModAction(StoreReqVO reqVO);
	int storeAllExcgDeviceModAction(StoreReqVO reqVO);
	int storeAllServiceModAction(StoreReqVO reqVO);
	int storeAllStatusModAction(StoreReqVO reqVO);
	Map<String,Object> getAddressNameByKeyword(KaKaoAddressReqVO reqVO);
	Map<String,Object> getAddressByKeyword(KaKaoAddressToXYReqVO reqVO);
	Map<String, Object> storeSyncAction();
	String getMaxModStore();
	String getMaxRegStore();
	String getStoreSyncDate();
	String getAllRegAction(MultipartFile file, Map map) throws Exception;
	List<Map> getColorCodeList();
}