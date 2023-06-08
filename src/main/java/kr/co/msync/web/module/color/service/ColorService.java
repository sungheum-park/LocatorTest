package kr.co.msync.web.module.color.service;

import kr.co.msync.web.module.color.model.req.ColorReqVO;
import kr.co.msync.web.module.color.model.res.ColorResVO;

import java.util.List;

public interface ColorService {
	List<ColorResVO> getColorList(ColorReqVO reqVO);
	List<ColorResVO> getColorSnoExcgList();
	List<ColorResVO> getColorExcelList(ColorReqVO reqVO);
	int getColorListCnt(ColorReqVO reqVO);
	ColorResVO getColorInfo(ColorReqVO reqVO);
	int colorRegAction(ColorReqVO reqVO);
	int colorModAction(ColorReqVO reqVO);
	int colorDelAction(ColorReqVO reqVO);
	int deviceColorMapCnt(ColorReqVO reqVO);
	int colorSnoExcgAction(ColorReqVO reqVO);
}