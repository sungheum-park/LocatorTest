package kr.co.msync.web.module.util;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Locale;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 문자열 관련 유틸
 *
 * @author swpark
 */
@Slf4j
public class StringUtil {

	/**
	 * Test Sample
	 *
	 * @param argsp
	 */
	public static void main(String argsp[]) {
		log.debug("cutString(String source, String output, int length) : " + StringUtil.cutString("문자열", "...", 2));
		log.debug("removeWhitespace(String str) : |" + StringUtil.removeWhitespace(" 문 자 열       ") + "|");
		log.debug("getTimeStamp() : " + StringUtil.getTimeStamp("yyyyMMddHHmmss"));
		log.debug("hiddenString(String str, int length) : " + StringUtil.hiddenString("문자열내용", 2));
		log.debug("htmlToCode(String str) : " + StringUtil.htmlToCode("!@#$%^&*(){}:;,./<테스트>?'"));
		log.debug("codeToHtml(String str) : " + StringUtil.codeToHtml("!@#$%^&amp;*(){}:;,./&lt;테스트&gt;?&#x27;"));
		log.debug("strToHtml(String str) : " + StringUtil.strToHtml("!@#$%^&*(){}:;,./<테스트>?'  끝"));
		log.debug("convertToCamelCase(String underScore) : " + StringUtil.convertToCamelCase("d_day"));
		log.debug("convertToUnderScore(String camelCase) : " + StringUtil.convertToUnderScore("dDay"));
		log.debug("getUUIdToString() : " + StringUtil.getUUIdToString());
		log.debug("getUUIdToRemoveString() : " + StringUtil.getUUIdToRemoveString());
		log.debug("urlEncoding(String str, String charSet) : " + StringUtil.urlEncoding("피플.txt", "UTF-8"));
	}

	/**
	 * 문자열이 지정한 길이를 초과했을때 지정한 길이에다가 해당 문자열을 붙여주는 메서드.
	 *
	 * @param source 원본 문자열
	 * @param output 더할 문자열
	 * @param length 지정길이
	 * @return 지정길이로 잘라서 더할 문자열을 합친 문자열
	 */
	public static String cutString(String source, String output, int length) {
		String returnVal = null;
		if (source != null) {
			if (source.length() > length) {
				returnVal = source.substring(0, length) + output;
			} else
				returnVal = source;
		}
		return returnVal;
	}

	/**
	 * 문자열에서 모든 공백문자를 제거한다.
	 * <p>
	 * StringUtil.removeWhitespace(null)         = null
	 * StringUtil.removeWhitespace("")           = ""
	 * StringUtil.removeWhitespace("abc")        = "abc"
	 * StringUtil.removeWhitespace("   ab  c  ") = "abc"
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String removeWhitespace(String str) {
		if (StringUtils.isEmpty(str)) {
			return str;
		}

		int sz = str.length();
		char[] chs = new char[sz];
		int count = 0;
		for (int i = 0; i < sz; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				chs[count++] = str.charAt(i);
			}
		}
		if (count == sz) {
			return str;
		}

		return new String(chs, 0, count);
	}

	/**
	 * null 을 ""로 변경
	 * @param str
	 * @return
	 */
	public static String changeNulltoEmptyString(String str) {
		return (str == null) ? "" : str;
	}

	/**
	 * 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
	 *
	 * @return
	 */
	public static String getTimeStamp(String pattern) {
		String rtnStr = null;

		SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
		Timestamp ts = new Timestamp(System.currentTimeMillis());

		rtnStr = sdfCurrent.format(ts.getTime());

		return rtnStr;
	}

