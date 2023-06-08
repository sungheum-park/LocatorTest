package kr.co.msync.web.module.sms.service.impl;


import com.google.gson.Gson;
import kr.co.msync.web.module.sms.dao.SmsMapper;
import kr.co.msync.web.module.sms.model.SmsDanalVO;
import kr.co.msync.web.module.sms.model.SmsVO;
import kr.co.msync.web.module.sms.service.SmsService;
import org.springframework.transaction.annotation.Transactional;
import kr.co.msync.web.module.util.Sha256Util;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.HashMap;


@Slf4j
@Service("smsService")
@Transactional
public class SmsServiceImpl implements SmsService {

    @Autowired
    private SmsMapper smsMapper;

    @Autowired
    private Gson gson;

    @Value("#{config['sms.danal.send.able.count']}")
    private String sendAbleCount;

    @Value("#{config['sms.danal.url']}")
    private String danalUrl;

    @Value("#{config['sms.danal.port']}")
    private String danalPort;

    @Value("#{config['sms.danal.apiKey']}")
    private String apiKey;

    @Value("#{config['sms.danal.apiSecret']}")
    private String apiSecret;

    @Value("#{config['share.link.url']}")
    private String shareLinkUrl;

    private final String DANAL_SUCCESS_CODE = "000";

    @Override
    public Map<String, Object> sendSms(SmsVO reqVO) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("result_code", "NG");
        resultMap.put("message", "잠시 후 다시 시도해 주세요.");

        // 해당 아이피로 SMS보낸 횟수 조회
        reqVO.setIp_addr(Sha256Util.encrypt(reqVO.getIp_addr()));
        int sendCount = this.smsMapper.getSmsSendCount(reqVO);
        log.info("SMS 보낸 횟수 : {}", sendCount);

        if(sendCount >= Integer.parseInt(sendAbleCount) && smsMapper.getSmsAllowIpCheck(reqVO) == 0){
            log.info("SMS 가능 횟수 초과 : {}", reqVO.getIp_addr());
            resultMap.put("message", "문자로 공유가능한 횟수를 초과하였습니다.");
            return resultMap;
        }

        // danal AccessToken 받아오기
        String accessToken = getToken();
        if(accessToken == null){
            log.info("DANAL AccessToken 얻기 실패 : {}", accessToken);
            return resultMap;
        }

