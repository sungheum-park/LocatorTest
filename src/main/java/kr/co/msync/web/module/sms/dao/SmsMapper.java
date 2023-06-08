package kr.co.msync.web.module.sms.dao;


import kr.co.msync.web.module.sms.model.SmsDanalVO;
import kr.co.msync.web.module.sms.model.SmsVO;
import org.springframework.stereotype.Repository;

@Repository
public interface SmsMapper {

    int getSmsSendCount(SmsVO reqVO);
    int smsIpRegAction(SmsVO reqVO);
    int smsReqUidRegAction(SmsDanalVO reqVO);
    int getSmsAllowIpCheck(SmsVO reqVO);

}
