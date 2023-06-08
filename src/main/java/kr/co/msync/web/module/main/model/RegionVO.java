package kr.co.msync.web.module.main.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegionVO implements Serializable{
    private String no_region;
    private Integer region_level;
    private String region_p_no;
    private String region_name;
}
