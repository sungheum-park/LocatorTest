package kr.co.msync.web.module.device.service.impl;

import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.device.dao.DeviceMapper;
import kr.co.msync.web.module.device.model.req.DeviceReqVO;
import kr.co.msync.web.module.device.model.res.DeviceResVO;
import kr.co.msync.web.module.device.service.DeviceService;
import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.util.Const;
import kr.co.msync.web.module.util.FileUtil;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Service("deviceService")
@Transactional
public class DeviceServiceImpl implements DeviceService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private Properties config;

	@Autowired
	private DeviceMapper deviceMapper;

	@Override
	public List<DeviceResVO> getDeviceList(DeviceReqVO reqVO) {
		return deviceMapper.getDeviceList(reqVO);

	}

	@Override
	public List<DeviceResVO> getDeviceExcelList(DeviceReqVO reqVO) {
		return deviceMapper.getDeviceExcelList(reqVO);
	}

	@Override
	public int getDeviceListCnt(DeviceReqVO reqVO) {
		return deviceMapper.getDeviceListCnt(reqVO);
	}

	@Override
	public DeviceResVO getDeviceInfo(DeviceReqVO reqVO) {
		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.상품.getValue());
		histVO.setNo_user(reqVO.getMod_id());
		histVO.setAction_time(reqVO.getMod_date());
		histVO.setAction_status(ActionType.SEL.getValue());
		histVO.setNo_seq(reqVO.getNo_device());

		commonService.regHistoryAction(histVO);
		return deviceMapper.getDeviceInfo(reqVO);
	}

	@Override
	public int deviceDelAction(DeviceReqVO reqVO) {

		// tb_excg_device_map
		int excgDeviceMapDelcnt = deviceMapper.deviceExcgDeviceMapDelAction(reqVO);

		// tb_device_color_map
		int deviceColorMapDelcnt = deviceMapper.deviceColorMapDelAction(reqVO);

		// tb_device_master
		int deviceDelcnt = deviceMapper.deviceDelAction(reqVO);

		for(String s : reqVO.getDel_no_device()) {
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.상품.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.DEL.getValue());
			histVO.setNo_seq(s);

			commonService.regHistoryAction(histVO);

		}


		return excgDeviceMapDelcnt+deviceColorMapDelcnt+deviceDelcnt;
	}

	@Override
	public List<DeviceResVO> getDeviceColorList(DeviceReqVO reqVO) {
		return deviceMapper.getDeviceColorList(reqVO);
	}

	@Override
	public boolean deviceRegAction(Map<String, MultipartFile> fileMap, DeviceReqVO reqVO) {

		boolean isRegister = true;

		try {
		String filePath = Const.PATH_UPLOAD + Const.PATH_DEVICE;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_DEVICE;

			if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_DEVICE;
		}

		File dir = new File(fileFullPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}

		reqVO.setFile_path(filePath);
		reqVO.setFile_full_path(fileFullPath);

		MultipartFile oneFile = fileMap.get("device_master_file");
		DeviceReqVO resultVo = getSaveInfoByFile(oneFile, reqVO);

		deviceMapper.deviceRegAction(resultVo);

		fileMap.remove("device_master_file");
			int i = 0;
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						DeviceReqVO fileVO = new DeviceReqVO();
						fileVO.setNo_device(reqVO.getNo_device());
						fileVO.setNo_color(reqVO.getSelected_no_color()[i]);
						fileVO.setColor_sno(reqVO.getSelected_color_sno()[i]);
						fileVO.setLimit_yn(reqVO.getSelected_limit_yn()[i]);
						fileVO.setDevice_name(reqVO.getDevice_name());
						fileVO.setFile_path(reqVO.getFile_path());
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						deviceMapper.deviceColorMapRegAction(fileVO);
					}
				}
				i++;
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.상품.getValue());
			histVO.setNo_user(reqVO.getReg_id());
			histVO.setAction_time(reqVO.getReg_date());
			histVO.setAction_status(ActionType.REG.getValue());
			histVO.setNo_seq(reqVO.getNo_device());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isRegister = false;
		}

		return isRegister;
	}

	@Override
	public boolean deviceModAction(Map<String, MultipartFile> fileMap, DeviceReqVO reqVO) {

		boolean isModify = true;

		try {
			String filePath = Const.PATH_UPLOAD + Const.PATH_DEVICE;
			String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_DEVICE;

			if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
				fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_DEVICE;
			}

			File dir = new File(fileFullPath);
			if(!dir.isDirectory()){
				dir.mkdirs();
			}

			reqVO.setFile_path(filePath);
			reqVO.setFile_full_path(fileFullPath);

			MultipartFile oneFile = fileMap.get("device_master_file");

			if(oneFile!=null){
				DeviceReqVO resultVo = getSaveInfoByFile(oneFile, reqVO);
				deviceMapper.deviceModAction(resultVo);
			} else {
				deviceMapper.deviceModAction(reqVO);
			}

			fileMap.remove("device_master_file");

			deviceMapper.deviceNoMapDelAction(reqVO);

			int i = 0;
			for(String key : fileMap.keySet()) {
				MultipartFile f = fileMap.get(key);
				if(f!=null){
					int index = 0;
					for(int j=0; j < reqVO.getSelected_no_color().length; j++)
					{
						if(key.replace("device_file_","").equals(reqVO.getSelected_no_color()[j]))
						{
							index = j;
							break;
						}
					}
					String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
					String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
					Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
					boolean isResult = (boolean) map.get("isResult");
					if(isResult) {
						DeviceReqVO fileVO = new DeviceReqVO();
						fileVO.setNo_device(reqVO.getNo_device());
						fileVO.setNo_color(reqVO.getSelected_no_color()[index]);
						fileVO.setColor_sno(reqVO.getSelected_color_sno()[index]);
						fileVO.setLimit_yn(reqVO.getSelected_limit_yn()[index]);
						fileVO.setDevice_name(reqVO.getDevice_name());
						fileVO.setFile_path(reqVO.getFile_path());
						fileVO.setOrigin_name(f.getOriginalFilename());
						fileVO.setSave_name(saveFileName);
						fileVO.setFile_size(String.valueOf(f.getSize()));
						fileVO.setWidth(String.valueOf(map.get("width")));
						fileVO.setHeight(String.valueOf(map.get("height")));
						fileVO.setFile_ext(fileExt);
						fileVO.setReg_id(reqVO.getReg_id());
						fileVO.setReg_name(reqVO.getReg_name());
						fileVO.setReg_date(reqVO.getReg_date());
						deviceMapper.deviceColorMapModAction(fileVO);
					}
				}
				i++;
			}

			for(int k = 0 ; k < reqVO.getSelected_no_color().length ; k++) {
				DeviceReqVO vo = new DeviceReqVO();
				vo.setNo_device(reqVO.getNo_device());
				vo.setNo_color(reqVO.getSelected_no_color()[k]);
				vo.setColor_sno(String.valueOf(k+1));
				vo.setLimit_yn(reqVO.getSelected_limit_yn()[k]);
				deviceMapper.updateDeviceColorMapSno(vo);
			}

			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.상품.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.MOD.getValue());
			histVO.setNo_seq(reqVO.getNo_device());

			commonService.regHistoryAction(histVO);

		} catch (Exception e) {
			e.printStackTrace();
			isModify = false;
		}

		return isModify;
	}

	private DeviceReqVO getSaveInfoByFile(MultipartFile f, DeviceReqVO reqVO) {

		DeviceReqVO resultVO = new DeviceReqVO();

		String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
		String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
		Map map = FileUtil.fileUpload(f, reqVO.getFile_full_path()+saveFileName);
		boolean isResult = (boolean) map.get("isResult");
		if(isResult) {
			resultVO.setNo_device(reqVO.getNo_device());
			resultVO.setNo_cate(reqVO.getNo_cate());
			resultVO.setDevice_name(reqVO.getDevice_name());
			resultVO.setFile_path(reqVO.getFile_path());
			resultVO.setOrigin_name(f.getOriginalFilename());
			resultVO.setSave_name(saveFileName);
			resultVO.setFile_size(String.valueOf(f.getSize()));
			resultVO.setWidth(String.valueOf(map.get("width")));
			resultVO.setHeight(String.valueOf(map.get("height")));
			resultVO.setFile_ext(fileExt);
			resultVO.setUse_yn(reqVO.getUse_yn());
			resultVO.setDel_yn(reqVO.getDel_yn());
			resultVO.setReg_id(reqVO.getReg_id());
			resultVO.setReg_name(reqVO.getReg_name());
			resultVO.setReg_date(reqVO.getReg_date());
		}

		return resultVO;

	}

}
