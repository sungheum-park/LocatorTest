package kr.co.msync.web.module.notice.service;

import kr.co.msync.web.module.notice.model.req.NoticeReqVO;
import kr.co.msync.web.module.notice.model.res.NoticeResVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	List<NoticeResVO> getNoticeList(NoticeReqVO reqVO);
	int getNoticeListCnt(NoticeReqVO reqVO);
	NoticeResVO getNoticeInfo(NoticeReqVO reqVO);
	int noticeDelAction(NoticeReqVO reqVO);
	boolean noticeRegAction(Map<String, MultipartFile> file, NoticeReqVO reqVO);
	boolean noticeModAction(Map<String, MultipartFile> file, NoticeReqVO reqVO);
}