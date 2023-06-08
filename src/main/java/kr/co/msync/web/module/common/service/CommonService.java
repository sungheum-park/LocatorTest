package kr.co.msync.web.module.common.service;

import kr.co.msync.web.module.common.model.req.CloseDateReqVO;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.model.res.CloseDateResVO;

import java.util.Map;

public interface CommonService {
	Map<String, Object> getSequence(String tableName);
	boolean regHistoryAction(CommonReqVO vo);
	void updateClosedUser(CloseDateReqVO vo);
	CloseDateResVO getCloseUser(CloseDateReqVO vo);
	void initCloseUser(String login_id);
}