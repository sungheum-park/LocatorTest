package kr.co.msync.web.module.sms.controller;


import kr.co.msync.web.module.sms.model.SmsVO;
import kr.co.msync.web.module.sms.service.SmsService;
import kr.co.msync.web.module.util.ClientUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@RestController
public class SmsActionController {

    public static final String NAME= "sms";
    public static final String MAIN = "/action/" + NAME;
    public static final String SEND_SMS = MAIN + "/sendSMS";

    @Autowired
    private SmsService smsService;

    @RequestMapping(value = SEND_SMS, method = RequestMethod.POST)
    public Map<String, Object> sendSms(HttpServletRequest request, SmsVO smsVO){
        smsVO.setIp_addr(ClientUtil.getRemoteIP(request));
        Map<String, Object> resultMap = this.smsService.sendSms(smsVO);
        return resultMap;
    }
}
