package kr.co.msync.web.module.common.type;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.util.Assert;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
public enum AuthType {
	ADMIN("01"),
	MANAGER("02"),
	USER("03");

	@Getter
	private String value;
	@Override
	public String toString(){
		return value;
	}

	private static final Map<String, AuthType> valueMap;
	static {
		valueMap = new HashMap<>();
		for(AuthType e : AuthType.values()){
			valueMap.put(e.value, e);
		}
	}
	public static AuthType fromValue(Object value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return fromValue(value.toString());
	}
	public static AuthType fromValue(String value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return valueMap.get(value.trim());
	}
}