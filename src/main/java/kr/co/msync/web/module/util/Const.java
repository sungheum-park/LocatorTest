package kr.co.msync.web.module.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.MessageSourceAccessor;

public class Const implements InitializingBean {

	private static final Logger logger = LoggerFactory.getLogger(Const.class);

	@Autowired
    MessageSourceAccessor msa;

	public final static String PATH_UPLOAD = "/upload/";

	public final static String PATH_LOCAL_SAVE = "D:/iqos/download/";
	public final static String PATH_SERVER_SAVE = "/var/lib/tomcat/iqos/";

	/** Path 매장 */
	public final static String PATH_STORE = "store/";

    /** Path 서비스 */
    public final static String PATH_SERVICE = "service/";

	/** Path 상품 */
	public final static String PATH_DEVICE = "device/";

	/** Path 카테고리 */
	public final static String PATH_CATEGORT = "cate/";

	/** Path 공지사항 */
	public final static String PATH_NOTICE = "notice/";


	@Override
	public void afterPropertiesSet() throws Exception {

	}
}
