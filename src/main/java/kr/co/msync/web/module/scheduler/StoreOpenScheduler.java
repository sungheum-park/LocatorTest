package kr.co.msync.web.module.scheduler;

import kr.co.msync.web.module.scheduler.runnable.StoreOpenSchedulerRunnable;
import kr.co.msync.web.module.scheduler.service.StoreOpenService;
import kr.co.msync.web.module.util.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class StoreOpenScheduler {

    @Autowired
    StoreOpenService storeOpenService;

    public void cron() {
        log.info("StoreOpenScheduler CRON START at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        ThreadUtil.getInstance().execute(new StoreOpenSchedulerRunnable(storeOpenService));
        log.info("StoreOpenScheduler CRON END at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
    }

}