	/**
	 * 타임 포맷 변경
	 *
	 * @return
	 */
	public static String getTimeStamp(String date, String beforeFormatStr, String afterFormatStr) {

		String rtnStr = date;

		try {

			// String 타입을 java.util.Date 로 변환한다.
			java.text.SimpleDateFormat beforeFormat = new java.text.SimpleDateFormat(beforeFormatStr);
			java.text.SimpleDateFormat afterFormat = new java.text.SimpleDateFormat(afterFormatStr);
			java.util.Date dateLatestLoginDate = beforeFormat.parse(date);

			// java.util.Date 를 java.sql.Timestamp 로 변환한다.
			java.sql.Timestamp tsTimestamp = new java.sql.Timestamp( dateLatestLoginDate.getTime() ) ;

			rtnStr = afterFormat.format(tsTimestamp.getTime());

		} catch (Exception ex) {
			// Exception 에 대한 오류처리를 한다.
		}

		return rtnStr;
	}

	/**
	 * 문자열의 마지막부터 숨길글자수 만큼 *로 변환한다.
	 *
	 * @param str    문자열
	 * @param length 숨길 글자 수
	 * @return
	 */
	public static String hiddenString(String str, int length) {
		String tempStr = "";

		if (StringUtils.isNotEmpty(str) && str.length() >= length) {
			int point = str.length() - length;
			for (int i = 0; i < str.length(); i++) {
				if (i < point) {
					tempStr += str.charAt(i);
				} else {
					tempStr += "*";
				}
			}
			str = tempStr;
		}

		return str;
	}

	/**
	 * html코드를 특수코드로 변환
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String htmlToCode(String str) {
		if (StringUtils.isBlank(str)) return str;
		str = str.replaceAll("&", "&amp;")
				.replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;")
				.replaceAll("\"", "&quot;")
				.replaceAll("\'", "&#x27;")
				.replaceAll("/", "&#x2F;");
		return str;
	}

	public static String htmlToCodeExceptDoubleQuote(String str) {
		if (StringUtils.isBlank(str)) return str;
		str = str.replaceAll("&", "&amp;")
				.replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;")
				.replaceAll("\'", "&#x27;")
				.replaceAll("/", "&#x2F;");
		return str;
	}

	/**
	 * 특수코드를 html코드로 변환
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String codeToHtml(String str) {
		if (StringUtils.isBlank(str)) return str;
		str = str.replaceAll("&amp;", "&")
				.replaceAll("&lt;", "<")
				.replaceAll("&gt;", ">")
				.replaceAll("&quot;", "\"")
				.replaceAll("&#x27;", "\'")
				.replaceAll("&#x2F;", "/");
		return str;
	}

	/**
	 * 문자열을 HTML 표현으로 바꿔준다.
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String strToHtml(String str) {
		if (StringUtils.isBlank(str)) return str;
		str = StringUtils.defaultString(str);
		str = str.replaceAll("\r\n", "<br/>")
				.replaceAll("\n", "<br/>")
				.replaceAll(" ", "&nbsp;");
		return str;
	}

	/**
	 * 문자열을 HTML 표현 및 특수코드로 바꿔준다.
	 *
	 * @param str 문자열
	 * @return
	 */
	public static String strToHtmlCode(String str) {
		if (StringUtils.isBlank(str)) return str;
		str = htmlToCode(str);
		str = str.replaceAll("\r\n", "<br/>")
				.replaceAll("\n", "<br/>")
				.replaceAll(" ", "&nbsp;");
		return str;
	}

	/**
	 * underScore 문자열을 Camel 형식으로 변환하여 반환한다.
	 *
	 * @param underScore 언더바 문자열
	 * @return
	 */
	public static String convertToCamelCase(String underScore) {
		StringBuffer buffer = new StringBuffer();
		for (String token : underScore.toLowerCase().split("_")) {
			buffer.append(StringUtils.capitalize(token));
		}
		return StringUtils.uncapitalize(buffer.toString());
	}

