package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DeviceColorVO implements Serializable{
    private String no_device;
    private String no_color;
    private String color_name;
    private String color_rgb;
    private String color_sno;
    private String limit_yn;
    private String use_yn;
    private String qty;
    private String file_path;
    private String save_name;
}