        SmsDanalVO smsDanalVO = new SmsDanalVO();
        smsDanalVO.setReqUid("locator_" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));
        smsDanalVO.setSysCode("NPS");
        smsDanalVO.setFromName("IQOS");
        smsDanalVO.setFromPhone("0800001905");
        smsDanalVO.setToID("StoreLocation");
        smsDanalVO.setNaCode("82");
        smsDanalVO.setToName("StoreLocationConsumer");
        smsDanalVO.setToPhone(reqVO.getPhone());
        smsDanalVO.setTplCode("IQ_STORE_FINDER_1");
        smsDanalVO.setSmSubject("아이코스 매장찾기");
        smsDanalVO.setSmContent(reqVO.getStore_name() + "\n" + reqVO.getStore_addr() + "\n" + shareLinkUrl+reqVO.getStore_code());


        // SMS보내기
        String resultCode = danalSmsSend(smsDanalVO, accessToken,"LM");

        log.info("DANAL SMS 전송 응답 코드 : {}", resultCode);
        if(resultCode.equals(DANAL_SUCCESS_CODE)){
            resultMap.put("result_code", "OK");
            resultMap.put("message", "성공적으로 발송되었습니다.");
            try{
                this.smsMapper.smsIpRegAction(reqVO);
                this.smsMapper.smsReqUidRegAction(smsDanalVO);
            }catch(Exception e){
                // 발송은 성공적으로 했지만, 디비 저장 실패
                log.error("SMS전송은 성공 했지만 DB로그 저장 실패!!!");
                return resultMap;
            }
            return resultMap;
        }
        return resultMap;
    }


    /**
     * 								응답 코드 목록
     *  Code						Message							Description
     *   000						SUCCESS							   성공
     *   100				       NULL PARAM					  파라미터 값이 없을시
     *   101				     WRONG SIZE PARAM   	      요청 값의 사이즈가 전문을 초과할 시
     *   104  			        PARSING JSON ERROR    	            JSON 형태 오류
     *   998   			 			ETC ERROR					      기타 오류
     */


    /**
     *	API 인증키 발급
     *	- 메시지 발송 요청을 위한 인증 키를 발급 받는 API
     *	- 발급 되는 Access Token의 유효기간은 일주일이다.
     *	- 만료 전 재 요청 시 기존 Access Token을 발급 할 수 있다.
     *	- Access Token의 유효기간은 초기 발급 시 결정 되며 변경 되지 않는다.
     *  @return
     */
    public String getToken() {
        try {
            log.info("API 인증키 발급 시작");

            StringBuffer requestURL = new StringBuffer(danalUrl);
            requestURL.append(":");
            requestURL.append(danalPort);
            requestURL.append("/api/getToken");
            URL url = new URL(requestURL.toString());

            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            StringBuffer sb = new StringBuffer("data=");
            sb.append("{");
            sb.append("\"api-key\":\"");
            sb.append(apiKey);
            sb.append("\",");
            sb.append("\"api-secret\":\"");
            sb.append(apiSecret);
            sb.append("\"");
            sb.append("}");

            con.setDoOutput(true);

            DataOutputStream dos = new DataOutputStream(con.getOutputStream());
            dos.writeBytes(sb.toString());
            dos.flush();
            dos.close();

            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine = "";
            StringBuffer response = new StringBuffer();

            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            JSONObject resultObject = new JSONObject();
            resultObject = resultObject.fromObject(response.toString());

            log.info("API 인증키 발급 응답 데이터 : {}", resultObject);

            if(String.valueOf(resultObject.get("code")).equals(DANAL_SUCCESS_CODE)){
                return String.valueOf(resultObject.get("access_token"));
            }
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 		채널명		Description
     * 		 SM 		   SMS
     * 		 LM 		   LMS
     * 		 MM 		   MMS
     * 		 KA 	   카카오 알림톡
     */

    /**
     * 메시지 발송
     * - 메시지 발송을 위한 API
     * - 채널 값에 의해 분기 되며, 채널마다 필수 값이 상이할 수 있다.
     * - HTTP Header 내 accessToken 필드를 이용하여 발급받은 API 인증키를 전달해야 한다.
     * - 만료된 인증키로 발송 되는 요청은 거절 된다.
     */
    public String danalSmsSend(SmsDanalVO reqVO, String accessToken, String channel){
        try{
            log.info("문자 전송 시작");
            StringBuffer requestURL = new StringBuffer(danalUrl);
            requestURL.append(":");
            requestURL.append(danalPort);
            requestURL.append("/api/real/send/");
            requestURL.append(channel);	// SM - SMS, LM - LMS, MM - MMS, KA - Kakao Talk
            URL url = new URL(requestURL.toString());

            HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            con.setRequestProperty("accessToken", accessToken);

            StringBuffer requestParameter = new StringBuffer("data=");
            requestParameter.append(gson.toJson(reqVO));

            con.setDoOutput(true);
            DataOutputStream dos = new DataOutputStream(con.getOutputStream());
            dos.write(String.valueOf(requestParameter).getBytes("UTF-8"));
            dos.flush();
            dos.close();

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;

            StringBuffer response = new StringBuffer();

            while((inputLine = in.readLine()) != null){
                response.append(inputLine);
            }
            in.close();

            JSONObject resultObject = new JSONObject();
            resultObject = resultObject.fromObject(response.toString());

            log.info("SMS 전송 응답 데이터 : {}", resultObject);

            return String.valueOf(resultObject.get("code"));
        }catch(IOException e){
            e.printStackTrace();
            return null;
        }

    }

}
