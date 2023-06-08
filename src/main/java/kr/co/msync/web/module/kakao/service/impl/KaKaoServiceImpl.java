package kr.co.msync.web.module.kakao.service.impl;


import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.kakao.service.KaKaoService;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoXYToAddressReqVO;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;


@Slf4j
@Service("kakaoService")
@Transactional
public class KaKaoServiceImpl implements KaKaoService{


    @Value("#{config['api.kakao.rest.url']}")
    private String kakaoURL;

    @Value("#{config['api.kakao.rest.authKey']}")
    private String kakaoAppKey;


    /**
     * 좌표 -> 주소변환
     * @param reqVO
     * @return
     */
    @Override
    public String getAddressNameByXY(KaKaoXYToAddressReqVO reqVO) {
        log.info("[getAddressNameByXY] parameter : {}", JSONObject.fromObject(reqVO).toString());
        JSONArray result = connectionAPI("/local/geo/coord2address.json?", String.format("x=%s&y=%s",reqVO.getLongitude(), reqVO.getLatitude()));
        StringBuffer resultStr =  new StringBuffer();
        if(result != null && !result.isEmpty()){
            JSONObject obj = result.getJSONObject(0);
            if(!obj.getJSONObject("road_address").isNullObject()){
                resultStr.append(obj.getJSONObject("road_address").getString("address_name").trim());
            }else{
                resultStr.append(obj.getJSONObject("address").getString("address_name").trim());
            }
            return resultStr.toString();
        }
        return resultStr.toString();
    }


    /**
     * 키워드로 장소 검색
     * @param reqVO
     * @return
     */
    @Override
    public List<KaKaoAddressResVO> getAddressNameByKeyword(KaKaoAddressReqVO reqVO) {
        try {
            JSONArray result = connectionAPI("/local/search/keyword.json?", String.format("query=%s", URLEncoder.encode(reqVO.getQuery(), "UTF-8")));
            List<KaKaoAddressResVO> resultList = new ArrayList<>();
            for(Object obj : result){
                JSONObject jObj = (JSONObject)obj;
                String placeName = jObj.getString("place_name");
                String addressName = jObj.getString("address_name");
                String roadAddressName = jObj.getString("road_address_name");
                String title = placeName.equals("") ? (roadAddressName.equals("") ? addressName : roadAddressName): placeName;
                String subTitle = placeName.equals("") ? (roadAddressName.equals("") ? "" : addressName): (roadAddressName.equals("") ? addressName : roadAddressName);
                resultList.add(new KaKaoAddressResVO(
                        jObj.getInt("id"),
                        placeName,
                        jObj.getString("place_url"),
                        jObj.getString("category_name"),
                        addressName,
                        roadAddressName,
                        jObj.getString("phone"),
                        jObj.getString("x"),
                        jObj.getString("y"),
                        jObj.getString("distance"),
                        title,
                        subTitle));
            }
            if(result.size() ==0){
                KaKaoAddressToXYResVO resVO = getAddressByKeyword(new KaKaoAddressToXYReqVO(reqVO.getQuery()));
                if(resVO != null){
                    resultList.add(new KaKaoAddressResVO(
                            0,
                            "",
                            "",
                            "",
                            "",
                            "",
                            "",
                            resVO.getLongitude(),
                            resVO.getLatitude(),
                            "",
                            resVO.getAddressName(),
                            ""
                    ));
                    return resultList;
                }
                return null;
            }
            return resultList;
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 주소검색
     * @param reqVO
     * @return
     */
    @Override
    public KaKaoAddressToXYResVO getAddressByKeyword(KaKaoAddressToXYReqVO reqVO) {
        try {
            JSONArray result = connectionAPI("/local/search/address.json?", String.format("query=%s", URLEncoder.encode(reqVO.getQuery(), "UTF-8")));
            KaKaoAddressToXYResVO resVO = null;
            if(result.size() > 0){
                JSONObject obj = result.getJSONObject(0);
                resVO = new KaKaoAddressToXYResVO(
                        String.valueOf(obj.get("address_name"))
                        , String.valueOf(obj.get("x"))
                        , String.valueOf(obj.get("y"))
                        , String.valueOf(obj.get("address_type"))
//                        , Double.parseDouble(String.valueOf(obj.get("y")))
//                        , Double.parseDouble(String.valueOf(obj.get("x")))

                );
            }
            return resVO;
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public JSONArray connectionAPI(String callURL, String param){
        String requestURL = kakaoURL + callURL + param;
        try {
            URL url = new URL(requestURL);
            HttpsURLConnection conn = (HttpsURLConnection)url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "KakaoAK " + kakaoAppKey) ;
            conn.setRequestProperty("Content-Type", "application/json");

            BufferedReader bfr = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            int responseCode = conn.getResponseCode();
            if(responseCode == 200){
                String inputLine = null;
                StringBuffer response = new StringBuffer();
                while((inputLine = bfr.readLine()) != null){
                    response.append(inputLine);
                }
                JSONObject resultObject = JSONObject.fromObject(response.toString());

                return resultObject.getJSONArray("documents");
            }
            return null;
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
}
