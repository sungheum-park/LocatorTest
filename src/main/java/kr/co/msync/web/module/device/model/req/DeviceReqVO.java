package kr.co.msync.web.module.device.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class DeviceReqVO extends Criteria {

    private String[] del_no_device;
    private String no_device;
    private String no_cate;
    private String no_color;
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
    private String reg_date_start;
    private String reg_date_end;
    private String mod_id;
    private String mod_name;
    private String mod_date;
    private String mod_date_start;
    private String mod_date_end;

    /** 파일 맵핑 */
    private String no_file;
    private String file_type;
    private String file_path;
    private String file_full_path;
    private String origin_name;
    private String save_name;
    private String file_size;
    private String width;
    private String height;
    private String file_ext;
    private String file_sno;

    private String[] selected_no_color;
    private String[] selected_color_sno;
    private String[] selected_limit_yn;
}
