package kr.co.msync.web.module.scheduler;

import kr.co.msync.web.module.scheduler.runnable.SmsIpSchedulerRunnable;
import kr.co.msync.web.module.scheduler.service.SmsIpService;
import kr.co.msync.web.module.util.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class SmsIpScheduler {

    @Autowired
    SmsIpService smsIpService;

    public void cron() {
        log.info("SmsIpScheduler CRON START at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        ThreadUtil.getInstance().execute(new SmsIpSchedulerRunnable(smsIpService));
        log.info("SmsIpScheduler CRON END at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
    }

}
