package kr.co.msync.web.module.scheduler;

import kr.co.msync.web.module.scheduler.runnable.StoreInfoSchedulerRunnable;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import kr.co.msync.web.module.util.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class StoreInfoScheduler {

    @Autowired
    StoreInfoService storeInfoService;

    public void cron() {
        log.info("StoreScheduler CRON START at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        ThreadUtil.getInstance().execute(new StoreInfoSchedulerRunnable(storeInfoService)); // 스토어 정보 갱신
        log.info("StoreScheduler CRON END at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
    }

}