	/**
	 * Camel 문자열을 underScore 형식으로 변환하여 반환한다.
	 *
	 * @param camelCase camel 문자열
	 * @return
	 */
	public static String convertToUnderScore(String camelCase) {
		String regex = "([a-z])([A-Z]+)";
		String replacement = "$1_$2";
		return camelCase.replaceAll(regex, replacement).toLowerCase();
	}

	/**
	 * 랜덤 UUID(유니버셜 유니크 아이디)를 반환한다.
	 *
	 * @return
	 */
	public static String getUUIdToString() {
		return UUID.randomUUID().toString();
	}

	/**
	 * Bar(-)를 제거한 랜덤 UUID(유니버셜 유니크 아이디)를 반환한다.
	 *
	 * @return
	 */
	public static String getUUIdToRemoveString() {
		return StringUtils.replace(getUUIdToString(), "-", "");
	}

	/**
	 * 문자열을 캐릭터셋으로 인코딩한다.
	 *
	 * @param str     인코딩할 문자열
	 * @param charSet 캐릭터셋
	 * @return
	 */
	public static String urlEncoding(String str, String charSet) {
		try {
			return URLEncoder.encode(str, charSet);
		} catch (Exception e) {
			log.debug(e.getMessage());
			return str;
		}
	}

	/**
	 * 문자열에서 숫자만 추출
	 * @param str
	 * @return
	 */
	public static String onlyNumberRemoveCharacter(String str) {
		if (StringUtils.isBlank(str)) {
			return "";
		}
		return str.replaceAll("[^0-9]", "");
	}

	/**
	 * 문자열에서 숫자, 영문자, 한글완성, 공백만 추출
	 * @param str
	 * @return
	 */
	public static String onlyDefaultCharacter(String str) {
		if (StringUtils.isBlank(str)) {
			return "";
		}
		return str.replaceAll("[^0-9a-zA-Z가-힣\\s]", "");    // 숫자, 영문자, 한글완성, 공백만 허용
	}

	/**
	 * 문자열에서 숫자, 영문자, 한글완성만 추출
	 * @param str
	 * @return
	 */
	public static String onlyDefaultCharacterWithoutBlank(String str) {
		if (StringUtils.isBlank(str)) {
			return "";
		}
		return str.replaceAll("[^0-9a-zA-Z가-힣]", "");    // 숫자, 영문자, 한글완성만 허용
	}

	/**
	 * byte 단위로 substring
	 * @param str
	 * @param limitByteLength substr할 바이트 수. 2-byte문자의 경우 바이트가 부족하면 그 앞 글자까지만 자름.
	 * @param bytesForDB 2-byte문자(한글 등)의 DB에서의 바이트 수. 예를들어 오라클/UTF-8이면 3바이트임
	 *                   현재 피자헛 오라클 DB 언어셋은 KO16MSWIN949 ==>> 조합형 한글- 완성형을 포함하여 11172자의 한글을 표현함 (한글바이트: 2byte)
	 * @return
	 */
	public static String substringByByte(String str, int limitByteLength, int bytesForDB) {

		int sumBytes=0, endLen=0, c=0;
		for(int i=0; i < str.length(); i++) {
			c = (int)str.charAt(i);
			sumBytes += (c==10)? bytesForDB: (c>>7 > 0)? bytesForDB : 1; // DB 한글이 2byte 입력일때 // textarea 박스에서 줄내림 값은 charCodeAt 이 10 일때, 이때 1byte 이나 DB로 전송시 2byte 이므로 변경해서 계산
			// b += c==10? 2 : c>>11? 3 : c>>7? 2 : 1; // DB 한글이 3byte 입력일때
			if (sumBytes <= limitByteLength) {
				endLen = i + 1;
			}
		}
		if (sumBytes > limitByteLength) {
			return new String(str.substring(0, endLen));
		} else {
			return str;
		}
	}

