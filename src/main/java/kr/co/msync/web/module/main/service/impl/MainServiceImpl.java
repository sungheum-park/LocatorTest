package kr.co.msync.web.module.main.service.impl;

import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.kakao.service.KaKaoService;
import kr.co.msync.web.module.main.dao.MainMapper;
import kr.co.msync.web.module.main.model.*;
import kr.co.msync.web.module.main.service.MainService;
import org.springframework.transaction.annotation.Transactional;
import kr.co.msync.web.module.util.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Slf4j
@Service
@Transactional
public class MainServiceImpl implements MainService {

    @Autowired
    private MainMapper mainMapper;

    @Autowired
    private KaKaoService kakaoService;

    /**
     * 지역 검색 > 지역목록
     * @param reqVO
     * @return
     */
    @Override
    public List<RegionVO> getRegionList(RegionVO reqVO) {
        return mainMapper.getRegionList(reqVO);
    }

    /**
     * 필터 > 서비스 목록
     * @return
     */
    @Override
    public List<ServiceVO> getServiceAll() {
        return this.mainMapper.getServiceAll(new ServiceVO());
    }

    /**
     * 필터 > 교환기기, 판매기기
     * @return
     */
    @Override
    public List<CategoryVO> getCategoryList() {
        CategoryVO categoryVO = new CategoryVO();
        List<CategoryVO> categoryList = this.mainMapper.getCategoryList(categoryVO);

        for(CategoryVO obj : categoryList){
            DeviceVO deviceVO = new DeviceVO();
            deviceVO.setNo_cate(obj.getNo_cate());
            if("Y".equals(obj.getExcg_yn())) {
                obj.setDeviceList(this.mainMapper.getDeviceList(deviceVO));
                for(DeviceVO deviceObj : obj.getDeviceList()){
                    deviceObj.setDeviceColorList(this.mainMapper.getDeviceColorList(deviceObj));
                }
            }
        }
        return categoryList;
    }

    @Override
    public List<StoreMasterVO> getStoreListByKeyword(String keyword) {
        return this.mainMapper.getStoreListByKeyword(keyword);
    }

    @Override
    public List<StoreMasterVO> getStoreListByRegion(SearchVO searchVO) {
        return this.mainMapper.getStoreListByRegion(searchVO);
    }

