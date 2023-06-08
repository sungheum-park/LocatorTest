package kr.co.msync.web.module.device.model.res;

import kr.co.msync.web.module.color.model.res.ColorResVO;
import lombok.Data;

import java.util.List;

@Data
public class DeviceResVO {

	private String no_device;
	private String no_cate;
	private String color_sno;
	private String cate_name;
	private String device_name;
	private String limit_yn;
	private String use_yn;
	private String del_yn;

	/** 공통 */
	private String reg_id;
	private String reg_name;
	private String reg_date;
	private String mod_id;
	private String mod_name;
	private String mod_date;

	/** 파일 맵핑 */
	private String no_file;
	private String file_type;
	private String file_path;
	private String origin_name;
	private String save_name;
	private String file_size;
	private String width;
	private String height;
	private String file_ext;
	private String file_sno;

	/** 모달 정보 */
	private String no_color;
	private String color_name;
	private String color_rgb;
	private String isMap;

	private List<ColorResVO> map_array;
	private String color_name_array;
}
