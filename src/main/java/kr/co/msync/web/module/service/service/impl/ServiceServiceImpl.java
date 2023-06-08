package kr.co.msync.web.module.service.service.impl;

import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.service.dao.ServiceMapper;
import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.service.model.res.ServiceResVO;
import kr.co.msync.web.module.service.service.ServiceService;
import kr.co.msync.web.module.util.Const;
import kr.co.msync.web.module.util.FileUtil;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Service("serviceService")
@Transactional
public class ServiceServiceImpl implements ServiceService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private Properties config;

	@Autowired
	private ServiceMapper serviceMapper;

	@Override
	public List<ServiceResVO> getServiceList(ServiceReqVO reqVO) {
		return serviceMapper.getServiceList(reqVO);
	}

	@Override
	public List<ServiceResVO> getServiceExcelList(ServiceReqVO reqVO) {
		return serviceMapper.getServiceExcelList(reqVO);
	}

	@Override
	public int getServiceListCnt(ServiceReqVO reqVO) {
		return serviceMapper.getServiceListCnt(reqVO);
	}

	@Override
	public ServiceResVO getServiceInfo(ServiceReqVO reqVO) {
		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.서비스.getValue());
		histVO.setNo_user(reqVO.getMod_id());
		histVO.setAction_time(reqVO.getMod_date());
		histVO.setAction_status(ActionType.SEL.getValue());
		histVO.setNo_seq(reqVO.getNo_service());

		commonService.regHistoryAction(histVO);
		return serviceMapper.getServiceInfo(reqVO);
	}

	@Override
	public int serviceDelAction(ServiceReqVO reqVO) {

		int deleteCnt = serviceMapper.serviceDelAction(reqVO);
		int deleteMapCnt = serviceMapper.storeServiceMapDelAction(reqVO);

		for(String s : reqVO.getDel_no_service()) {
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.서비스.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.DEL.getValue());
			histVO.setNo_seq(s);

			commonService.regHistoryAction(histVO);

		}

		return deleteCnt+deleteMapCnt;
	}

	@Override
	public boolean serviceRegAction(Map<String, MultipartFile> fileMap, ServiceReqVO reqVO) {

		boolean isRegister = true;

		reqVO.setDel_yn(YesNoType.NO.getValue());

		String filePath = Const.PATH_UPLOAD + Const.PATH_SERVICE;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_SERVICE;

		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_SERVICE;
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
						ServiceReqVO fileVO = new ServiceReqVO();
						fileVO.setNo_service(reqVO.getNo_service());
						fileVO.setService_div(reqVO.getService_div());
						fileVO.setService_name(reqVO.getService_name());
						fileVO.setFile_path(filePath);
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setUse_yn(reqVO.getUse_yn());
						fileVO.setComment(reqVO.getComment());
						fileVO.setDel_yn(reqVO.getDel_yn());
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						serviceMapper.serviceRegAction(fileVO);
					}
				}
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.서비스.getValue());
			histVO.setNo_user(reqVO.getReg_id());
			histVO.setAction_time(reqVO.getReg_date());
			histVO.setAction_status(ActionType.REG.getValue());
			histVO.setNo_seq(reqVO.getNo_service());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isRegister = false;
		}

		return isRegister;

	}

	@Override
	public boolean serviceModAction(Map<String, MultipartFile> fileMap, ServiceReqVO reqVO) {

		boolean isModify = true;

		String filePath = Const.PATH_UPLOAD + Const.PATH_SERVICE;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_SERVICE;

		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_SERVICE;
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
						reqVO.setFile_path(filePath);
						reqVO.setOrigin_name(f.getOriginalFilename());
						reqVO.setSave_name(saveFileName);
						reqVO.setFile_size(String.valueOf(f.getSize()));
						reqVO.setWidth(String.valueOf(map.get("width")));
						reqVO.setHeight(String.valueOf(map.get("height")));
						reqVO.setFile_ext(fileExt);
					}
				}
			}

			serviceMapper.serviceModAction(reqVO);

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.서비스.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.MOD.getValue());
			histVO.setNo_seq(reqVO.getNo_service());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isModify = false;
		}

		return isModify;
	}

}
