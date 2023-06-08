package kr.co.msync.web.module.store.model.res;

import lombok.Data;

@Data
public class StoreFileResVO {
    private String no_file;
    private String store_code;
    private String file_type;
    private String file_path;
    private String origin_name;
    private String save_name;
    private String file_size;
    private String width;
    private String height;
    private String file_ext;
    private String file_sno;
    private String use_yn;
    private String reg_id;
    private String reg_name;
    private String reg_date;
}
