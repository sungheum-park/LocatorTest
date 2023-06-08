package kr.co.msync.web.module.color.model.req;

import kr.co.msync.web.module.common.model.Criteria;
import lombok.Data;

@Data
public class ColorReqVO extends Criteria {

    private String[] del_no_color;
    private String no_color;
    private String color_name;
    private String color_rgb;
    private String color_sno;
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

    private String[] selected_no_color;

    public void setColor_rgb(String color_rgb) {
        this.color_rgb = color_rgb.toUpperCase();
    }
}
