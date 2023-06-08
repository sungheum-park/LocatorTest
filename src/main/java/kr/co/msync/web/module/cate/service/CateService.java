package kr.co.msync.web.module.cate.service;

import kr.co.msync.web.module.cate.model.req.CateReqVO;
import kr.co.msync.web.module.cate.model.res.CateResVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface CateService {
	List<CateResVO> getCateList(CateReqVO reqVO);
	List<CateResVO> getCateExcelList(CateReqVO reqVO);
	int getCateListCnt(CateReqVO reqVO);
	CateResVO getCateInfo(CateReqVO reqVO);
	int cateDelAction(CateReqVO reqVO);
	boolean cateRegAction(Map<String, MultipartFile> file, CateReqVO reqVO);
	boolean cateModAction(Map<String, MultipartFile> file, CateReqVO reqVO);
}