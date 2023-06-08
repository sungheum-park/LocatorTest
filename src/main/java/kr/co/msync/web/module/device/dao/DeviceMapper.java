package kr.co.msync.web.module.device.dao;

import kr.co.msync.web.module.device.model.req.DeviceReqVO;
import kr.co.msync.web.module.device.model.res.DeviceResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeviceMapper {

	List<DeviceResVO> getDeviceExcelList(DeviceReqVO reqVO);
	List<DeviceResVO> getDeviceList(DeviceReqVO reqVO);
	int getDeviceListCnt(DeviceReqVO reqVO);
	DeviceResVO getDeviceInfo(DeviceReqVO reqVO);
	int deviceDelAction(DeviceReqVO reqVO);
	int deviceColorMapDelAction(DeviceReqVO reqVO);
	int deviceExcgDeviceMapDelAction(DeviceReqVO reqVO);
	int deviceNoMapDelAction(DeviceReqVO reqVO);
	List<DeviceResVO> getDeviceColorList(DeviceReqVO reqVO);
	int deviceRegAction(DeviceReqVO reqVO);
	int deviceModAction(DeviceReqVO reqVO);
	int deviceColorMapRegAction(DeviceReqVO reqVO);
	int deviceColorMapModAction(DeviceReqVO reqVO);
	int updateDeviceColorMapSno(DeviceReqVO reqVO);

}