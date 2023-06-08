package kr.co.msync.web.module.cate.model.res;

import lombok.Data;

import java.util.List;

@Data
public class CateResVO {

	private String no_cate;
	private String cate_name;
	private String sell_yn;
	private String excg_yn;
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
	private String use_yn;

}
