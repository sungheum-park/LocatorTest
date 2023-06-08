package kr.co.msync.web.module.scheduler.impl;

import kr.co.msync.web.module.scheduler.dao.SmsIpMapper;
import kr.co.msync.web.module.scheduler.service.SmsIpService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service("smsIpService")
@Transactional
public class SmsIpServiceImpl implements SmsIpService {

    @Autowired
    private SmsIpMapper smsIpMapper;

    @Override
    public void deleteSmsIp() {
        smsIpMapper.deleteSmsIp();
    }
}
