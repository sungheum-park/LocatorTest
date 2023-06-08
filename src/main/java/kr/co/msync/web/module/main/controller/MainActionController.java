package kr.co.msync.web.module.main.controller;

import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.kakao.service.KaKaoService;
import kr.co.msync.web.module.main.model.*;
import kr.co.msync.web.module.main.service.MainService;
import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import kr.co.msync.web.module.util.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Slf4j
@RestController
public class MainActionController {

    public static final String NAME = MainController.NAME;

    public static final String MAIN = "/action/" + NAME;

    public static final String GET_REGION_LIST = MAIN + "/getRegionList";

    public static final String GET_STORE_LIST_BY_XY = "/getStoreListByXY";

    public static final String GET_STORE_LIST_BY_SEARCH_KEYWORD = "/getStoreListBySearchKeyword";

    public static final String GET_STORE_LIST_BY_REGION = "/getStoreListByRegion";

    public static final String GET_STORE_LIST_BY_KEYWORD = "/getStoreListByKeyword";

    public static final String GET_STORE_DETAIL = "/getStoreDetail";

    public static final String SEND_SURVEY = "/sendSurvey";

    @Autowired
    private MainService mainService;

    @Autowired
    private StoreInfoService storeInfoService;

    @Autowired
    private KaKaoService kakaoService;

    private MenuConstant constant;

