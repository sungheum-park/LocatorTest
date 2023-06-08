package kr.co.msync.web.module.device.service;

import kr.co.msync.web.module.device.model.req.DeviceReqVO;
import kr.co.msync.web.module.device.model.res.DeviceResVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface DeviceService {
	List<DeviceResVO> getDeviceList(DeviceReqVO reqVO);
	List<DeviceResVO> getDeviceExcelList(DeviceReqVO reqVO);
	int getDeviceListCnt(DeviceReqVO reqVO);
	DeviceResVO getDeviceInfo(DeviceReqVO reqVO);
	int deviceDelAction(DeviceReqVO reqVO);
	List<DeviceResVO> getDeviceColorList(DeviceReqVO reqVO);
	boolean deviceRegAction(Map<String, MultipartFile> fileMap, DeviceReqVO reqVO);
	boolean deviceModAction(Map<String, MultipartFile> fileMap, DeviceReqVO reqVO);
}