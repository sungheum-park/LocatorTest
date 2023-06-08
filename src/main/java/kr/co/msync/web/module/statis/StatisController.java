package kr.co.msync.web.module.statis;

import kr.co.msync.web.module.common.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class StatisController extends BaseController {

    public static final String NAME = "/statis";
    public static final String MAIN = NAME + "/admin";

    /** 통계 */
    public static final String STATIS = MAIN + "/statis";

    @RequestMapping(value = STATIS, method = {RequestMethod.GET, RequestMethod.POST})
    public String statis() {

        return STATIS + ADMIN_DEFAULT_SUFFIX;

    }

}
