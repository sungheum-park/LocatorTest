package kr.co.msync.web.module.common.type;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.util.Assert;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
public enum HistMenuType {
	매장("01"),
	서비스("02"),
	상품("03"),
	색상("04"),
	사용자("05"),
	카테고리("06");

	@Getter
	private String value;
	@Override
	public String toString(){
		return value;
	}

	private static final Map<String, HistMenuType> valueMap;
	static {
		valueMap = new HashMap<>();
		for(HistMenuType e : HistMenuType.values()){
			valueMap.put(e.value, e);
		}
	}
	public static HistMenuType fromValue(Object value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return fromValue(value.toString());
	}
	public static HistMenuType fromValue(String value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return valueMap.get(value.trim());
	}
}