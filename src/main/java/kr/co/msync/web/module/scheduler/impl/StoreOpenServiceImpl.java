package kr.co.msync.web.module.scheduler.impl;

import kr.co.msync.web.module.scheduler.dao.StoreOpenMapper;
import kr.co.msync.web.module.scheduler.service.StoreOpenService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service("storeOpenService")
@Transactional
public class StoreOpenServiceImpl implements StoreOpenService {

    @Autowired
    private StoreOpenMapper storeOpenMapper;

    @Override
    public int updateStoreOpen() {
        return storeOpenMapper.updateStoreOpen();
    }

    @Override
    public int updateStoreClose() {
        return storeOpenMapper.updateStoreClose();
    }
}
