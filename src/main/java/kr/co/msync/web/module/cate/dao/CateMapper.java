package kr.co.msync.web.module.cate.dao;

import kr.co.msync.web.module.cate.model.req.CateReqVO;
import kr.co.msync.web.module.cate.model.res.CateResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CateMapper {

	List<CateResVO> getCateExcelList(CateReqVO reqVO);
	List<CateResVO> getCateList(CateReqVO reqVO);
	int getCateListCnt(CateReqVO reqVO);
	CateResVO getCateInfo(CateReqVO reqVO);
	int cateRegAction(CateReqVO reqVO);
	int cateModAction(CateReqVO reqVO);
	int sellDeviceMapDelAction(CateReqVO reqVO);
	String[] getDeviceSeq(String no_cate);
	int deviceColorMapDelAction(CateReqVO reqVO);
	int excgDeviceMapAction(CateReqVO reqVO);
	int deviceMasterDelAction(CateReqVO reqVO);
	int cateDelAction(CateReqVO reqVO);

}