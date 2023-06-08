package kr.co.msync.web.module.scheduler.runnable;

import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import kr.co.msync.web.module.scheduler.service.StoreOpenService;
import kr.co.msync.web.module.util.MenuConstant;
import kr.co.msync.web.module.util.StringUtil;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.joda.time.DateTime;

import java.util.List;

@Slf4j
@NoArgsConstructor
public class StoreOpenSchedulerRunnable implements Runnable{

    private StoreOpenService storeOpenService;

    private MenuConstant constant;

    public StoreOpenSchedulerRunnable(StoreOpenService storeOpenService) {
        this.storeOpenService = storeOpenService;
    }

    @Override
    public void run() {
        log.error("## STORE OPEN INTO MAP SCHEDULER RUNNING!!");
        makeData();
    }

    private void makeData(){
        try {
            updateStoreOpen();
            updateStoreClose();
        } catch (Exception e) {
            log.error("## STORE OPEN MENU INTO MAP 스케줄링 에러");
        }
    }

    private void updateStoreOpen(){

        int updateCnt = storeOpenService.updateStoreOpen();
        log.info("StoreOpenScheduler Open Store Update Count : " + updateCnt + ", Date : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));

    }

    private void updateStoreClose(){

        int updateCnt = storeOpenService.updateStoreClose();
        log.info("StoreOpenScheduler Close Store Update Count : " + updateCnt + ", Date : "+ DateTime.now().toString("yyyy-MM-dd HH:mm:ss"));

    }

}
