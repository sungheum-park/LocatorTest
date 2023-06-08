package kr.co.msync.web.module.store.service.impl;

import kr.co.msync.web.module.common.dao.CodeMapper;
import kr.co.msync.web.module.common.model.req.CodeReqVO;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.model.res.CodeResVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressReqVO;
import kr.co.msync.web.module.kakao.model.req.KaKaoAddressToXYReqVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressResVO;
import kr.co.msync.web.module.kakao.model.res.KaKaoAddressToXYResVO;
import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import kr.co.msync.web.module.scheduler.service.StoreInfoService;
import kr.co.msync.web.module.store.dao.StoreMapper;
import kr.co.msync.web.module.store.model.req.StoreFileReqVO;
import kr.co.msync.web.module.store.model.req.StoreReqVO;
import kr.co.msync.web.module.store.model.res.StoreResVO;
import kr.co.msync.web.module.store.service.StoreService;
import kr.co.msync.web.module.util.*;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.StopWatch;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.net.ssl.HttpsURLConnection;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

@Slf4j
@Service("storeService")
@Transactional
public class StoreServiceImpl implements StoreService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private Properties config;

	@Autowired
	private StoreMapper storeMapper;

	@Autowired
	private StoreInfoService storeInfoService;

	@Autowired
	private CodeMapper codeMapper;

	private MenuConstant constant;

	@Value("#{config['api.kakao.rest.url']}")
	private String kakaoURL;

	@Value("#{config['api.kakao.rest.authKey']}")
	private String kakaoAppKey;

	@Override
	public List<StoreResVO> getStoreList(StoreReqVO reqVO) {
		return storeMapper.getStoreList(reqVO);

	}

	@Override
	public List<StoreResVO> getStoreExcelList(StoreReqVO reqVO) {
		return storeMapper.getStoreExcelList(reqVO);
	}

	@Override
	public int getStoreListCnt(StoreReqVO reqVO) {
		return storeMapper.getStoreListCnt(reqVO);
	}

	@Override
	public String storeRegAction(Map<String, MultipartFile> fileMap, StoreReqVO reqVO) {
		try {
			String filePath = Const.PATH_UPLOAD + Const.PATH_STORE;
			String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_STORE;

			if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
				fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_STORE;
			}

			File dir = new File(fileFullPath);
			if(!dir.isDirectory()){
				dir.mkdirs();
			}

			//소매점 코드 중복 체크
			if(StringUtils.isNotBlank(reqVO.getRetail_store_code())){
				Map map = new HashMap();
				map.put("retail_store_code", reqVO.getRetail_store_code());
				if(storeMapper.storeRetailCodeCnt(map) > 0){
					return "RETAIL_CODE_DUE";
				}
			}

			// 매장 등록
			storeMapper.storeRegAction(reqVO);

			// 판매기기 등록
			if(reqVO.getSelected_sell_no_cate()!=null){
				for(int i = 0 ; i < reqVO.getSelected_sell_no_cate().length; i++) {
					StoreReqVO sellReqVO = new StoreReqVO();
					sellReqVO.setStore_code(reqVO.getStore_code());
					sellReqVO.setNo_cate(reqVO.getSelected_sell_no_cate()[i]);
					sellReqVO.setCate_sno(reqVO.getSelected_cate_sno()[i]);
					sellReqVO.setDevice_qty("1");
					storeMapper.storeSellDeviceRegAction(sellReqVO);
				}
			}


			// 교환기기 등록
			if(reqVO.getSelected_excg_no_device()!=null){
				for(int i = 0, cnt = 0 ; i < reqVO.getSelected_excg_no_device().length; i++) {
					StoreReqVO excgReqVo = new StoreReqVO();
					excgReqVo.setStore_code(reqVO.getStore_code());
					excgReqVo.setNo_cate(reqVO.getSelected_no_cate()[i]);
					excgReqVo.setNo_device(reqVO.getSelected_excg_no_device()[i]);
					if(reqVO.getSelected_no_color()!=null) {
						for (int j = 0; j < reqVO.getSelected_no_color().length; j++) {
							if (reqVO.getSelected_excg_no_device()[i].equals(reqVO.getSelected_no_color()[j].substring(0, 5))) {
								excgReqVo.setNo_color(reqVO.getSelected_no_color()[j].substring(6, 9));
								excgReqVo.setDevice_qty(reqVO.getSelected_device_qty()[cnt + Integer.parseInt(reqVO.getSelected_no_color()[j].substring(10, reqVO.getSelected_no_color()[j].length())) - 1]);
								storeMapper.storeExcgDeviceRegAction(excgReqVo);
							}
						}
					}
					cnt+=Integer.parseInt(reqVO.getDevice_color_length()[i]);
				}
			}

			// 서비스 등록
			if(reqVO.getSelected_no_service()!=null) {
				for (String no_service : reqVO.getSelected_no_service()) {
					StoreReqVO serviceReqVo = new StoreReqVO();
					serviceReqVo.setStore_code(reqVO.getStore_code());
					serviceReqVo.setNo_service(no_service);
					storeMapper.storeServiceRegAction(serviceReqVo);
				}
			}

			// 파일 등록
			int i = 0;
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						StoreFileReqVO fileVO = new StoreFileReqVO();
						fileVO.setStore_code(reqVO.getStore_code());
						fileVO.setFile_path(filePath);
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setFile_sno(String.valueOf(i));
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						storeMapper.storePhotoRegAction(fileVO);
					}
				}
				i++;
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.매장.getValue());
			histVO.setNo_user(reqVO.getReg_id());
			histVO.setAction_time(reqVO.getReg_date());
			histVO.setAction_status(ActionType.REG.getValue());
			histVO.setNo_seq(reqVO.getStore_code());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			return "false";
		}

		return "true";
	}

	@Override
	public String storeModAction(Map<String, MultipartFile> fileMap, StoreReqVO reqVO) {
		try {
			String filePath = Const.PATH_UPLOAD + Const.PATH_STORE;
			String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_STORE;

			if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
				fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_STORE;
			}

			File dir = new File(fileFullPath);
			if(!dir.isDirectory()){
				dir.mkdirs();
			}

			//소매점 코드 중복 체크
			if(StringUtils.isNotBlank(reqVO.getRetail_store_code())){
				Map map = new HashMap();
				map.put("retail_store_code", reqVO.getRetail_store_code());
				map.put("store_code", reqVO.getStore_code());
				if(storeMapper.storeRetailCodeCnt(map) > 0){
					return "RETAIL_CODE_DUE";
				}
			}

			// 매장 등록
			storeMapper.storeModAction(reqVO);

			// 판매기기 등록
			storeMapper.storeAllSellDeviceDelAction(reqVO);

			if(reqVO.getSelected_sell_no_cate()!=null){
				for(int i = 0 ; i < reqVO.getSelected_sell_no_cate().length; i++) {
					StoreReqVO sellReqVO = new StoreReqVO();
					sellReqVO.setStore_code(reqVO.getStore_code());
					sellReqVO.setNo_cate(reqVO.getSelected_sell_no_cate()[i]);
					sellReqVO.setCate_sno(reqVO.getSelected_cate_sno()[i]);
					sellReqVO.setDevice_qty("1");
					storeMapper.storeSellDeviceRegAction(sellReqVO);
				}
			}


			// 교환기기 등록
			storeMapper.storeAllExcgDeviceDelAction(reqVO);
			if(reqVO.getSelected_excg_no_device()!=null){
				for(int i = 0, cnt = 0 ; i < reqVO.getSelected_excg_no_device().length; i++) {
					StoreReqVO excgReqVo = new StoreReqVO();
					excgReqVo.setStore_code(reqVO.getStore_code());
					excgReqVo.setNo_cate(reqVO.getSelected_no_cate()[i]);
					excgReqVo.setNo_device(reqVO.getSelected_excg_no_device()[i]);
					if(reqVO.getSelected_no_color()!=null) {
						for (int j = 0; j < reqVO.getSelected_no_color().length; j++) {
							if (reqVO.getSelected_excg_no_device()[i].equals(reqVO.getSelected_no_color()[j].substring(0, 5))) {
								excgReqVo.setNo_color(reqVO.getSelected_no_color()[j].substring(6, 9));
								excgReqVo.setDevice_qty(reqVO.getSelected_device_qty()[cnt + Integer.parseInt(reqVO.getSelected_no_color()[j].substring(10, reqVO.getSelected_no_color()[j].length())) - 1]);
								storeMapper.storeExcgDeviceRegAction(excgReqVo);
							}
						}
					}
					cnt+=Integer.parseInt(reqVO.getDevice_color_length()[i]);
				}
			}

			// 서비스 등록
			storeMapper.storeAllServiceDelAction(reqVO);
			if(reqVO.getSelected_no_service()!=null) {
				for (String no_service : reqVO.getSelected_no_service()) {
					StoreReqVO serviceReqVo = new StoreReqVO();
					serviceReqVo.setStore_code(reqVO.getStore_code());
					serviceReqVo.setNo_service(no_service);
					storeMapper.storeServiceRegAction(serviceReqVo);
				}
			}

			// 기존 파일중 삭제된 파일 삭제
 			if(reqVO.getNo_file_array()!=null){
				storeMapper.storePastFileDelAction(reqVO);
			}

			// 파일 등록
			int i = 0;
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						StoreFileReqVO fileVO = new StoreFileReqVO();
						fileVO.setStore_code(reqVO.getStore_code());
						fileVO.setFile_path(filePath);
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setFile_sno(String.valueOf(i));
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						storeMapper.storePhotoRegAction(fileVO);
					}
				}
				i++;
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.매장.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.MOD.getValue());
			histVO.setNo_seq(reqVO.getStore_code());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			return "false";

		}

		return "true";
	}

	@Override
	public StoreResVO getStoreInfo(StoreReqVO reqVO, String actionType) {
		if(ActionType.SEL.getValue().equals(actionType)){
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.매장.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.SEL.getValue());
			histVO.setNo_seq(reqVO.getStore_code());

			commonService.regHistoryAction(histVO);
		}
		return storeMapper.getStoreInfo(reqVO);
	}

	@Override
	public int storeDelAction(StoreReqVO reqVO) {

		int resultcnt = storeMapper.storeDelAction(reqVO);

		for(String s : reqVO.getDel_store_code()) {
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.매장.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.DEL.getValue());
			histVO.setNo_seq(s);

			commonService.regHistoryAction(histVO);

		}

		return resultcnt;
	}

	@Override
	public List<StoreResVO> getStoreSellDeviceList(StoreReqVO reqVO) {
		return storeMapper.getStoreSellDeviceList(reqVO);
	}

	@Override
	public List<StoreResVO> getStoreExcgDeviceList(StoreReqVO reqVO) {
		return storeMapper.getStoreExcgDeviceList(reqVO);
	}

	@Override
	public List<StoreResVO> getOfferServiceList(StoreReqVO reqVO) {
		return storeMapper.getOfferServiceList(reqVO);
	}

	@Override
	public int storeAllParkingModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllParkingModAction(reqVO);
	}

	@Override
	public int storeAllTreatModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllTreatModAction(reqVO);
	}

	@Override
	public int storeAllStatusModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllStatusModAction(reqVO);
	}

	@Override
	public int storeAllOperTimeModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllOperTimeModAction(reqVO);
	}

	@Override
	public int storeAllStoreOperTimeModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllStoreOperTimeModAction(reqVO);
	}

	@Override
	public int storeAllClosedDateModAction(StoreReqVO reqVO) {
		return storeMapper.storeAllClosedDateModAction(reqVO);
	}

	@Override
	public int storeAllSellDeviceModAction(StoreReqVO reqVO) {

		int resultCnt = 0;

		if(reqVO.getStore_code_array()!=null) {
			for(String store_code : reqVO.getStore_code_array()) {
				StoreReqVO vo = new StoreReqVO();
				vo.setStore_code(store_code);
				storeMapper.storeAllSellDeviceDelAction(vo);
				if(reqVO.getSelected_no_cate()!=null) {
					for(int i = 0 ; i < reqVO.getSelected_no_cate().length; i++) {
						vo.setNo_cate(reqVO.getSelected_no_cate()[i]);
						vo.setCate_sno(reqVO.getSelected_cate_sno()[i]);
						vo.setDevice_qty(reqVO.getSelected_device_qty()[i]);
						int updateCnt = storeMapper.storeAllSellDeviceModAction(vo);
						resultCnt += updateCnt;
					}
				}
				storeMapper.updateStoreModDateUpdate(reqVO);
			}
		}

		return resultCnt;
	}

	@Override
	public int storeAllExcgDeviceModAction(StoreReqVO reqVO) {

		int resultCnt = 0;

		if(reqVO.getStore_code_array()!=null) {
			for (String store_code : reqVO.getStore_code_array()) {
				StoreReqVO vo = new StoreReqVO();
				vo.setStore_code(store_code);
				storeMapper.storeAllExcgDeviceDelAction(vo);
				if(reqVO.getSelected_excg_no_device()!=null) {
					for (int i = 0, cnt = 0; i < reqVO.getSelected_excg_no_device().length; i++) {
						vo.setNo_cate(reqVO.getSelected_no_cate()[i]);
						vo.setNo_device(reqVO.getSelected_excg_no_device()[i]);
						if(reqVO.getSelected_no_color()!=null) {
							for (int j = 0; j < reqVO.getSelected_no_color().length; j++) {
								if (reqVO.getSelected_excg_no_device()[i].equals(reqVO.getSelected_no_color()[j].substring(0, 5))) {
									vo.setNo_color(reqVO.getSelected_no_color()[j].substring(6, 9));
									vo.setDevice_qty(reqVO.getSelected_device_qty()[cnt + Integer.parseInt(reqVO.getSelected_no_color()[j].substring(10, reqVO.getSelected_no_color()[j].length())) - 1]);
									int updateCnt = storeMapper.storeAllExcgDeviceModAction(vo);
									resultCnt += updateCnt;
								}
							}
							cnt += Integer.parseInt(reqVO.getDevice_color_length()[i]);
						}
					}
				}
				storeMapper.updateStoreModDateUpdate(reqVO);
			}
		}

		return resultCnt;

	}

	@Override
	public int storeAllServiceModAction (StoreReqVO reqVO){

		int resultCnt = 0;

		if(reqVO.getStore_code_array()!=null) {
			for (String store_code : reqVO.getStore_code_array()) {
				StoreReqVO vo = new StoreReqVO();
				vo.setStore_code(store_code);
				storeMapper.storeAllServiceDelAction(vo);
				if(reqVO.getSelected_no_service()!=null) {
					for (String no_service : reqVO.getSelected_no_service()) {
						vo.setNo_service(no_service);
						int updateCnt = storeMapper.storeAllServiceModAction(vo);
						resultCnt += updateCnt;
					}
				}
				storeMapper.updateStoreModDateUpdate(reqVO);
			}
		}

		return resultCnt;

	}

	/**
	 * 키워드로 장소 검색
	 * @param reqVO
	 * @return
	 */
	@Override
	public Map<String,Object> getAddressNameByKeyword(KaKaoAddressReqVO reqVO) {

		Map<String,Object> resultMap = new HashMap<String,Object>();

		try {
			JSONArray result = connectionAPI("/local/search/keyword.json?", String.format("query=%s", URLEncoder.encode(reqVO.getQuery(), "UTF-8")));

			for(Object obj : result){
				JSONObject jObj = (JSONObject)obj;
				resultMap.put("x",jObj.getString("x"));
				resultMap.put("y",jObj.getString("y"));
				break;
			}

			if(result.size()==0){
				resultMap = getAddressByKeyword(new KaKaoAddressToXYReqVO(reqVO.getQuery()));
			}
			return resultMap;
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
	public Map<String, Object> getAddressByKeyword(KaKaoAddressToXYReqVO reqVO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		try {
			JSONArray result = connectionAPI("/local/search/address.json?", String.format("query=%s", URLEncoder.encode(reqVO.getQuery(), "UTF-8")));
			if(result.size() > 0){
				JSONObject obj = result.getJSONObject(0);
				resultMap.put("x",obj.get("y"));
				resultMap.put("y",obj.get("x"));
			}
			return resultMap;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> storeSyncAction() {
		Map<String, Object> map = new HashMap<String, Object>();

		try {

			String final_sync_date = this.getStoreSyncDate();

			List<StoreInfoResVO> storeInfoList = storeInfoService.getStoreInfoList(final_sync_date);


			if(storeInfoList != null) {
				for(StoreInfoResVO vo : storeInfoList) {
					if(vo.getDel_yn().equals("Y") || vo.getStore_status().equals("02") || vo.getStore_status().equals("04")) {
						MenuConstant.getInstance().storeInfoMap.remove(vo.getStore_code());
					}else{
						MenuConstant.getInstance().storeInfoMap.put(vo.getStore_code(), vo);
					}
				}
			}

			String sync_date = StringUtil.getTimeStamp("yyyyMMddHHmmss");
			map.put("code", ResultType.SUCCESS.getValue());
			if(storeInfoList.size()==0){
				map.put("message", "동기화 대상없음");
			} else {
				map.put("message", "동기화 성공("+storeInfoList.size()+")");
			}
			map.put("final_sync_date", sync_date);
			storeInfoService.updateSyncDate(sync_date);

		} catch (Exception e) {
			map.put("code", ResultType.FAIL.getValue());
			map.put("message", "동기화 실패");
			e.printStackTrace();
		}
		return map;

	}

	@Override
	public String getMaxModStore() {
		return storeMapper.getMaxModStore();
	}

	@Override
	public String getMaxRegStore() {
		return storeMapper.getMaxRegStore();
	}

	@Override
	public String getStoreSyncDate() {
		return storeMapper.getStoreSyncDate();
	}

	@Override
	public List<Map> getColorCodeList() {
		return storeMapper.getColorCodeList();
	}

	@Override
	public String getAllRegAction(MultipartFile file, Map map){
		StopWatch stopWatch = new StopWatch(); // 대량 등록 시간 체크
		stopWatch.reset();
		stopWatch.start();

		// 엑셀 파일이 없을 경우
		if(file == null){
			return "FILE_NULL";
		}

		// xls 엑셀 파일이 아닌 경우
		String fileName = FilenameUtils.getExtension(file.getOriginalFilename());
		if (checkExcelFileType(fileName)) return "FILE_TYPE_ERROR";

		String regId = (String) map.get("regId");
		String regName = (String) map.get("regName");

		try {
			Workbook workbook = new HSSFWorkbook(file.getInputStream());
			HSSFSheet worksheet = (HSSFSheet) workbook.getSheetAt(0);

			String filePath = Const.PATH_UPLOAD + Const.PATH_STORE;
			String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_STORE;

			if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
				fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_STORE;
			}

			File dir = new File(fileFullPath);
			if(!dir.isDirectory()) dir.mkdirs();

			if(worksheet.getPhysicalNumberOfRows() > 1001){ // 1000건까지만 등록 가능 (+1은 상단 항목 row)
				return "MAX_ERROR";
			}

			List<StoreReqVO> storeReqVOList = new ArrayList<>();
			for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {
				HSSFRow row = worksheet.getRow(i);

				//필수 값 체크
				List<Integer> checkCellNums = Arrays.asList(0,2,5,6,8,9,12,13,28);
				for(int cellNum : checkCellNums){
					if(StringUtils.isBlank(cellNullChk(row, cellNum))){
						throw new RuntimeException("REQUIRE_NULL&"+cellRequireValueString(cellNum)+"&"+i);
					}
				}

				//매장 정보, 판매기기, 교환기기, 서비스 등록
				try{
					storeReqVOList.add(excelStoreReg(row, regId, regName));
				}catch (Exception e){
					throw new RuntimeException(e+"&"+i);
				}
			}

			//매장 이미지 등록
			HSSFPatriarch drawing = worksheet.createDrawingPatriarch();
			excelImageAllReg(drawing, storeReqVOList, fileFullPath, filePath, regId, regName);

			CommonReqVO histVO = new CommonReqVO();
			histVO.setNo_menu(HistMenuType.매장.getValue());
			histVO.setNo_user(regId);
			histVO.setAction_time(StringUtil.getTimeStamp("yyyyMMddHHmmss"));
			histVO.setAction_status(ActionType.REG.getValue());
			commonService.regHistoryAction(histVO);

			stopWatch.stop();
			log.info("대량 매장 업로드 시간: %ds={}", stopWatch.getTime() / 1000);

			return "S";
		}catch (Exception e){
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	/**
	 * Excel 매장 등록
	 * @param row
	 * @param regId
	 * @param regName
	 * @return
	 */
	public StoreReqVO excelStoreReg(HSSFRow row, String regId, String regName) throws Exception {
		StoreReqVO reqVO = new StoreReqVO();
		reqVO.setReg_id(regId); // 등록자 id
		reqVO.setReg_name(regName); // 등록자 이름
		reqVO.setReg_date(StringUtil.getTimeStamp("yyyyMMddHHmmss")); //등록일
		reqVO.setDel_yn(YesNoType.NO.getValue()); // 매장 삭제 여부 N
		reqVO.setStore_type(cellValidationChk(row, 0, "store_type")); // 매장 타입
		reqVO.setRetail_store_code(cellValidationChk(row, 1, "retail_store_code")); // 소매점 코드
		reqVO.setStore_status(cellValidationChk(row, 2, "store_status")); // 매장 상태
		if(reqVO.getStore_status().equals("02")){ // 매장 상태가 개점 예정일 경우 개점 시작 예정일
			reqVO.setStore_due_date(cellValidationChk(row, 3, "date"));
		}else if(reqVO.getStore_status().equals("03")){ // 매장 상태가 폐점 예정일 경우 폐점 종료 예정일
			reqVO.setStore_due_date(cellValidationChk(row, 4, "date"));
		}
		reqVO.setStore_name(cellNullChk(row, 5)); // 매장명
		reqVO.setStore_addr(cellNullChk(row, 6)); // 매장 주소
		reqVO.setStore_addr_dtl(cellNullChk(row, 7)); // 매장 상세 주소
		reqVO.setLatitude(Double.parseDouble(cellValidationChk(row, 8, "double"))); // 위도
		reqVO.setLongitude(Double.parseDouble(cellValidationChk(row, 9, "double"))); // 경도
		reqVO.setCome_way(cellNullChk(row, 10)); // 찾아오는 길
		reqVO.setTel_num(cellNullChk(row, 11)); // 매장 전화번호
		reqVO.setParking_yn(cellValidationChk(row, 12, "boolean")); // 주차 여부
		reqVO.setOper_time(cellNullChk(row, 13)); // 영업시간
		reqVO.setAs_time(cellNullChk(row, 14)); // AS시간
		reqVO.setNotice(cellNullChk(row, 15)); // 매장 메시지
		reqVO.setClosed_date(cellNullChk(row, 16)); // 매장 휴무 설정

		String weekTime =""; // 일~토 영업시간
		for(int j=0; j<7; j++){
			if(StringUtils.isBlank(cellNullChk(row, 17+j))){
				weekTime += ' ';
			}else{
				weekTime += cellNullChk(row, 17+j);
			}
			if(j != 6) weekTime += ",";
		}
		reqVO.setOper_week_time(weekTime);
		reqVO.setTreat_yn(cellValidationChk(row, 28, "boolean")); // 악세사리 취급 여부
		reqVO.setCust_desc(cellNullChk(row, 29)); // 관리자 메모

		// 매장 코드 sequence 생성
		String storeCode = null;
		Map<String, Object> seqMap = commonService.getSequence("TB_STORE_MASTER");
		if(ResultType.SUCCESS.getValue().equals(seqMap.get("code"))){
			storeCode = (String) seqMap.get("seq");
		}

		reqVO.setStore_code(storeCode);

		// 매장 등록
		storeMapper.storeRegAction(reqVO);

		// 판매기기 등록
		if(StringUtils.isNotBlank(cellNullChk(row, 30))){
			String[] sellReqArray = cellValidationChk(row, 30, "sell_category").split(",");
			for (int i = 0; i < sellReqArray.length; i++) {
				StoreReqVO sellReqVO = new StoreReqVO();
				sellReqVO.setStore_code(reqVO.getStore_code());
				sellReqVO.setNo_cate(sellReqArray[i]);
				sellReqVO.setCate_sno(String.valueOf(i+1));
				sellReqVO.setDevice_qty("1");
				storeMapper.storeSellDeviceRegAction(sellReqVO);
			}
		}

		// 교환기기 등록
		if(StringUtils.isNotBlank(cellNullChk(row, 31))){
			String[] excgReqArray = cellValidationChk(row, 31, "excg_device").split("\\n");
			for (int i = 0; i < excgReqArray.length; i++) {
				StoreReqVO excgReqVO = new StoreReqVO();
				excgReqVO.setStore_code(reqVO.getStore_code());
				excgReqVO.setNo_cate(excgReqArray[i].substring(0,7));
				excgReqVO.setNo_device(excgReqArray[i].substring(7,12));
				excgReqVO.setDevice_qty("1");
				String[] excgColorArray = excgReqArray[i].split("&")[1].split(",");
				for (int j = 0; j < excgColorArray.length; j++) {
					excgReqVO.setNo_color(excgColorArray[j]);
					storeMapper.storeExcgDeviceRegAction(excgReqVO);
				}
			}
		}

		//서비스 등록
		if(StringUtils.isNotBlank(cellNullChk(row, 32))){
			String[] serviceReqArray = cellValidationChk(row, 32, "service").split(",");
			if(serviceReqArray.length > 0){
				for (int i = 0; i < serviceReqArray.length; i++) {
					StoreReqVO serviceReqVO = new StoreReqVO();
					serviceReqVO.setStore_code(reqVO.getStore_code());
					serviceReqVO.setNo_service(serviceReqArray[i]);
					storeMapper.storeServiceRegAction(serviceReqVO);
				}
			}
		}

		return reqVO;
	}

	/**
	 * Excel 매장 이미지 등록
	 */
	public String excelImageAllReg(HSSFPatriarch drawing, List<StoreReqVO> storeReqVOList, String fileFullPath, String filePath, String regId, String regName) throws Exception {
		for (HSSFShape shape : drawing.getChildren()) { //이미지 등록
			if (shape instanceof HSSFPicture) {
				HSSFPicture picture = (HSSFPicture) shape;
				if (picture.getPictureData() == null) { // 이미지 없는경우
					continue;
				}
				ClientAnchor anchor = picture.getPreferredSize();
				int row1 = anchor.getRow1() - 1;
				HSSFPictureData hssfPictureData = picture.getPictureData();
				InputStream in = new ByteArrayInputStream(hssfPictureData.getData());
				BufferedImage image = ImageIO.read(in);

				//Saving the file
				StoreFileReqVO fileVO = new StoreFileReqVO();
				String ext = hssfPictureData.suggestFileExtension();
				byte[] data = hssfPictureData.getData();
				int fileSno = storeReqVOList.get(row1).getFile_sno() + 1;
				String filename = storeReqVOList.get(row1).getStore_code()+"_" + fileSno +"."+ext;
				FileOutputStream out = new FileOutputStream(fileFullPath+filename);
				fileVO.setStore_code(storeReqVOList.get(row1).getStore_code());
				fileVO.setFile_path(filePath);
				fileVO.setOrigin_name(filename);
				fileVO.setSave_name(filename);
				fileVO.setFile_size(String.valueOf(data.length));
				fileVO.setWidth(String.valueOf(image.getWidth()));
				fileVO.setHeight(String.valueOf(image.getHeight()));
				fileVO.setFile_ext(ext);
				fileVO.setFile_sno(String.valueOf(fileSno));
				fileVO.setReg_id(regId);
				fileVO.setReg_name(regName);
				fileVO.setReg_date(storeReqVOList.get(row1).getReg_date());
				storeMapper.storePhotoRegAction(fileVO);
				storeReqVOList.get(row1).setFile_sno(fileSno);
				out.write(data);
				out.close();
			}
		}
		return "S";
	}

	/**
	 * Excel type 체크
	 * @param fileName
	 * @return
	 */
	public boolean checkExcelFileType(String fileName){
		return !fileName.equals("xls");
	}

	/***
	 * cell에 값 있으면 자료형 string으로 반환, 없으면 null 반환
	 * @param row
	 * @param cellNum
	 * @return
	 */
	public String cellNullChk(HSSFRow row, int cellNum) {
		try{
			if(row.getCell(cellNum).getCellType() == 0){
				if(cellNum == 8 || cellNum == 9){ // 위도, 경도
					return String.valueOf(row.getCell(cellNum).getNumericCellValue());
				}
				return String.valueOf((int)row.getCell(cellNum).getNumericCellValue());
			}
			return row.getCell(cellNum).getStringCellValue();
		} catch (Exception e) {
			return null;
		}
	}


	/**
	 * cell에 값 있으면 validation 체크 후 자료형 string으로 반환, 없으면 null 반환
	 * @param row
	 * @param cellNum
	 * @param dataType
	 * @return
	 * @throws Exception
	 */
	public String cellValidationChk(HSSFRow row, int cellNum, String dataType) throws Exception{
		Boolean result = false;
		String cellValue = cellNullChk(row, cellNum);
		StoreReqVO reqVO;

		if(StringUtils.isNotBlank(cellValue)){
			switch (dataType){
				case "date" : result = StringUtil.checkDate(cellValue); break; //날짜 형식인지 체크(yyyy-MM-dd)
				case "retail_store_code" : //소매점 코드
					if(StringUtil.isNumeric(cellValue)){ //숫자인지 체크
						Map map = new HashMap();
						map.put("retail_store_code", cellValue);
						if(storeMapper.storeRetailCodeCnt(map) == 0){ // 소매점 코드 중복 체크
							result = true;
						}else{
							throw new RuntimeException("RETAIL_CODE_DUE");
						}
					}
					break;
				case "sell_category" : // 판매 기기
					reqVO = new StoreReqVO();
					List<StoreResVO> storeSellDeviceList = storeMapper.getStoreSellDeviceList(reqVO);
					int num = 0;
					String[] sellReqArray = cellValue.split(",");
					for(int i = 0; i<sellReqArray.length; i++){
						for(int j=0; j<storeSellDeviceList.size(); j++){
							if(storeSellDeviceList.get(j).getNo_cate().equals(sellReqArray[i])) num++;
						}
					}
					if(num == sellReqArray.length) result = true;
					break;
				case "excg_device" : //교환 기기
					int cnt=0;
					String[] excgReqArray = cellValue.split("\\n");
					loop : for (int i = 0; i < excgReqArray.length; i++) {
						String[] excgColorArray = excgReqArray[i].split("&")[1].split(",");
						for (int j = 0; j < excgColorArray.length; j++) {
							Map map = new HashMap();
							map.put("no_cate", excgReqArray[i].substring(0,7));
							map.put("no_device", excgReqArray[i].substring(7,12));
							map.put("no_color", excgColorArray[j]);
							if(storeMapper.storeDeviceColorCnt(map) == 0){
								cnt++;
								break loop;
							}
						}
					}
					if(cnt == 0) result = true;
					break;
				case "service" : //서비스
					List<Map> serviceList = storeMapper.getServiceList();
					int snum = 0;
					String[] serviceReqArray = cellValue.split(",");
					for(int i = 0; i<serviceReqArray.length; i++){
						for(int j=0; j<serviceList.size(); j++){
							if(serviceList.get(j).get("no_service").equals(serviceReqArray[i])) snum++;
						}
					}
					if(snum == serviceReqArray.length) result = true;
					break;
				case "double" : if(StringUtil.isNumeric(cellValue)) result = true; break;
				case "boolean" : if(cellValue.equals("Y") || cellValue.equals("N")) result = true; break;
				default: // store_type, store_status
					CodeReqVO codeReqVO = new CodeReqVO();
					codeReqVO.setCode_group(dataType);
					codeReqVO.setUse_yn("Y");
					List<CodeResVO> codeList = codeMapper.getCodeList(codeReqVO);
					for (int j = 0; j < codeList.size(); j++) {
						if (codeList.get(j).getCode_value().equals(cellValue)) result = true;
					}
					break;
			}

			if (result){
				return cellValue;
			} else{
				throw new RuntimeException("VALIDATION_ERROR&"+cellRequireValueString(cellNum));
			}
		}else{
			return null;
		}
	}

	/**
	 * 필수 cell 값 string 변환
	 * @param cellNum
	 * @return
	 */
	public String cellRequireValueString(int cellNum){
		String result ="";
		switch (cellNum) {
			case 0 : result = "매장 타입 선택"; break;
			case 1 : result = "소매점 코드"; break;
			case 2 : result = "매장 상태"; break;
			case 3 : result = "개점 시작 예정일"; break;
			case 4 : result = "폐점 종료 예정일"; break;
			case 5 : result = "매장명"; break;
			case 6 : result = "매장 주소"; break;
			case 8 : result = "위도"; break;
			case 9 : result = "경도"; break;
			case 12 : result = "주차 여부"; break;
			case 13 : result = "영업시간"; break;
			case 28 : result = "액세서리 취급 여부"; break;
			case 30 : result = "판매 기기"; break;
			case 31 : result = "교환 기기"; break;
			case 32 : result = "서비스 등록"; break;
		}
		return result;
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
