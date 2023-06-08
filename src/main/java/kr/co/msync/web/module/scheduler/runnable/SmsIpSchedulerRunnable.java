package kr.co.msync.web.module.scheduler.runnable;


import kr.co.msync.web.module.scheduler.service.SmsIpService;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
public class SmsIpSchedulerRunnable implements Runnable{

    private SmsIpService smsIpService;

    public SmsIpSchedulerRunnable(SmsIpService smsIpService) {
        this.smsIpService = smsIpService;
    }

    @Override
    public void run() {
        System.out.println("SmsIpSchedulerRunnable run");
        makeData();
    }

    private void makeData(){
        try {
            smsIpService.deleteSmsIp();
        } catch (Exception e) {
            log.error("## SMS IP DELETE 스케줄링 에러");
        }
    }

}
