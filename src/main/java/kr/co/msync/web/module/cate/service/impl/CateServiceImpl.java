package kr.co.msync.web.module.cate.service.impl;

import kr.co.msync.web.module.cate.dao.CateMapper;
import kr.co.msync.web.module.cate.model.req.CateReqVO;
import kr.co.msync.web.module.cate.model.res.CateResVO;
import kr.co.msync.web.module.cate.service.CateService;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.util.Const;
import kr.co.msync.web.module.util.FileUtil;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Service("cateService")
@Transactional
public class CateServiceImpl implements CateService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private Properties config;

	@Autowired
	private CateMapper cateMapper;

	@Override
	public List<CateResVO> getCateList(CateReqVO reqVO) {
		return cateMapper.getCateList(reqVO);

	}

	@Override
	public List<CateResVO> getCateExcelList(CateReqVO reqVO) {
		return cateMapper.getCateExcelList(reqVO);
	}

	@Override
	public int getCateListCnt(CateReqVO reqVO) {
		return cateMapper.getCateListCnt(reqVO);
	}

	@Override
	public CateResVO getCateInfo(CateReqVO reqVO) {
		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.카테고리.getValue());
		histVO.setNo_user(reqVO.getMod_id());
		histVO.setAction_time(reqVO.getMod_date());
		histVO.setAction_status(ActionType.SEL.getValue());
		histVO.setNo_seq(reqVO.getNo_cate());

		commonService.regHistoryAction(histVO);
		return cateMapper.getCateInfo(reqVO);
	}

	@Override
	public int cateDelAction(CateReqVO reqVO) {

		// 판매기기 맵핑 삭제(tb_sell_device_map)
		int sellMapDelCnt = cateMapper.sellDeviceMapDelAction(reqVO);

		int deviceColorMapDelCnt = 0;
		for(String no_cate : reqVO.getDel_no_cate()) {
			String[] del_no_device = cateMapper.getDeviceSeq(no_cate);
			if(del_no_device!=null && del_no_device.length>0) {
				reqVO.setDel_no_device(del_no_device);

				// 기기-컬러 맵핑 삭제(tb_device_color_map)
				deviceColorMapDelCnt = cateMapper.deviceColorMapDelAction(reqVO);
			}
		}

		// 교환기기 맵핑 삭제(tb_excg_device_map);
		int excgMapDelCnt = cateMapper.excgDeviceMapAction(reqVO);

		// 기기 마스터 삭제(tb_device_master)
		int deviceMasterDelCnt = cateMapper.deviceMasterDelAction(reqVO);

		// 카테고리 삭제
		int cateDelCnt = cateMapper.cateDelAction(reqVO);

		for(String s : reqVO.getDel_no_cate()) {
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.카테고리.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.DEL.getValue());
			histVO.setNo_seq(s);

			commonService.regHistoryAction(histVO);

		}

		return sellMapDelCnt+deviceMasterDelCnt+deviceColorMapDelCnt+excgMapDelCnt+cateDelCnt;
	}

	@Override
	public boolean cateRegAction(Map<String, MultipartFile> fileMap, CateReqVO reqVO) {
		boolean isRegister = true;

		reqVO.setDel_yn(YesNoType.NO.getValue());

		String filePath = Const.PATH_UPLOAD + Const.PATH_CATEGORT;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_CATEGORT;

		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_CATEGORT;
		}

		File dir = new File(fileFullPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}

		try {
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						CateReqVO fileVO = new CateReqVO();
						fileVO.setNo_cate(reqVO.getNo_cate());
						fileVO.setCate_name(reqVO.getCate_name());
						fileVO.setFile_path(filePath);
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setSell_yn(reqVO.getSell_yn());
						fileVO.setExcg_yn(reqVO.getExcg_yn());
						fileVO.setDel_yn(reqVO.getDel_yn());
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						cateMapper.cateRegAction(fileVO);
					}
				}
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.카테고리.getValue());
			histVO.setNo_user(reqVO.getReg_id());
			histVO.setAction_time(reqVO.getReg_date());
			histVO.setAction_status(ActionType.REG.getValue());
			histVO.setNo_seq(reqVO.getNo_cate());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isRegister = false;
		}

		return isRegister;
	}

	@Override
	public boolean cateModAction(Map<String, MultipartFile> fileMap, CateReqVO reqVO) {

		boolean isModify = true;

		String filePath = Const.PATH_UPLOAD + Const.PATH_CATEGORT;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_CATEGORT;

		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_CATEGORT;
		}

		File dir = new File(fileFullPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}

		try {
			int i = 0;
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						reqVO.setFile_path(filePath);
						reqVO.setOrigin_name(f.getOriginalFilename());
						reqVO.setSave_name(saveFileName);
						reqVO.setFile_size(String.valueOf(f.getSize()));
						reqVO.setWidth(String.valueOf(map.get("width")));
						reqVO.setHeight(String.valueOf(map.get("height")));
						reqVO.setFile_ext(fileExt);
					}
				}
				i++;
			}
			cateMapper.cateModAction(reqVO);

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.카테고리.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.MOD.getValue());
			histVO.setNo_seq(reqVO.getNo_cate());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isModify = false;
		}

		return isModify;
	}

}
