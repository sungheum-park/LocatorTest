package kr.co.msync.web.module.common.service;

import kr.co.msync.web.module.common.model.req.CodeReqVO;
import kr.co.msync.web.module.common.model.res.CodeResVO;

import java.util.List;

public interface CodeService {

	List<CodeResVO> getCodeList(CodeReqVO reqVO);
	String getCodeName(CodeReqVO reqVO);
}