    /**
     * 직접검색 > 근처매장 바로보기
     * @param searchVO
     * @return
     */
    @RequestMapping(value = GET_STORE_LIST_BY_XY, method = RequestMethod.POST )
    public Map<String, Object> getStoreListByXY(SearchVO searchVO){
        log.info("직접검색 > 근처 매장 바로가기");
        Map<String, StoreInfoResVO> storeMap = null;
        try{
            storeMap = constant.getInstance().storeInfoMap;
            // storeMap Size가 0일경우 강제 Exception 발생!
            if(storeMap.size() == 0){
                throw new NullPointerException();
            }
        }catch(NullPointerException e){
            log.error("메모리 상점 데이터 NULL");
            storeMap = new HashMap<>();
            List<StoreInfoResVO> storeList = this.storeInfoService.getStoreInfoList(null);
            for(StoreInfoResVO vo : storeList) {
                storeMap.put(vo.getStore_code(), vo);
            }
            constant.getInstance().storeInfoMap = storeMap;
            log.info("DB에서 상점 정보 조회");
        }

        int nowTime = Integer.parseInt(DateUtil.getCurrentDateTime("HHmm"));
        List<StoreInfoResVO> list = new ArrayList<>();
        for(String key : storeMap.keySet()){
            StoreInfoResVO storeInfoResVO = null;
            try {
                storeInfoResVO = (StoreInfoResVO)(storeMap.get(key)).clone();
            } catch (CloneNotSupportedException e) {
                e.printStackTrace();
            }

            // 지도 중심 좌표(or 내위치)와 매장 위치간에 거리 - 처음 진입, 근처매장 바로보기시에는 내위치값과 매장위치간에 거리 비교
            double distance2 = DistanceUtil.distance(searchVO.getLatitude(), searchVO.getLongitude(), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
            int diffDistance = searchVO.getDistance();
            if(distance2 <= diffDistance){
                // 내위치와 매장위치간에 거리 - 맵이동시 필요
                double distance = DistanceUtil.distance(searchVO.getMyLat(), searchVO.getMyLng(), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
                storeInfoResVO.setDistance(distance);
                storeInfoResVO.setDistance2(distance2);
            }else{
                continue;
            }

            // 필터 체크 시작
            boolean flag = false;

            // 필터 체크(판매기기)
            if(!storeInfoResVO.getSell_device().contains(searchVO.getSell_device())){
                continue;
            }

            // 필터 체크(서비스)
            for(String service : searchVO.getService().split(",")){
                if(service.equals("")){
                    break;
                }
                if(!storeInfoResVO.getService().contains(service)){
                    flag = true;
                    break;
                }
            }
            if(flag){
                continue;
            }

            // 필터 체크(교환기기)
            if(!searchVO.getExcg_device_cate().equals("") && searchVO.getExcg_device_device().equals("") && searchVO.getExcg_device_color().equals("")){
                if(!storeInfoResVO.getExcg_device().contains(searchVO.getExcg_device_cate())){
                    continue;
                }
            }else{
                // 교환기기의 재고가 없는 경우 - 칼라별로 체크하기 위함
                // ex) 화이트 재고 있음, 그레이 재고 없는 경우에 필요한 변수 : cnt
                int cnt = 0;
                for(String no_color : searchVO.getExcg_device_color().split(",")){
                    String diffStr = searchVO.getExcg_device_device() + ":" + no_color;
                    if(diffStr.equals(":")){
                        break;
                    }

                    if(storeInfoResVO.getExcg_device().contains(diffStr)) {
                        cnt++;
                    }

                    if(!storeInfoResVO.getExcg_device().contains(diffStr)){
                        flag = true;
                        break;
                    }
                }
                if(cnt==0 && flag){
                    continue;
                }
            }
            // 필터 체크 끝

            // 영업중 여부 체크
            storeInfoResVO.setOper_flag(false);
            // 휴무 체크
            storeInfoResVO.setClosed_flag(false);
            if(storeInfoResVO.getClosed_date().equals("01") && !storeInfoResVO.getOper_time_start().equals("")){
                String[] oper_time_start_array = storeInfoResVO.getOper_time_start().split("/");
                String[] oper_time_end_array = storeInfoResVO.getOper_time_end().split("/");
                for(int i = 0; i < oper_time_start_array.length; i++){
                    if(Integer.parseInt(oper_time_start_array[i].replace(":","")) <= nowTime && Integer.parseInt(oper_time_end_array[i].replace(":","")) >= nowTime){
                        storeInfoResVO.setOper_flag(true);
                        break;
                    }
                }
            } else if (!storeInfoResVO.getClosed_date().equals("01")){
                storeInfoResVO.setClosed_flag(true);
            }
            list.add(storeInfoResVO);
        }

        // list 오름 차순 정렬
        Collections.sort(list, new Comparator<StoreInfoResVO>() {
            @Override
            public int compare(StoreInfoResVO o1, StoreInfoResVO o2) {
                double distance1 = o1.getDistance2();
                double distance2 = o2.getDistance2();
                if (distance1 == distance2)
                    return 0;
                else if (distance1 > distance2)
                    return 1;
                else
                    return -1;
            }
        });

        // 매장 타입별로 구분
        Map<String, Map<String, Object>> resultMap = new HashMap<String, Map<String, Object>>();
        for (int i = 0; i < (list.size() >= 20 ? 20 : list.size()); i++) {
            StoreInfoResVO storeVO = list.get(i);
            Map<String, Object> objectMap = resultMap.get(storeVO.getStore_type());
            if (objectMap == null) {
                objectMap = new HashMap<String, Object>();
                List<StoreInfoResVO> resultList = new ArrayList<>();
                resultList.add(storeVO);
                objectMap.put("storeTypeName", storeVO.getStore_type_name());
                objectMap.put("storeList", resultList);
                resultMap.put(storeVO.getStore_type(), objectMap);
            } else {
                List<StoreInfoResVO> resultList = (List<StoreInfoResVO>) objectMap.get("storeList");
                resultList.add(storeVO);
            }
        }

        List<StoreInfoResVO> distanceList = list.subList(0, (list.size() >= 20 ? 20 : list.size()));
        // list 오름 차순 정렬
        Collections.sort(distanceList, new Comparator<StoreInfoResVO>() {
            @Override
            public int compare(StoreInfoResVO o1, StoreInfoResVO o2) {
                double distance1 = o1.getDistance();
                double distance2 = o2.getDistance();
                if (distance1 == distance2)
                    return 0;
                else if (distance1 > distance2)
                    return 1;
                else
                    return -1;
            }
        });

        Map<String, Object> response = new HashMap<>();
        response.put("typeList", new TreeMap<String,Map<String,Object>>(resultMap));
        response.put("distanceList", distanceList);
        return response;
    }


    /**
     * 직접검색 > 주소/지하철/매장명 검색
     * @param searchVO
     * @return
     */
    @RequestMapping(value = GET_STORE_LIST_BY_SEARCH_KEYWORD, method = RequestMethod.POST)
    public Map<String, Object> getStoreListBySearchKeyword(SearchVO searchVO){
        Map<String, StoreInfoResVO> storeMap = null;
        try{
            storeMap = this.constant.getInstance().storeInfoMap;
            // storeMap Size가 0일경우 강제 Exception 발생!
            if(storeMap.size() == 0){
                throw new NullPointerException();
            }
        }catch(NullPointerException e){
            log.error("메모리 상점 데이터 NULL");
            storeMap = new HashMap<>();
            List<StoreInfoResVO> storeList = this.storeInfoService.getStoreInfoList(null);
            for(StoreInfoResVO vo : storeList) {
                storeMap.put(vo.getStore_code(), vo);
            }
            constant.getInstance().storeInfoMap = storeMap;
            log.info("DB에서 상점 정보 조회");
        }

        // 결과 담을 리스트
        List<StoreInfoResVO> list = new ArrayList<>();

        // 상점명에 keyword가 포함되어있는거 추출
        for(String key: storeMap.keySet()){
            StoreInfoResVO storeInfoResVO = null;
            try {
                storeInfoResVO = (StoreInfoResVO)(storeMap.get(key)).clone();
            } catch (CloneNotSupportedException e) {
                e.printStackTrace();
            }
            if(storeInfoResVO.getStore_name().contains(searchVO.getKeyword()) || storeInfoResVO.getStore_addr().contains(searchVO.getKeyword()) || storeInfoResVO.getStore_addr_dtl().contains(searchVO.getKeyword())){
                list.add(storeInfoResVO);
            }
        }

        // 주소검색 API 호출
        KaKaoAddressToXYResVO kaKaoAddressToXYResVO = kakaoService.getAddressByKeyword(new KaKaoAddressToXYReqVO(searchVO.getKeyword()));
        if(kaKaoAddressToXYResVO != null){
            for(String key : storeMap.keySet()){
                StoreInfoResVO storeInfoResVO = null;
                try {
                    storeInfoResVO = (StoreInfoResVO)(storeMap.get(key)).clone();
                } catch (CloneNotSupportedException e) {
                    e.printStackTrace();
                }
                double distance = DistanceUtil.distance(Double.parseDouble(kaKaoAddressToXYResVO.getLatitude()), Double.parseDouble(kaKaoAddressToXYResVO.getLongitude()), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
                // 검색된 주소에 1km이내 매장 검색
                if(distance <= 1){
                    list.add(storeInfoResVO);
                }
            }
        }

        // 중복 제거
        HashSet<StoreInfoResVO> listTempListSet = new HashSet<StoreInfoResVO>(list);
        List<StoreInfoResVO> storeList= new ArrayList<StoreInfoResVO>(listTempListSet);

        KaKaoAddressReqVO reqVO = new KaKaoAddressReqVO();
        reqVO.setQuery(searchVO.getKeyword());
        List<KaKaoAddressResVO> kList = kakaoService.getAddressNameByKeyword(reqVO);
        if(kList != null && kList.size() > 0){
            KaKaoAddressResVO kaKaoAddressResVO = kList.get(0);
            for(String key : storeMap.keySet()){
                StoreInfoResVO storeInfoResVO = null;
                try {
                    storeInfoResVO = (StoreInfoResVO)(storeMap.get(key)).clone();
                } catch (CloneNotSupportedException e) {
                    e.printStackTrace();
                }
                double distance = DistanceUtil.distance(Double.parseDouble(kaKaoAddressResVO.getLatitude()), Double.parseDouble(kaKaoAddressResVO.getLongitude()), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
                // 검색된 주소에 1km이내 매장 검색
                if(distance <= 1){
                    storeList.add(storeInfoResVO);
                }
            }
        }

        // 중복 제거
        HashSet<StoreInfoResVO> listTempListSet2 = new HashSet<StoreInfoResVO>(storeList);
        List<StoreInfoResVO> storeList2= new ArrayList<StoreInfoResVO>(listTempListSet2);

        int nowTime = Integer.parseInt(DateUtil.getCurrentDateTime("HHmm"));
        for(Iterator<StoreInfoResVO> it = storeList2.iterator() ; it.hasNext() ; ){
            // 필터 체크 시작
            StoreInfoResVO storeInfoResVO = it.next();
            boolean flag = false;

            // 필터 체크(판매기기)
            if(!storeInfoResVO.getSell_device().contains(searchVO.getSell_device())){
                it.remove();
                continue;
            }

            // 필터 체크(서비스)
            for(String service : searchVO.getService().split(",")){
                if(service.equals("")){
                    break;
                }
                if(!storeInfoResVO.getService().contains(service)){
                    flag = true;
                    break;
                }
            }
            if(flag){
                it.remove();
                continue;
            }

            // 필터 체크(교환기기)
            if(!searchVO.getExcg_device_cate().equals("") && searchVO.getExcg_device_device().equals("")
                    && searchVO.getExcg_device_color().equals("")){
                if(!storeInfoResVO.getExcg_device().contains(searchVO.getExcg_device_cate())){
                    it.remove();
                    continue;
                }
            }else{
                // 교환기기의 재고가 없는 경우 - 칼라별로 체크하기 위함
                // ex) 화이트 재고 있음, 그레이 재고 없는 경우에 필요한 변수 : cnt
                int cnt = 0;
                for(String no_color : searchVO.getExcg_device_color().split(",")){
                    String diffStr = searchVO.getExcg_device_device() + ":" + no_color;
                    if(diffStr.equals(":")){
                        break;
                    }
                    if(storeInfoResVO.getExcg_device().contains(diffStr)) {
                        cnt++;
                    }

                    if(!storeInfoResVO.getExcg_device().contains(diffStr)){
                        flag = true;
                        break;
                    }
                }
                if(cnt==0 && flag){
                    it.remove();
                    continue;
                }
            }

            // 거리 비교(내위치와 상점위치 거리 비교)
            double distance = DistanceUtil.distance(searchVO.getMyLat(), searchVO.getMyLng(), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
            storeInfoResVO.setDistance(distance);

            // 영업중 여부 체크
            storeInfoResVO.setOper_flag(false);
            // 휴무 체크
            storeInfoResVO.setClosed_flag(false);
            if(storeInfoResVO.getClosed_date().equals("01") && !storeInfoResVO.getOper_time_start().equals("")){
                String[] oper_time_start_array = storeInfoResVO.getOper_time_start().split("/");
                String[] oper_time_end_array = storeInfoResVO.getOper_time_end().split("/");
                for(int i = 0; i < oper_time_start_array.length; i++){
                    if(Integer.parseInt(oper_time_start_array[i].replace(":","")) <= nowTime && Integer.parseInt(oper_time_end_array[i].replace(":","")) >= nowTime){
                        storeInfoResVO.setOper_flag(true);
                        break;
                    }
                }
            } else if (!storeInfoResVO.getClosed_date().equals("01")){
                storeInfoResVO.setClosed_flag(true);
            }
        }

        // list 오름 차순 정렬
        Collections.sort(storeList2, new Comparator<StoreInfoResVO>() {
        @Override
        public int compare(StoreInfoResVO o1, StoreInfoResVO o2) {
            double distance1 = o1.getDistance();
            double distance2 = o2.getDistance();
            if (distance1 == distance2)
                return 0;
            else if (distance1 > distance2)
                return 1;
            else
                return -1;
            }
        });

        // 유형순으로 정렬
        Map<String, Map<String, Object>> resultMap = new HashMap<String, Map<String, Object>>();
        for (int i = 0; i < storeList2.size(); i++) {
            StoreInfoResVO storeVO = storeList2.get(i);
            Map<String, Object> objectMap = resultMap.get(storeVO.getStore_type());
            if (objectMap == null) {
                objectMap = new HashMap<String, Object>();
                List<StoreInfoResVO> resultList = new ArrayList<>();
                resultList.add(storeVO);
                objectMap.put("storeTypeName", storeVO.getStore_type_name());
                objectMap.put("storeList", resultList);
                resultMap.put(storeVO.getStore_type(), objectMap);
            } else {
                List<StoreInfoResVO> resultList = (List<StoreInfoResVO>) objectMap.get("storeList");
                resultList.add(storeVO);
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("typeList", new TreeMap<String,Map<String,Object>>(resultMap));
        response.put("distanceList", storeList2);
        return response;
    }


    /**
     * 지역 검색 > 지역명 선택시
     * @param request
     * @param searchVO
     * @return
     */
    @RequestMapping(value = GET_STORE_LIST_BY_REGION, method = RequestMethod.POST)
    public Map<String, Object> getStoreListByLocation(HttpServletRequest request, SearchVO searchVO){
        Map<String, StoreInfoResVO> storeMap = null;
        try{
            storeMap = this.constant.getInstance().storeInfoMap;
            // storeMap Size가 0일경우 강제 Exception 발생!
            if(storeMap.size() == 0){
                throw new NullPointerException();
            }
        }catch(NullPointerException e){
            log.error("메모리 상점 데이터 NULL");
            storeMap = new HashMap<>();
            List<StoreInfoResVO> storeList = this.storeInfoService.getStoreInfoList(null);
            for(StoreInfoResVO vo : storeList) {
                storeMap.put(vo.getStore_code(), vo);
            }
            constant.getInstance().storeInfoMap = storeMap;
            log.info("DB에서 상점 정보 조회");
        }

        int nowTime = Integer.parseInt(DateUtil.getCurrentDateTime("HHmm"));
        List<StoreInfoResVO> list = new ArrayList<>();
        for(String key : storeMap.keySet()){
            StoreInfoResVO storeInfoResVO = null;
            try {
                storeInfoResVO = (StoreInfoResVO)(storeMap.get(key)).clone();
            } catch (CloneNotSupportedException e) {
                e.printStackTrace();
            }

            boolean flag = false;

            // 지역 체크
            String regionDepth1[] = searchVO.getRegionDepth1().split(",");
            for(int i = 0 ; i < regionDepth1.length ; i++){
                if(storeInfoResVO.getStore_addr().startsWith(regionDepth1[i])){
                    flag = false;
                    break;
                }
                flag = true;
            }
            if(flag){
                continue;
            }

            if(!storeInfoResVO.getStore_addr().contains(searchVO.getRegionDepth2())){
                continue;
            }

            // 필터 체크 시작

            // 필터 체크(판매기기)
            if(!storeInfoResVO.getSell_device().contains(searchVO.getSell_device())){
                continue;
            }

            // 필터 체크(서비스)
            for(String service : searchVO.getService().split(",")){
                if(service.equals("")){
                    break;
                }
                if(!storeInfoResVO.getService().contains(service)){
                    flag = true;
                    break;
                }
            }
            if(flag){
                continue;
            }

            // 필터 체크(교환기기)
            if(!searchVO.getExcg_device_cate().equals("") && searchVO.getExcg_device_device().equals("")
                    && searchVO.getExcg_device_color().equals("")){
                if(!storeInfoResVO.getExcg_device().contains(searchVO.getExcg_device_cate())){
                    continue;
                }
            }else{
                // 교환기기의 재고가 없는 경우 - 칼라별로 체크하기 위함
                // ex) 화이트 재고 있음, 그레이 재고 없는 경우에 필요한 변수 : cnt
                int cnt = 0;
                for(String no_color : searchVO.getExcg_device_color().split(",")){
                    String diffStr = searchVO.getExcg_device_device() + ":" + no_color;
                    if(diffStr.equals(":")){
                        break;
                    }
                    if(storeInfoResVO.getExcg_device().contains(diffStr)) {
                        cnt++;
                    }

                    if(!storeInfoResVO.getExcg_device().contains(diffStr)){
                        flag = true;
                        break;
                    }
                }
                if(cnt==0 && flag){
                    continue;
                }
            }
            // 필터 체크 끝

            // 거리 비교(내 위치 와 상점 좌표)
            double distance = DistanceUtil.distance(searchVO.getLatitude(), searchVO.getLongitude(), storeInfoResVO.getLatitude(), storeInfoResVO.getLongitude());
            storeInfoResVO.setDistance(distance);

            // 영업중 여부 체크
            storeInfoResVO.setOper_flag(false);
            // 휴무 체크
            storeInfoResVO.setClosed_flag(false);
            if(storeInfoResVO.getClosed_date().equals("01") && !storeInfoResVO.getOper_time_start().equals("")){
                String[] oper_time_start_array = storeInfoResVO.getOper_time_start().split("/");
                String[] oper_time_end_array = storeInfoResVO.getOper_time_end().split("/");
                for(int i = 0; i < oper_time_start_array.length; i++){
                    if(Integer.parseInt(oper_time_start_array[i].replace(":","")) <= nowTime && Integer.parseInt(oper_time_end_array[i].replace(":","")) >= nowTime){
                        storeInfoResVO.setOper_flag(true);
                        break;
                    }
                }
            } else if (!storeInfoResVO.getClosed_date().equals("01")){
                storeInfoResVO.setClosed_flag(true);
            }
            list.add(storeInfoResVO);
        }
        // list 오름 차순 정렬
        Collections.sort(list, new Comparator<StoreInfoResVO>() {
            @Override
            public int compare(StoreInfoResVO o1, StoreInfoResVO o2) {
                double distance1 = o1.getDistance();
                double distance2 = o2.getDistance();
                if (distance1 == distance2)
                    return 0;
                else if (distance1 > distance2)
                    return 1;
                else
                    return -1;
            }
        });

        // 유형순으로 정렬
        Map<String, Map<String, Object>> resultMap = new HashMap<String, Map<String, Object>>();
        for (int i = 0; i < list.size(); i++) {
            StoreInfoResVO storeVO = list.get(i);
            Map<String, Object> objectMap = resultMap.get(storeVO.getStore_type());
            if (objectMap == null) {
                objectMap = new HashMap<String, Object>();
                List<StoreInfoResVO> resultList = new ArrayList<>();
                resultList.add(storeVO);
                objectMap.put("storeTypeName", storeVO.getStore_type_name());
                objectMap.put("storeList", resultList);
                resultMap.put(storeVO.getStore_type(), objectMap);
            } else {
                List<StoreInfoResVO> resultList = (List<StoreInfoResVO>) objectMap.get("storeList");
                resultList.add(storeVO);
            }
        }

        Map<String, Object> response = new HashMap<>();
        response.put("typeList", new TreeMap<String,Map<String,Object>>(resultMap));
        response.put("distanceList", list);
        return response;
    }


    /**
     * 지역 검색 > 지역 정보
     * @param reqVO
     * @return
     */
    @RequestMapping(value = GET_REGION_LIST, method = RequestMethod.POST)
    public List<RegionVO> getRegionList(RegionVO reqVO){
        return this.mainService.getRegionList(reqVO);
    }

    /**
     * 길찾기 > 도착 매장
     * @param keyword
     * @return
     */
    @RequestMapping(value = GET_STORE_LIST_BY_KEYWORD, method = RequestMethod.POST)
    public List<StoreInfoResVO> getStoreListByKeyword(String keyword){
        Map<String, StoreInfoResVO> storeMap = null;
        try{
            storeMap = constant.getInstance().storeInfoMap;
            // storeMap Size가 0일경우 강제 Exception 발생!
            if(storeMap.size() == 0){
                throw new NullPointerException();
            }
        }catch(NullPointerException e){
            log.error("메모리 상점 데이터 NULL");
            storeMap = new HashMap<>();
            List<StoreInfoResVO> storeList = this.storeInfoService.getStoreInfoList(null);
            for(StoreInfoResVO vo : storeList) {
                storeMap.put(vo.getStore_code(), vo);
            }
            constant.getInstance().storeInfoMap = storeMap;
            log.info("DB에서 상점 정보 조회");
        }

        List<StoreInfoResVO> resultList=  new ArrayList<>();

        for(String key: storeMap.keySet()){
            StoreInfoResVO resVO = storeMap.get(key);
            if(resVO.getStore_name().contains(keyword) || resVO.getStore_addr().contains(keyword)){
                resVO.setTitle(resVO.getStore_name());
                resVO.setSubTitle(resVO.getStore_addr());
                resultList.add(resVO);
            }
        }
        Collections.sort(resultList, new Comparator<StoreInfoResVO>() {
            @Override
            public int compare(StoreInfoResVO o1, StoreInfoResVO o2) {
                String store_type1 = o1.getStore_type();
                String store_type2 = o2.getStore_type();
                return store_type1.compareTo(store_type2);
            }
        });
        return resultList;
    }


    /**
     * 매장 검색 결과 > 매장 상세보기
     * @param reqVO
     * @return
     */
    @RequestMapping(value = GET_STORE_DETAIL, method = RequestMethod.POST)
    public StoreDetailVO getStoreDetail(StoreDetailVO reqVO){
        return this.mainService.getStoreDetailByStoreCode(reqVO);
    }


    @RequestMapping(value = SEND_SURVEY, method = RequestMethod.POST)
    public Map<String, Object> sendSurvey(SurveyVO reqVO, HttpServletRequest request){
        reqVO.setIp_addr(Sha256Util.encrypt(ClientUtil.getRemoteIP(request)));
        reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
        Map<String, Object> resultMap = this.mainService.surveyRegAction(reqVO);
        return resultMap;
    }
}
