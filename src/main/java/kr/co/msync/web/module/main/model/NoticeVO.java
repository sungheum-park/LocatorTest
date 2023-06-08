package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO implements Serializable{
    private String no_notice;
    private String notice_title;
    private String notice_div;
    private String notice_contents;
    private String file_path;
    private String save_name;
    private String width;
    private String height;
}
