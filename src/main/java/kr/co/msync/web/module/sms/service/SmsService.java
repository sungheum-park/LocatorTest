package kr.co.msync.web.module.sms.service;

import kr.co.msync.web.module.sms.model.SmsVO;

import java.util.Map;

public interface SmsService {
    Map<String, Object> sendSms(SmsVO reqVO);
}
