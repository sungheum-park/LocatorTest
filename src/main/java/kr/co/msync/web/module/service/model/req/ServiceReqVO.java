package kr.co.msync.web.module.service.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class ServiceReqVO extends Criteria {

    private String no_service;
    private String[] del_no_service;
    private String service_div;
	private String service_name;
	private String use_yn;
    private String comment;
	private String del_yn;


	/** 파일 */
    private String file_path;
    private String origin_name;
    private String save_name;
    private String file_size;
    private String width;
    private String height;
    private String file_ext;


    /** 공통 */
    private String reg_id;
    private String reg_name;
    private String reg_date;
    private String reg_date_start;
    private String reg_date_end;
    private String mod_id;
    private String mod_name;
    private String mod_date;
    private String mod_date_start;
    private String mod_date_end;

    private String[] selected_no_cate;
    private String[] selected_no_service;

}
