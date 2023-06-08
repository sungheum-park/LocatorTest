package kr.co.msync.web.module.common.service.impl;

import kr.co.msync.web.module.common.dao.CommonMapper;
import kr.co.msync.web.module.common.model.req.CloseDateReqVO;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.model.res.CloseDateResVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.HistMenuType;
import kr.co.msync.web.module.common.type.ResultType;
import kr.co.msync.web.module.util.SequenceUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service("CommonService")
@Transactional
public class CommonServiceImpl implements CommonService {

	@Autowired
	private CommonMapper commonMapper;

	@Override
	public Map<String,Object> getSequence(String tableName) {

		Map<String, Object> map = new HashMap<String, Object>();

		try {

			map = SequenceUtil.getInstance().getSequence(tableName);

			commonMapper.getSequence(map);

			if(map.get("seq")!=null) {
				map.put("code", ResultType.SUCCESS.getValue());
				map.put("message", "시퀀스 조회 성공");
			} else {
				map.put("code", ResultType.FAIL.getValue());
				map.put("message", "시퀀스 조회 실패");
			}

		} catch (Exception e) {
			map.put("code", ResultType.FAIL.getValue());
			map.put("message", "프로시저 조회 실패");
			e.printStackTrace();
		}
		return map;
	}

	@Override
	public boolean regHistoryAction(CommonReqVO vo) {

		boolean isSuccess = true;

		try {

			commonMapper.regHistoryAction(vo);

			if(vo.getNo_menu()== HistMenuType.매장.getValue()) {
				commonMapper.selectInsertStoreInfo(vo);
			} else if(vo.getNo_menu()== HistMenuType.서비스.getValue()) {
				commonMapper.selectInsertServiceInfo(vo);
			} else if(vo.getNo_menu()== HistMenuType.상품.getValue()) {
				commonMapper.selectInsertDeviceInfo(vo);
			} else if(vo.getNo_menu()== HistMenuType.색상.getValue()) {
				commonMapper.selectInsertColorInfo(vo);
			} else if(vo.getNo_menu()== HistMenuType.사용자.getValue()) {
				commonMapper.selectInsertUserInfo(vo);
			} else if(vo.getNo_menu()== HistMenuType.카테고리.getValue()) {
				commonMapper.selectInsertCategoryInfo(vo);
			}

		} catch(Exception e) {
			isSuccess = false;
			e.printStackTrace();
		}

		return isSuccess;

	}

	@Override
	public void updateClosedUser(CloseDateReqVO vo) {
		commonMapper.updateClosedUser(vo);
	}

	@Override
	public CloseDateResVO getCloseUser(CloseDateReqVO vo) {
		return commonMapper.getCloseUser(vo);
	}

	@Override
	public void initCloseUser(String login_id) {
		commonMapper.initCloseUser(login_id);
	}

}
