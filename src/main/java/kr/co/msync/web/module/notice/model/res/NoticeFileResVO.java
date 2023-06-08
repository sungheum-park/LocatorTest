package kr.co.msync.web.module.notice.model.res;

import lombok.Data;

@Data
public class NoticeFileResVO {
    /** 파일 맵핑 */
    private String no_file;
    private String file_type;
    private String file_path;
    private String origin_name;
    private String save_name;
    private String file_size;
    private String width;
    private String height;
    private String file_ext;
}
