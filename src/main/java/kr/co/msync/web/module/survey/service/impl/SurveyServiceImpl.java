package kr.co.msync.web.module.survey.service.impl;

import kr.co.msync.web.module.survey.dao.SurveyMapper;
import kr.co.msync.web.module.survey.model.req.SurveyReqVO;
import kr.co.msync.web.module.survey.model.res.SurveyResVO;
import kr.co.msync.web.module.survey.service.SurveyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Slf4j
@Service("surveyService")
@Transactional
public class SurveyServiceImpl implements SurveyService {

	@Autowired
	private SurveyMapper surveyMapper;

	@Override
	public List<SurveyResVO> getSurveyList(SurveyReqVO reqVO) {
		return surveyMapper.getSurveyList(reqVO);

	}

	@Override
	public int getSurveyListCnt(SurveyReqVO reqVO) {
		return surveyMapper.getSurveyListCnt(reqVO);
	}

}
