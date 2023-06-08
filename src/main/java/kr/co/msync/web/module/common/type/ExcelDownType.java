package kr.co.msync.web.module.common.type;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.util.Assert;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
public enum ExcelDownType {
	색상리스트("01"),
	카테고리리스트("02"),
	상품리스트("03"),
	서비스리스트("04"),
	운영자리스트("05"),
	매장리스트("06");

	@Getter
	private String value;
	@Override
	public String toString(){
		return value;
	}

	private static final Map<String, ExcelDownType> valueMap;
	static {
		valueMap = new HashMap<>();
		for(ExcelDownType e : ExcelDownType.values()){
			valueMap.put(e.value, e);
		}
	}
	public static ExcelDownType fromValue(Object value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return fromValue(value.toString());
	}
	public static ExcelDownType fromValue(String value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return valueMap.get(value.trim());
	}
}
