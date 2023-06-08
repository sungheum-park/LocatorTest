package kr.co.msync.web.module.menu.controller;

import kr.co.msync.web.module.common.controller.BaseController;
import kr.co.msync.web.module.menu.model.req.MenuReqVO;
import kr.co.msync.web.module.menu.model.res.MenuResVO;
import kr.co.msync.web.module.menu.service.MenuService;
import kr.co.msync.web.module.security.CustomUserDetails;
import kr.co.msync.web.module.util.SessionUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class MenuController extends BaseController {

    public static final String NAME = "menu";
    public static final String MAIN = "/" + NAME;

    /** 메뉴 리스트 호출 */
    public static final String MENU_LIST = MAIN + "/menuList";

    /** 메뉴 통제 */
    public static final String MENU_CENTER_LIST = MAIN + "/menuCenterList";

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = MENU_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String menuList(@ModelAttribute("MenuReqVO")MenuReqVO reqVO, Model model) {

        CustomUserDetails cud = (CustomUserDetails) SessionUtil.getSession("userInfo");
        reqVO.setNo_user(cud.getNo_user());

        // 기본 정렬_컬럼
        if(StringUtils.isBlank(reqVO.getOrder_column())){
            reqVO.setOrder_column("menu_sno");
        }
        // 기본 정렬 타입
        if(StringUtils.isBlank(reqVO.getOrder_type())){
            reqVO.setOrder_type("asc");
        }

        List<MenuResVO> list = menuService.getMenuList(reqVO);
        int listCnt = menuService.getMenuListCnt(reqVO);

        model.addAttribute("menuList", list);
        model.addAttribute("listCnt", listCnt);

        return "jsonView";

    }

    @RequestMapping(value = MENU_CENTER_LIST, method = {RequestMethod.GET, RequestMethod.POST})
    public String menuCenterList(@ModelAttribute("MenuReqVO")MenuReqVO reqVO, Model model,RedirectAttributes redirectAttributes) {

        model.addAttribute("reqVO", reqVO);

        return "redirect:/store/admin/store";

    }

}
