package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ServiceVO implements Serializable{
    private String no_service;
    private String service_div;
    private String service_name;
    private String file_path;
    private String origin_name;
    private String save_name;
    private int file_size;
    private int width;
    private int height;
    private String file_ext;
    private String use_yn = "Y";
    private String del_yn = "N";
}
