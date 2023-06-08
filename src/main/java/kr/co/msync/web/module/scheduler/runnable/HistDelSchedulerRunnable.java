package kr.co.msync.web.module.scheduler.runnable;


import kr.co.msync.web.module.scheduler.service.HistDelService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
public class HistDelSchedulerRunnable implements Runnable{

    private HistDelService histDelService;

    public HistDelSchedulerRunnable(HistDelService histDelService) {
        this.histDelService = histDelService;
    }

    @Override
    public void run() {
        System.out.println("HistDelSchedulerRunnable run");
        makeData();
    }

    private void makeData(){
        try {
            histDelService.deleteHistory();
        } catch (Exception e) {
            log.error("## History DELETE 스케줄링 에러");
        }
    }

}
