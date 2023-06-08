package kr.co.msync.web.module.notice.service.impl;

import kr.co.msync.web.module.notice.dao.NoticeMapper;
import kr.co.msync.web.module.notice.model.req.NoticeReqVO;
import kr.co.msync.web.module.notice.model.res.NoticeResVO;
import kr.co.msync.web.module.notice.service.NoticeService;
import kr.co.msync.web.module.common.type.YesNoType;
import kr.co.msync.web.module.service.model.req.ServiceReqVO;
import kr.co.msync.web.module.util.Const;
import kr.co.msync.web.module.util.FileUtil;
import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Slf4j
@Service("noticeService")
@Transactional
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private Properties config;

	@Autowired
	private NoticeMapper noticeMapper;

	@Override
	public List<NoticeResVO> getNoticeList(NoticeReqVO reqVO) {
		return noticeMapper.getNoticeList(reqVO);
	}

	@Override
	public int getNoticeListCnt(NoticeReqVO reqVO) {
		return noticeMapper.getNoticeListCnt(reqVO);
	}

	@Override
	public NoticeResVO getNoticeInfo(NoticeReqVO reqVO) {
		return noticeMapper.getNoticeInfo(reqVO);
	}

	@Override
	public int noticeDelAction(NoticeReqVO reqVO) {
		return noticeMapper.noticeDelAction(reqVO);
	}

	@Override
	public boolean noticeRegAction(Map<String, MultipartFile> fileMap, NoticeReqVO reqVO) {
		boolean isRegister = true;

		reqVO.setDel_yn(YesNoType.NO.getValue());

		String filePath = Const.PATH_UPLOAD + Const.PATH_NOTICE;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_NOTICE;
		log.info("fileFullPath={}", fileFullPath);
		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_NOTICE;
		}

		File dir = new File(fileFullPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}

		try {

			if("01".equals(reqVO.getNotice_div())){
				for(String key : fileMap.keySet()) {
					MultipartFile f = fileMap.get(key);
					if(f!=null){
						String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
						String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
						Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
						boolean isResult = (boolean) map.get("isResult");
						if(isResult) {
							NoticeReqVO fileVO = new NoticeReqVO();
							fileVO.setNotice_title(reqVO.getNotice_title());
							fileVO.setNotice_div(reqVO.getNotice_div());
							fileVO.setDisplay_time_start(reqVO.getDisplay_time_start());
							fileVO.setDisplay_time_end(reqVO.getDisplay_time_end());
							fileVO.setFile_path(filePath);
							fileVO.setOrigin_name(f.getOriginalFilename());
							fileVO.setSave_name(saveFileName);
							fileVO.setFile_size(String.valueOf(f.getSize()));
							fileVO.setWidth(String.valueOf(map.get("width")));
							fileVO.setHeight(String.valueOf(map.get("height")));
							fileVO.setFile_ext(fileExt);
							fileVO.setDisplay_yn(reqVO.getDisplay_yn());
							fileVO.setDel_yn(reqVO.getDel_yn());
							fileVO.setReg_id(reqVO.getReg_id());
							fileVO.setReg_name(reqVO.getReg_name());
							fileVO.setReg_date(reqVO.getReg_date());
							noticeMapper.noticeRegAction(fileVO);
						}
					}
				}
			} else {
				noticeMapper.noticeRegAction(reqVO);
			}
		} catch (Exception e) {
			e.printStackTrace();
			isRegister = false;
		}

		return isRegister;
	}

	@Override
	public boolean noticeModAction(Map<String, MultipartFile> fileMap, NoticeReqVO reqVO) {

		boolean isModify = true;

		String filePath = Const.PATH_UPLOAD + Const.PATH_NOTICE;
		String fileFullPath = Const.PATH_SERVER_SAVE + Const.PATH_NOTICE;

		if (config.getProperty("profiles.profile.id").equalsIgnoreCase("local")) {
			fileFullPath = Const.PATH_LOCAL_SAVE + Const.PATH_NOTICE;
		}

		File dir = new File(fileFullPath);
		if(!dir.isDirectory()){
			dir.mkdirs();
		}

		try {

			if("01".equals(reqVO.getNotice_div())){
				int i = 0;
				for(String key : fileMap.keySet()) {
					MultipartFile f = fileMap.get(key);
					if(f!=null){
						String saveFileName = StringUtil.getExchangeName(f.getOriginalFilename());
						String fileExt = StringUtil.getDelimiterPrefixStr(".",saveFileName);
						Map map = FileUtil.fileUpload(f, fileFullPath+saveFileName);
						boolean isResult = (boolean) map.get("isResult");
						if(isResult) {
							reqVO.setFile_path(filePath);
							reqVO.setOrigin_name(f.getOriginalFilename());
							reqVO.setSave_name(saveFileName);
							reqVO.setFile_size(String.valueOf(f.getSize()));
							reqVO.setWidth(String.valueOf(map.get("width")));
							reqVO.setHeight(String.valueOf(map.get("height")));
							reqVO.setFile_ext(fileExt);
						}
					}
					i++;
				}
			} else {
				reqVO.setFile_path(null);
				reqVO.setOrigin_name(null);
				reqVO.setSave_name(null);
				reqVO.setFile_size(null);
				reqVO.setWidth(null);
				reqVO.setHeight(null);
				reqVO.setFile_ext(null);
			}
			noticeMapper.noticeModAction(reqVO);

		} catch (Exception e) {
			e.printStackTrace();
			isModify = false;
		}

		return isModify;
	}

}
