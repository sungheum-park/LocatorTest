package kr.co.msync.web.module.menu.dao;

import kr.co.msync.web.module.menu.model.req.MenuReqVO;
import kr.co.msync.web.module.menu.model.res.MenuResVO;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuMapper {

	List<MenuResVO> getMenuList(MenuReqVO reqVO);
	int getMenuListCnt(MenuReqVO reqVO);
}