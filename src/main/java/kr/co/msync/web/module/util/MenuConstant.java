package kr.co.msync.web.module.util;

import kr.co.msync.web.module.scheduler.model.StoreInfoResVO;
import lombok.NoArgsConstructor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@NoArgsConstructor
public class MenuConstant {

	private static MenuConstant menuConstant;

	public Map<String, StoreInfoResVO> storeInfoMap = new HashMap();

	public static synchronized MenuConstant getInstance() {
		if (menuConstant == null) {
			menuConstant = new MenuConstant();
		}
		return menuConstant;
	}

}