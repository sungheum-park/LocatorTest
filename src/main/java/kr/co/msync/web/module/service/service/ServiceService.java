package kr.co.msync.web.module.service.service;

import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.service.model.res.ServiceResVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface ServiceService {
	List<ServiceResVO> getServiceList(ServiceReqVO reqVO);
	List<ServiceResVO> getServiceExcelList(ServiceReqVO reqVO);
	int getServiceListCnt(ServiceReqVO reqVO);
	ServiceResVO getServiceInfo(ServiceReqVO reqVO);
	int serviceDelAction(ServiceReqVO reqVO);
	boolean serviceRegAction(Map<String, MultipartFile> file, ServiceReqVO reqVO);
	boolean serviceModAction(Map<String, MultipartFile> file, ServiceReqVO reqVO);
}