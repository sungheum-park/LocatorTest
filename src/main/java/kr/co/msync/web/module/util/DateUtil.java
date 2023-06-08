package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;
import org.joda.time.LocalDateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

/**
 * 날짜 관련 유틸
 *
 * @author swpark
 */
@Slf4j
public class DateUtil {

	/** Date HMS pattern */
	public static final String DATE_MSC_PATTERN = "yyyyMMddHHmmssSSS";

	/**
	 * get current time
	 *
	 * @param pattern
	 *            time pattern
	 * @return String representing current time (type of pattern)
	 */
	public static String getCurrentDateTime(String pattern) {
		LocalDateTime dt = new LocalDateTime();
		DateTimeFormatter fmt = DateTimeFormat.forPattern(pattern);
		return fmt.print(dt);
	}
}
