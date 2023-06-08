package kr.co.msync.web.module.notice.dao;

import kr.co.msync.web.module.notice.model.req.NoticeReqVO;
import kr.co.msync.web.module.notice.model.res.NoticeResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NoticeMapper {

	List<NoticeResVO> getNoticeList(NoticeReqVO reqVO);
	int getNoticeListCnt(NoticeReqVO reqVO);
	NoticeResVO getNoticeInfo(NoticeReqVO reqVO);
	int noticeRegAction(NoticeReqVO reqVO);
	int noticeModAction(NoticeReqVO reqVO);
	int noticeDelAction(NoticeReqVO reqVO);

}