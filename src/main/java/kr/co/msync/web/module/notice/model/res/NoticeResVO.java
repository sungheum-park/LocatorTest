package kr.co.msync.web.module.notice.model.res;

import lombok.Data;

import java.util.List;

@Data
public class NoticeResVO {

	private String no_notice;
	private String notice_title;
	private String notice_div;
	private String notice_contents;
	private String display_time_start;
	private String display_time_end;
	private String display_yn;
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

}
