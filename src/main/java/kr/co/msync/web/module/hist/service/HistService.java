package kr.co.msync.web.module.hist.service;

import kr.co.msync.web.module.hist.model.req.HistReqVO;
import kr.co.msync.web.module.hist.model.res.HistResVO;

import java.util.List;

public interface HistService {
	List<HistResVO> getHistList(HistReqVO reqVO);
	int getHistListCnt(HistReqVO reqVO);
	List<HistResVO> getHistViewInfo(HistReqVO reqVO);
}