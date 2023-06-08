package kr.co.msync.web.module.survey.dao;

import kr.co.msync.web.module.survey.model.req.SurveyReqVO;
import kr.co.msync.web.module.survey.model.res.SurveyResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SurveyMapper {

	List<SurveyResVO> getSurveyList(SurveyReqVO reqVO);
	int getSurveyListCnt(SurveyReqVO reqVO);

}