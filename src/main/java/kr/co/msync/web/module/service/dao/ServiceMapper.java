package kr.co.msync.web.module.service.dao;

import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.service.model.res.ServiceResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceMapper {

	List<ServiceResVO> getServiceList(ServiceReqVO reqVO);
	List<ServiceResVO> getServiceExcelList(ServiceReqVO reqVO);
	int getServiceListCnt(ServiceReqVO reqVO);
	ServiceResVO getServiceInfo(ServiceReqVO reqVO);
	int serviceDelAction(ServiceReqVO reqVO);
	int storeServiceMapDelAction(ServiceReqVO reqVO);
	int serviceRegAction(ServiceReqVO reqVO);
	int serviceModAction(ServiceReqVO reqVO);

}