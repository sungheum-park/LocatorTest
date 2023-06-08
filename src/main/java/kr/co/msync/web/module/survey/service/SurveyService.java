package kr.co.msync.web.module.survey.service;

import kr.co.msync.web.module.survey.model.req.SurveyReqVO;
import kr.co.msync.web.module.survey.model.res.SurveyResVO;

import java.util.List;

public interface SurveyService {
	List<SurveyResVO> getSurveyList(SurveyReqVO reqVO);
	int getSurveyListCnt(SurveyReqVO reqVO);
}