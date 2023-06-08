package kr.co.msync.web.module.common.controller;


import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BaseController {

    /** admin tiles */
    protected final static String ADMIN_DEFAULT_SUFFIX = ".aDefault";
    protected final static String ADMIN_EMPTY_SUFFIX = ".aEmpty";
    protected final static String ADMIN_MODAL_SUFFIX = ".aModal";
    protected final static String ADMIN_LOGIN_SUFFIX = ".aLogin";

    protected final static String DEFAULT_SUFFIX = ".default";
    protected final static String STORE_LOCATOR_SUFFIX = ".storeLocator";
    //[메인 - 서비스 메뉴]
    protected final static String MAIN_SUFFIX = ".main";
    protected final static String EMPTY_SUFFIX = ".empty";

    protected final static String SUCCESS = "01";
    protected final static String FAIL = "02";

}
