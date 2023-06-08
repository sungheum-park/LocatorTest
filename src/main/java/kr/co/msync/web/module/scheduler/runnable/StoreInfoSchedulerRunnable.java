package kr.co.msync.web.module.scheduler.runnable;

import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import kr.co.msync.web.module.util.MenuConstant;
import kr.co.msync.web.module.util.StringUtil;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;

@Slf4j
@NoArgsConstructor
public class StoreInfoSchedulerRunnable implements Runnable{

    private StoreInfoService storeInfoService;

    private MenuConstant constant;

    public StoreInfoSchedulerRunnable(StoreInfoService storeInfoService) {
        this.storeInfoService = storeInfoService;
    }

    @Override
    public void run() {
        log.error("## STORE MENU INTO MAP SCHEDULER RUNNING!!");
        makeData();
    }

    private void clear(){
        this.constant = MenuConstant.getInstance();
        this.constant.storeInfoMap.clear();
    }

    private void makeData(){
        clear();
        try {
            setStoreInfo();
        } catch (Exception e) {
            log.error("## STORE INFO MENU INTO MAP 스케줄링 에러");
        }
    }

    private void setStoreInfo(){

        List<StoreInfoResVO> storeInfoList = storeInfoService.getStoreInfoList(null);

        storeInfoService.updateSyncDate(StringUtil.getTimeStamp("yyyyMMddHHmmss"));

        if(storeInfoList != null) {
            for(StoreInfoResVO vo : storeInfoList) {
                this.constant.storeInfoMap.put(vo.getStore_code(), vo);
            }
        }

    }

}
