package kr.co.msync.web.module.color.service.impl;

import kr.co.msync.web.module.color.dao.ColorMapper;
import kr.co.msync.web.module.color.model.req.ColorReqVO;
import kr.co.msync.web.module.color.model.res.ColorResVO;
import kr.co.msync.web.module.color.service.ColorService;
import kr.co.msync.web.module.common.model.req.CommonReqVO;
import kr.co.msync.web.module.common.service.CommonService;
import kr.co.msync.web.module.common.type.ActionType;
import kr.co.msync.web.module.common.type.HistMenuType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service("colorService")
@Transactional
public class ColorServiceImpl implements ColorService {

	@Autowired
	private CommonService commonService;

	@Autowired
	private ColorMapper colorMapper;

	@Override
	public List<ColorResVO> getColorList(ColorReqVO reqVO) {
		return colorMapper.getColorList(reqVO);

	}

	@Override
	public List<ColorResVO> getColorSnoExcgList() {
		return colorMapper.getColorSnoExcgList();
	}

	@Override
	public List<ColorResVO> getColorExcelList(ColorReqVO reqVO) {
		return colorMapper.getColorExcelList(reqVO);

	}

	@Override
	public int getColorListCnt(ColorReqVO reqVO) {
		return colorMapper.getColorListCnt(reqVO);
	}

	@Override
	public ColorResVO getColorInfo(ColorReqVO reqVO) {
		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.색상.getValue());
		histVO.setNo_user(reqVO.getMod_id());
		histVO.setAction_time(reqVO.getMod_date());
		histVO.setAction_status(ActionType.SEL.getValue());
		histVO.setNo_seq(reqVO.getNo_color());

		commonService.regHistoryAction(histVO);

		return colorMapper.getColorInfo(reqVO);
	}

	@Override
	public int colorRegAction(ColorReqVO reqVO) {

		int resultCnt = colorMapper.colorRegAction(reqVO);

		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.색상.getValue());
		histVO.setNo_user(reqVO.getReg_id());
		histVO.setAction_time(reqVO.getReg_date());
		histVO.setAction_status(ActionType.REG.getValue());
		histVO.setNo_seq(reqVO.getNo_color());

		commonService.regHistoryAction(histVO);

		return resultCnt;
	}

	@Override
	public int colorModAction(ColorReqVO reqVO) {

		int resultCnt = colorMapper.colorModAction(reqVO);

		CommonReqVO histVO = new CommonReqVO();

		histVO.setNo_menu(HistMenuType.색상.getValue());
		histVO.setNo_user(reqVO.getMod_id());
		histVO.setAction_time(reqVO.getMod_date());
		histVO.setAction_status(ActionType.MOD.getValue());
		histVO.setNo_seq(reqVO.getNo_color());

		commonService.regHistoryAction(histVO);

		return resultCnt;
	}

	@Override
	public int colorDelAction(ColorReqVO reqVO) {

		// tb_excg_device_map 삭제
		int excgDeviceMapDelCnt = colorMapper.excgDeviceMapDelAction(reqVO);

		// tb_device_color_map 삭제
		int deviceColorMapDelCnt = colorMapper.excgDeviceColorMapDelAction(reqVO);

		int colorDelCnt = colorMapper.colorDelAction(reqVO);

		for(String s : reqVO.getDel_no_color()) {
			CommonReqVO histVO = new CommonReqVO();

			histVO.setNo_menu(HistMenuType.색상.getValue());
			histVO.setNo_user(reqVO.getMod_id());
			histVO.setAction_time(reqVO.getMod_date());
			histVO.setAction_status(ActionType.DEL.getValue());
			histVO.setNo_seq(s);

			commonService.regHistoryAction(histVO);

		}


		return excgDeviceMapDelCnt+deviceColorMapDelCnt+colorDelCnt;
	}

	@Override
	public int deviceColorMapCnt(ColorReqVO reqVO) {
		return colorMapper.deviceColorMapCnt(reqVO);
	}

	@Override
	public int colorSnoExcgAction(ColorReqVO reqVO) {

		int updateCnt = 0;
		String[] no_color_array = reqVO.getNo_color().split(",");
		String[] color_sno_array = reqVO.getColor_sno().split(",");

		for(int i = 0 ; i < no_color_array.length ; i++) {
			ColorReqVO updateVO = new ColorReqVO();
			updateVO.setNo_color(no_color_array[i]);
			updateVO.setColor_sno(color_sno_array[i]);
			int cnt = colorMapper.colorSnoExcgAction(updateVO);
			updateCnt+=cnt;
		}

		return updateCnt;

	}

}
