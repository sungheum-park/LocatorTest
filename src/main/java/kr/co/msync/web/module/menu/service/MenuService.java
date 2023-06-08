package kr.co.msync.web.module.menu.service;

import kr.co.msync.web.module.menu.model.req.MenuReqVO;
import kr.co.msync.web.module.menu.model.res.MenuResVO;

import java.util.List;

public interface MenuService {

	List<MenuResVO> getMenuList(MenuReqVO reqVO);
	int getMenuListCnt(MenuReqVO reqVO);
}