package kr.co.msync.web.module.common.dao;

import kr.co.msync.web.module.common.model.req.CodeReqVO;
import kr.co.msync.web.module.common.model.res.CodeResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CodeMapper {

	List<CodeResVO> getCodeList(CodeReqVO reqVO);
	String getCodeName(CodeReqVO reqVO);
	List<CodeResVO> getCodeNameByTable(CodeReqVO reqVO);
}