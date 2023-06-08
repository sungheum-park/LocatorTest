package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryVO implements Serializable{
    private String no_cate;
    private String cate_name;
    private String file_path;
    private String save_name;
    private String width;
    private String height;
    private String sell_yn;
    private String excg_yn;
    private String del_yn = "N";

    List<DeviceVO> deviceList = new ArrayList<>();

    // 상세화면에서 사용
    private String cate_sno;
    private String treat_yn;
    private String device_qty;
    private String reg_date;




    // 중복 제거를 위해서 override
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof CategoryVO) {
            CategoryVO temp = (CategoryVO) obj;
            if (this.no_cate.equals(temp.no_cate)) {
                return true;
            }
        }
        return false;
    }
    @Override
    public int hashCode() {
        return this.no_cate.hashCode();
    }
}
