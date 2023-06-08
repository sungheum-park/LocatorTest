package kr.co.msync.web.module.hist.service.impl;

import kr.co.msync.web.module.hist.dao.HistMapper;
import kr.co.msync.web.module.hist.model.req.HistReqVO;
import kr.co.msync.web.module.hist.model.res.HistResVO;
import kr.co.msync.web.module.hist.service.HistService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service("histService")
@Transactional
public class HistServiceImpl implements HistService {

	@Autowired
	private HistMapper histMapper;

	@Override
	public List<HistResVO> getHistList(HistReqVO reqVO) {
		return histMapper.getHistList(reqVO);

	}

	@Override
	public int getHistListCnt(HistReqVO reqVO) {
		return histMapper.getHistListCnt(reqVO);
	}

	@Override
	public List<HistResVO> getHistViewInfo(HistReqVO reqVO) {
		return histMapper.getHistViewInfo(reqVO);
	}

}
