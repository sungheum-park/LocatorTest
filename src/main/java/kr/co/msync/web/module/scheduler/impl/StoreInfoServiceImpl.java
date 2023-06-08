package kr.co.msync.web.module.scheduler.impl;

import kr.co.msync.web.module.main.dao.MainMapper;
import kr.co.msync.web.module.main.model.StoreDetailVO;
import kr.co.msync.web.module.scheduler.dao.StoreInfoMapper;
import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service("storeInfoService")
@Transactional
public class StoreInfoServiceImpl implements StoreInfoService {

    @Autowired
    private StoreInfoMapper storeInfoMapper;

    @Autowired
    private MainMapper mainMapper;

    @Override
    public List<StoreInfoResVO> getStoreInfoList(String final_sync_date) {
       List<StoreInfoResVO> getStoreInfoList = storeInfoMapper.getStoreInfoList(final_sync_date);
       for (StoreInfoResVO resVO : getStoreInfoList){
           StoreDetailVO storeDetailVO = new StoreDetailVO();
           storeDetailVO.setStore_code(resVO.getStore_code());
           resVO.setStoreServiceList(this.mainMapper.getStoreServiceByStoreCode(storeDetailVO));
       }
       return getStoreInfoList;
    }

    @Override
    public int updateSyncDate(String final_sync_date) {
        return storeInfoMapper.updateSyncDate(final_sync_date);
    }

}
