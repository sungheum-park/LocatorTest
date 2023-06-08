package kr.co.msync.web.module.common.type;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.util.Assert;

import java.util.HashMap;
import java.util.Map;

@AllArgsConstructor
public enum ActionType {
	SEL("01"),
	REG("02"),
	MOD("03"),
	DEL("04"),
	CON("05");

	@Getter
	private String value;
	@Override
	public String toString(){
		return value;
	}

	private static final Map<String, ActionType> valueMap;
	static {
		valueMap = new HashMap<>();
		for(ActionType e : ActionType.values()){
			valueMap.put(e.value, e);
		}
	}
	public static ActionType fromValue(Object value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return fromValue(value.toString());
	}
	public static ActionType fromValue(String value){
		Assert.notNull(value, "fromValue는 null 값을 허용하지 않습니다.");
		return valueMap.get(value.trim());
	}
}