    @Override
    public StoreDetailVO getStoreDetailByStoreCode(StoreDetailVO reqVO) {
        StoreDetailVO resVO = this.mainMapper.getStoreDetailByStoreCode(reqVO);
        if(resVO == null){
            return null;
        }

        int nowTime = Integer.parseInt(DateUtil.getCurrentDateTime("HHmm"));
        resVO.setOper_flag(false);
        resVO.setClosed_flag(false);
        if(resVO.getClosed_date().equals("01") && !resVO.getOper_time_start().equals("")){
            String[] oper_time_start_array = resVO.getOper_time_start().split("/");
            String[] oper_time_end_array = resVO.getOper_time_end().split("/");
            for(int i = 0; i < oper_time_start_array.length; i++){
                if(Integer.parseInt(oper_time_start_array[i].replace(":","")) <= nowTime && Integer.parseInt(oper_time_end_array[i].replace(":","")) >= nowTime){
                    resVO.setOper_flag(true);
                    break;
                }
            }
        } else if (!resVO.getClosed_date().equals("01")){
            resVO.setClosed_flag(true);
        }
        resVO.setStorePhotoList(this.mainMapper.getStorePhotoByStoreCode(reqVO));
        resVO.setStoreServiceList(this.mainMapper.getStoreServiceByStoreCode(reqVO));
        resVO.setStoreSellDeviceList(this.mainMapper.getStoreSellDeviceList(reqVO));
        List<Map<String, Object>> excgMapList = this.mainMapper.getStoreExcgDeviceList(reqVO);

        List<CategoryVO> categoryTempList = new ArrayList<>();
        List<DeviceVO> deviceTempList = new ArrayList<>();
        List<DeviceColorVO> deviceColorList = new ArrayList<>();


        for (Map<String, Object> map : excgMapList) {
            CategoryVO categoryVO = new CategoryVO();
            categoryVO.setNo_cate(String.valueOf(map.get("no_cate")));
            categoryVO.setCate_name(String.valueOf(map.get("cate_name")));
            categoryVO.setFile_path(String.valueOf(map.get("cate_file_path")));
            categoryVO.setSave_name(String.valueOf(map.get("cate_save_name")));
            categoryVO.setWidth(String.valueOf(map.get("cate_width")));
            categoryVO.setHeight(String.valueOf(map.get("cate_height")));
            categoryVO.setSell_yn(String.valueOf(map.get("sell_yn")));
            categoryVO.setExcg_yn(String.valueOf(map.get("excg_yn")));
            categoryVO.setReg_date(String.valueOf(map.get("reg_date")));
            categoryTempList.add(categoryVO);

            DeviceVO deviceVO = new DeviceVO();
            deviceVO.setNo_device(String.valueOf(map.get("no_device")));
            deviceVO.setNo_cate(String.valueOf(map.get("no_cate")));
            deviceVO.setDevice_name(String.valueOf(map.get("device_name")));
            deviceVO.setFile_path(String.valueOf(map.get("device_file_path")));
            deviceVO.setSave_name(String.valueOf(map.get("device_save_name")));
            deviceVO.setWidth(String.valueOf(map.get("device_width")));
            deviceVO.setHeight(String.valueOf(map.get("device_height")));
            deviceTempList.add(deviceVO);

            DeviceColorVO deviceColor = new DeviceColorVO();
            deviceColor.setNo_device(String.valueOf(map.get("no_device")));
            deviceColor.setNo_color(String.valueOf(map.get("no_color")));
            deviceColor.setColor_name(String.valueOf(map.get("color_name")));
            deviceColor.setColor_rgb(String.valueOf(map.get("color_rgb")));
            deviceColor.setColor_sno(String.valueOf(map.get("color_sno")));
            deviceColor.setLimit_yn(String.valueOf(map.get("limit_yn")));
            deviceColor.setQty(String.valueOf(map.get("device_qty")));
            deviceColor.setFile_path(String.valueOf(map.get("color_file_path")));
            deviceColor.setSave_name(String.valueOf(map.get("color_save_name")));
            deviceColorList.add(deviceColor);
        }


        // 중복 제거
        HashSet<CategoryVO> categoryTempListSet = new HashSet<CategoryVO>(categoryTempList);
        List<CategoryVO> categoryList = new ArrayList<CategoryVO>(categoryTempListSet);
        // 오름 차순 정렬
        Collections.sort(categoryList, new Comparator<CategoryVO>() {
            @Override
            public int compare(CategoryVO o1, CategoryVO o2) {
                return o2.getReg_date().compareTo(o1.getReg_date());
            }
        });


        // 중복 제거
        HashSet<DeviceVO> deviceTempListSet = new HashSet<DeviceVO>(deviceTempList);
        List<DeviceVO> deviceList = new ArrayList<DeviceVO>(deviceTempListSet);
        // 오름 차순 정렬
        Collections.sort(deviceList, new Comparator<DeviceVO>() {
            @Override
            public int compare(DeviceVO o1, DeviceVO o2) {
                return o1.getNo_device().compareTo(o2.getNo_device());
            }
        });
        resVO.setExcg_total_count(String.valueOf(deviceList.size()));

        for (CategoryVO category : categoryList) {
            for (DeviceVO deviceVO : deviceList) {
                if (category.getNo_cate().equals(deviceVO.getNo_cate())) {
                    category.getDeviceList().add(deviceVO);
                    for(Iterator<DeviceColorVO> it = deviceColorList.iterator() ; it.hasNext() ; ){
                        DeviceColorVO deviceColorVO = it.next();
                        if(deviceVO.getNo_device().equals(deviceColorVO.getNo_device())){
                            deviceVO.getDeviceColorList().add(deviceColorVO);
                            it.remove();
                        }
                    }
                }
            }
        }
        resVO.setStoreExcgDeviceList(categoryList);

        return resVO;
    }

    @Override
    public int updateStoreXY() {
        List<StoreMasterVO> storeList = this.mainMapper.getStoreAll();
        int result = 0;
        for(StoreMasterVO reqVO : storeList){
            KaKaoAddressToXYResVO resVO = this.kakaoService.getAddressByKeyword(new KaKaoAddressToXYReqVO(reqVO.getStore_addr()));
            if(resVO != null){
                reqVO.setLatitude(resVO.getLongitude());
                reqVO.setLongitude(resVO.getLatitude());
            }
            result += this.mainMapper.updateStoreXY(reqVO);
        }
        return result;
    }

    @Override
    public Map<String, Object> surveyRegAction(SurveyVO reqVO) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result_code", "NG");
        resultMap.put("message", "잠시 후 다시 시도해주세요");
        int count = this.mainMapper.getSurveyCount(reqVO);
        if(count > 0){
            resultMap.put("message", "이미 설문조사에 참여 하셨습니다.");
            return resultMap;
        }
        int result = this.mainMapper.surveyRegAction(reqVO);
        if(result > 0){
            resultMap.put("result_code", "OK");
            resultMap.put("message", "설문에 참여해 주셔서 감사합니다.");
            return resultMap;
        }
        return resultMap;
    }

    @Override
    public NoticeVO getNotice() {
        return mainMapper.getNotice();
    }
}
