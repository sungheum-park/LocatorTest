package kr.co.msync.web.module.menu.service.impl;

import org.springframework.transaction.annotation.Transactional;
import kr.co.msync.web.module.menu.dao.MenuMapper;
import kr.co.msync.web.module.menu.model.req.MenuReqVO;
import kr.co.msync.web.module.menu.model.res.MenuResVO;
import kr.co.msync.web.module.menu.service.MenuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service("menuService")
@Transactional
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuMapper menuMapper;

	@Override
	public List<MenuResVO> getMenuList(MenuReqVO reqVO) {
		return menuMapper.getMenuList(reqVO);
	}

	@Override
	public int getMenuListCnt(MenuReqVO reqVO) {
		return menuMapper.getMenuListCnt(reqVO);
	}
}