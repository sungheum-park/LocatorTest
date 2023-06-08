package kr.co.msync.web.module.scheduler;

import kr.co.msync.web.module.scheduler.runnable.HistDelSchedulerRunnable;
import kr.co.msync.web.module.scheduler.service.HistDelService;
import kr.co.msync.web.module.util.ThreadUtil;
import lombok.extern.slf4j.Slf4j;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class HistDelScheduler {

    @Autowired
    HistDelService histDelService;

    public void cron() {
        log.info("HistDelScheduler CRON START at : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));
        ThreadUtil.getInstance().execute(new HistDelSchedulerRunnable(histDelService));
    }

}
