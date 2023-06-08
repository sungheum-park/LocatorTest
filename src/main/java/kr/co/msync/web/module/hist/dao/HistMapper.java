package kr.co.msync.web.module.hist.dao;

import kr.co.msync.web.module.hist.model.req.HistReqVO;
import kr.co.msync.web.module.hist.model.res.HistResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistMapper {

	List<HistResVO> getHistList(HistReqVO reqVO);
	int getHistListCnt(HistReqVO reqVO);
	List<HistResVO> getHistViewInfo(HistReqVO reqVO);

}