	/**
	 * 긴 문자열 자르기.
	 *
	 * @param srcString
	 *               대상문자열
	 * @param nLength
	 *               길이
	 * @param isNoTag
	 *               테그 제거 여부
	 * @param isAddDot
	 *               "..."을추가 여부
	 * @return
	 */
	public static String strCut(String srcString, int nLength, boolean isNoTag, boolean isAddDot) {  // 문자열 자르기
		String rtnVal = srcString;
		int oF = 0, oL = 0, rF = 0, rL = 0;
		int nLengthPrev = 0;
		// 태그 제거
		if (isNoTag) {
			Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE);  // 태그제거 패턴
			rtnVal = p.matcher(rtnVal).replaceAll("");
		}
		rtnVal = rtnVal.replaceAll("&amp;", "&");
		rtnVal = rtnVal.replaceAll("(!/|\r|\n|&nbsp;)", "");  // 공백제거
		try {
			byte[] bytes = rtnVal.getBytes("UTF-8");     // 바이트로 보관
			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
			int j = 0;
			if (nLengthPrev > 0) {
				while (j < bytes.length) {
					if ((bytes[j] & 0x80) != 0) {
						oF += 2;
						rF += 3;
						if (oF + 2 > nLengthPrev) {
							break;
						}
						j += 3;
					} else {
						if (oF + 1 > nLengthPrev) {
							break;
						}
						++oF;
						++rF;
						++j;
					}
				}
			}
			j = rF;
			while (j < bytes.length) {
				if ((bytes[j] & 0x80) != 0) {
					if (oL + 2 > nLength) {
						break;
					}
					oL += 2;
					rL += 3;
					j += 3;
				} else {
					if (oL + 1 > nLength) {
						break;
					}
					++oL;
					++rL;
					++j;
				}
			}
			rtnVal = new String(bytes, rF, rL, "UTF-8");  // charset 옵션
			if (isAddDot && rF + rL + 3 <= bytes.length) {
				rtnVal += "*";
			}  // ...을 붙일지말지 옵션
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return srcString;
		}
		return rtnVal;
	}

	/**
	 * 긴 문자열 자르기 (리턴 남김).
	 * @param srcString
	 * @param nLength
	 * @param isNoTag
	 * @param isAddDot
	 * @return
	 */
	public static String strCutIncludeReturn(String srcString, int nLength, boolean isNoTag, boolean isAddDot) {  // 문자열 자르기
		String rtnVal = srcString;
		int oF = 0, oL = 0, rF = 0, rL = 0;
		int nLengthPrev = 0;
		// 태그 제거
		if (isNoTag) {
			Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE);  // 태그제거 패턴
			rtnVal = p.matcher(rtnVal).replaceAll("");
		}
		try {
			byte[] bytes = rtnVal.getBytes("UTF-8");     // 바이트로 보관
			// x부터 y길이만큼 잘라낸다. 한글안깨지게.
			int j = 0;
			if (nLengthPrev > 0) {
				while (j < bytes.length) {
					if ((bytes[j] & 0x80) != 0) {
						oF += 2;
						rF += 3;
						if (oF + 2 > nLengthPrev) {
							break;
						}
						j += 3;
					} else {
						if (oF + 1 > nLengthPrev) {
							break;
						}
						++oF;
						++rF;
						++j;
					}
				}
			}
			j = rF;
			while (j < bytes.length) {
				if ((bytes[j] & 0x80) != 0) {
					if (oL + 2 > nLength) {
						break;
					}
					oL += 2;
					rL += 3;
					j += 3;
				} else {
					if (oL + 1 > nLength) {
						break;
					}
					++oL;
					++rL;
					++j;
				}
			}
			rtnVal = new String(bytes, rF, rL, "UTF-8");  // charset 옵션
			if (isAddDot && rF + rL + 3 <= bytes.length) {
				rtnVal += "*";
			}  // ...을 붙일지말지 옵션
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return srcString;
		}
		return rtnVal;
	}

	/**
	 * byte size를 가져온다.
	 *
	 * @param str
	 *               String target
	 * @return int bytelength
	 */
	public static int getByteSize(String str) {
		if (str == null || str.length() == 0) {
			return 0;
		}
		byte[] byteArray = null;
		try {
			byteArray = str.getBytes("UTF-8");
		} catch (UnsupportedEncodingException ex) {
		}
		if (byteArray == null) {
			return 0;
		}
		return byteArray.length;
	}

	/**
	 * 주어진 길이(iLength)만큼 주어진 문자(cPadder)를 strSource의 오른쪽에 붙혀서 보내준다. ex) lpad("abc", 5, '^') ==> "abc^^" lpad("abcdefghi", 5, '^') ==> "abcde"
	 * lpad(null, 5, '^') ==> "^^^^^"
	 *
	 * @param strSource
	 * @param iLength
	 * @param cPadder
	 */
	public static String rpad(String strSource, int iLength, char cPadder) {
		StringBuffer sbBuffer = null;
		if (!isNull(strSource)) {
			int iByteSize = getByteSize(strSource);
			if (iByteSize > iLength) {
				return strSource.substring(0, iLength);
			} else if (iByteSize == iLength) {
				return strSource;
			} else {
				int iPadLength = iLength - iByteSize;
				sbBuffer = new StringBuffer(strSource);
				for (int j = 0; j < iPadLength; j++) {
					sbBuffer.append(cPadder);
				}
				return sbBuffer.toString();
			}
		}
		sbBuffer = new StringBuffer();
		for (int j = 0; j < iLength; j++) {
			sbBuffer.append(cPadder);
		}
		return sbBuffer.toString();
	}

	/**
	 * str이 null 이거나 "", "    " 일경우 return true.
	 *
	 * @param str
	 * @return
	 */
	public static boolean isNull(String str) {
		return (str == null || (str.trim().length()) == 0);
	}

	/**
	 * String 날짜 포맷
	 *
	 * @param getDate
	 * @return
	 */
	public static String dateParse(String getDate) throws ParseException {
		Date dateDate = new SimpleDateFormat("yyyyMMdd").parse(getDate);
		String returnDate = new SimpleDateFormat("yyyy-MM-dd").format(dateDate);
		return returnDate;
	}

	/**
	 * HttpServletRequest 객체에서 url를 반환 - 로컬이 아니면 port 안붙임..
	 * http://localhost:8080
	 * @param request
	 * @return
	 */
	public static String getRequestUrl(HttpServletRequest request) {
		String url = request.getScheme() + "://" + request.getServerName();
		if (request.getServerName().equals("localhost") || request.getServerName().equals("127.0.0.1")) {
			url += ":" + request.getServerPort() + request.getContextPath();
		}
		return  url;
	}

	/**
	 * 다국어 메시지 문장내 개행문자 변경
	 * @param message
	 * @return
	 */
	public static String alertMsgNewLine(String message) {
		if (StringUtils.isNotBlank(message)) {
			return message.replaceAll("(\r\n|\r|\n|\n\r)", "\\\\n");    // alert 창 개행문자 줄바꿈
		} else {
			return "";
		}
	}

	/**
	 * JSON object 로 VIEW 단으로 전달시 다국어 메시지의 "\n" 문자는 "\\n" 으로 변경되어 전달되어서 alert 창에서 문장 개행이 되지 않음. 아래와같이 replace 를 하여야함
	 * @param message
	 * @return
	 */
	public static String alertMsgNewLineReturnJson(String message) {
		if (StringUtils.isNotBlank(message)) {
			return message.replaceAll("\\\\n", "\n");    // alert 창 개행문자 줄바꿈
		} else {
			return "";
		}
	}

	/**
	 * XSS 필터로 들어온 파라메터의 방지가 필요한 스크립트 구문을 변환
	 */
	public static String stripXSS(String value) {
		if (StringUtils.isNotBlank(value)) {

			Pattern scriptPattern = Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			//scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			//value = scriptPattern.matcher(value).replaceAll("");

			//scriptPattern = Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			//value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("</script>", Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE);
			value = scriptPattern.matcher(value).replaceAll("");

			scriptPattern = Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
			value = scriptPattern.matcher(value).replaceAll("");
		}
		return value;
	}

	/**
	 * 이메일 마스킹 처리
	 */
	public static String getMaskedEmail(String email) {
		if (StringUtils.isBlank(email)) {
			return email;
		}
		/*
		 * 요구되는 메일 포맷
		 * {aaa}@bbb.ccc
		 * */
		String regex = "\\b(\\S+)+@(\\S+.\\S+)";
		Matcher matcher = Pattern.compile(regex).matcher(email);
		if (matcher.find()) {
			String id = matcher.group(1); // 마스킹 처리할 부분인 userId
			/*
			 * userId의 길이를 기준으로 세글자 초과인 경우 뒤 세자리를 마스킹 처리하고,
			 * 세글자인 경우 뒤 두글자만 마스킹,
			 * 세글자 미만인 경우 모두 마스킹 처리
			 */
			int length = id.length();
			if (length < 3) {
				char[] c = new char[length];
				Arrays.fill(c, '*');
				return email.replace(id, String.valueOf(c));
			} else if (length == 3) {
				return email.replaceAll("\\b(\\S+)[^@][^@]+@(\\S+)", "$1**@$2");
			} else {
				return email.replaceAll("\\b(\\S+)[^@][^@][^@]+@(\\S+)", "$1***@$2");
			}
		}
		// 이메일 형식의 아이디가 아닐경우
		else {
			int length = email.length();
			if (length < 3) {
				char[] c = new char[length];
				Arrays.fill(c, '*');
				return new String(c);
			} else if (length == 3) {
				return StringUtils.rightPad(email.substring(0,email.length()-2), email.length(), '*');
			} else {
				return StringUtils.rightPad(email.substring(0,email.length()-3), email.length(), '*');
			}
		}
	}

	/**
	 * 상품코드를 문자열로
	 */
	public static String toProductCode(String classId, String baseId, String productId, String sizeId) {
		return StringUtils.defaultString(classId) + "_" +
			StringUtils.defaultString(baseId) + "_" +
			StringUtils.defaultString(productId) + "_" +
			StringUtils.defaultString(sizeId);
	}

	/**
	 * 구분자 뒤 문자열
	 * @param delimiter
	 * @param word
	 * @return
	 */
	public static String getDelimiterPrefixStr(String delimiter, String word) {

		try {
			if(StringUtils.isNotBlank(word)){
				word = word.substring(word.lastIndexOf(delimiter)+1, word.length());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return word;
	}

	public static String getExchangeName(String originFileName) {
		String resultStr = originFileName;
		try {
			String milisecondTime = DateUtil.getCurrentDateTime(DateUtil.DATE_MSC_PATTERN);
			resultStr = milisecondTime + "_" + originFileName;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultStr;
	}

	/**
	 * 문자열 숫자 체크
	 * @param s
	 * @return
	 */
	public static boolean isNumeric(String s) {
		try {
			Double.parseDouble(s);
			return true;
		} catch(NumberFormatException e) {
			return false;
		}
	}

	/**
	 * String 날짜 형식(yyyy-MM-dd)인지 체크
	 * @param checkDate
	 * @return
	 */
	public static boolean checkDate(String checkDate) {
		try {
			SimpleDateFormat dateFormatParser = new SimpleDateFormat("yyyy-MM-dd"); //검증할 날짜 포맷 설정
			dateFormatParser.setLenient(false); //false일경우 처리시 입력한 값이 잘못된 형식일 시 오류가 발생
			dateFormatParser.parse(checkDate); //대상 값 포맷에 적용되는지 확인
			return true;
		} catch (Exception e) {
			return false;
		}
	}
}
