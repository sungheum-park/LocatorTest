package kr.co.msync.web.module.scheduler.impl;

import kr.co.msync.web.module.scheduler.dao.HistDelMapper;
import kr.co.msync.web.module.scheduler.service.HistDelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service("histDelService")
@Transactional
public class HistDelServiceImpl implements HistDelService {

    @Autowired
    private HistDelMapper histDelMapper;

    @Override
    public void deleteHistory() {
        histDelMapper.deleteHistory();
    }
}
