package kr.co.msync.web.module.common.dao;

import kr.co.msync.web.module.common.model.req.CloseDateReqVO;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.model.res.CloseDateResVO;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface CommonMapper {

	Map<String, Object> getSequence(Map<String, Object> map);
	int regHistoryAction(CommonReqVO vo);
	int selectInsertStoreInfo(CommonReqVO vo);
	int selectInsertServiceInfo(CommonReqVO vo);
	int selectInsertDeviceInfo(CommonReqVO vo);
	int selectInsertColorInfo(CommonReqVO vo);
	int selectInsertUserInfo(CommonReqVO vo);
	int selectInsertCategoryInfo(CommonReqVO vo);
	void updateClosedUser(CloseDateReqVO vo);
	CloseDateResVO getCloseUser(CloseDateReqVO vo);
	void initCloseUser(String login_id);
}