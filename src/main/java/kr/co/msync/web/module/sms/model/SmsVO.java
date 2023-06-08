package kr.co.msync.web.module.sms.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SmsVO implements Serializable{
    private String phone;
    private String store_code;
    private String store_name;
    private String store_addr;
    private String ip_addr;
}
