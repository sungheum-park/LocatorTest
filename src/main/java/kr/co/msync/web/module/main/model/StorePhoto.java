package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class StorePhoto implements Serializable{
    private int no_file;
    private String store_code;
    private String file_path;
    private String origin_name;
    private String save_name;
    private int file_size;
    private int width;
    private int height;
    private String file_ext;
    private int file_sno;
    private String use_yn = "Y";
}
