package kr.co.msync.web.module.common.type;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.util.Assert;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
public enum DelYnType {
	YES("Y"),
	NO("N");

	@Getter
	private String value;
	@Override
	public String toString(){
		return value;
	}

	private static final Map<String, DelYnType> valueMap;
	static {
		valueMap = new HashMap<>();
		for(DelYnType e : DelYnType.values()){
			valueMap.put(e.value, e);
		}
	}
	public static DelYnType fromValue(Object value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return fromValue(value.toString());
	}
	public static DelYnType fromValue(String value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return valueMap.get(value.trim());
	}
}
