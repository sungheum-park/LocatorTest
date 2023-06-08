package kr.co.msync.web.module.sms.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class SmsDanalVO implements Serializable{
	private String reqUid;				// (필수)메시지 발송 요청에 대한 ID
	private String sysCode;				// (필수)메시지 발송 요청 시스템 고정값 'CDB' = consumer database
	private String fromName;			// (필수)보내는 사람 이름
	private String fromPhone;			// (필수)보내는 사람 전화번호
	private String toID;				// (필수)필립모리스 고객 ID
	private String naCode;				// (필수)대상 국가번호(ex) 82)
	private String toName;				// 대상 이름(ex) 홍길동)
	private String toPhone;				// (필수)대상 휴대 전화 번호(ex) 01012345678)
	private String TplCode;				// (필수)메시지 템플릿 코드(KA201806001 : Password Reset Message, KA201806002 : Welcome Message)
	private String smSubject;			// LMS 제목 
	private String smContent;			// LMS 내용
}
