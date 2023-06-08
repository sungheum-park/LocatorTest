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
public class DeviceVO implements Serializable{
    private String no_device;
    private String no_cate;
    private String device_name;
    private String file_path;
    private String save_name;
    private String width;
    private String height;
    private String limit_yn;


    List<DeviceColorVO> deviceColorList = new ArrayList<>();


    @Override
    public boolean equals(Object obj) {
        if (obj instanceof DeviceVO) {
            DeviceVO temp = (DeviceVO) obj;
            if (this.no_device.equals(temp.no_device)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public int hashCode() {
        return (this.no_device.hashCode());
    }


}
