package kr.co.msync.web.module.cate.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class CateReqVO extends Criteria {

    private String[] del_no_cate;
    private String[] del_no_device;
    private String no_cate;
    private String cate_name;
    private String file_path;
    private String origin_name;
    private String save_name;
    private String file_size;
    private String width;
    private String height;
    private String file_ext;
    private String sell_yn;
    private String excg_yn;
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

    private String[] selected_no_cate;

}
