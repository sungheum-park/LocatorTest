package kr.co.msync.web.module.common.service.impl;

import kr.co.msync.web.module.common.dao.CodeMapper;
import kr.co.msync.web.module.common.model.req.CodeReqVO;
import kr.co.msync.web.module.common.model.res.CodeResVO;
import kr.co.msync.web.module.common.service.CodeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service("codeService")
@Transactional
public class CodeServiceImpl implements CodeService {

	@Autowired
	private CodeMapper codeMapper;

	@Override
	public List<CodeResVO> getCodeList(CodeReqVO reqVO) {
		return codeMapper.getCodeList(reqVO);
	}

	@Override
	public String getCodeName(CodeReqVO reqVO) {
		return codeMapper.getCodeName(reqVO);
	}
}