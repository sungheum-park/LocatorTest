package kr.co.msync.web.module.color.dao;

import kr.co.msync.web.module.color.model.req.ColorReqVO;
import kr.co.msync.web.module.color.model.res.ColorResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ColorMapper {

	List<ColorResVO> getColorExcelList(ColorReqVO reqVO);
	List<ColorResVO> getColorList(ColorReqVO reqVO);
	List<ColorResVO> getColorSnoExcgList();
	int getColorListCnt(ColorReqVO reqVO);
	ColorResVO getColorInfo(ColorReqVO reqVO);
	int colorRegAction(ColorReqVO reqVO);
	int colorModAction(ColorReqVO reqVO);
	int colorDelAction(ColorReqVO reqVO);
	int deviceColorMapCnt(ColorReqVO reqVO);
	int colorSnoExcgAction(ColorReqVO reqVO);
	int excgDeviceMapDelAction(ColorReqVO reqVO);
	int excgDeviceColorMapDelAction(ColorReqVO reqVO);

}