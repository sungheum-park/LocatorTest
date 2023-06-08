package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SurveyVO implements Serializable{
    private String score;
    private String ip_addr;
    private String device_type;
    private String reg_date;
}
