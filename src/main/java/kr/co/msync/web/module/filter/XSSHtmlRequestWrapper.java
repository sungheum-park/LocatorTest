package kr.co.msync.web.module.filter;

import kr.co.msync.web.module.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;

import javax.servlet.ReadListener;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;


@Slf4j
public class XSSHtmlRequestWrapper extends HttpServletRequestWrapper {

	private byte[] b;

	public XSSHtmlRequestWrapper(HttpServletRequest request) {
		super(request);
	}

	public ServletInputStream getInputStream() throws IOException {

		InputStream is = super.getInputStream();
		b = IOUtils.toByteArray(is);

		String requestStringBody = new String(b, StandardCharsets.UTF_8.name());

		requestStringBody = StringUtil.stripXSS(StringUtil.htmlToCodeExceptDoubleQuote(requestStringBody));

		b = requestStringBody.getBytes(StandardCharsets.UTF_16BE.name());

		final ByteArrayInputStream bis = new ByteArrayInputStream(b);
		return new ServletInputStreamImpl(bis);
	}

	class ServletInputStreamImpl extends ServletInputStream{

		private InputStream is;

		public ServletInputStreamImpl(InputStream bis){
			is = bis;
		}

		public int read() throws IOException {
			return is.read();
		}

		public int read(byte[] b) throws IOException {
			return is.read(b);
		}

		@Override
		public boolean isFinished() {
			return false;
		}

		@Override
		public boolean isReady() {
			return false;
		}

		@Override
		public void setReadListener(ReadListener readListener) {

		}
	}

	public String[] getParameterValues(String parameter) {
		String[] values = super.getParameterValues(parameter);
		if(values == null){
			return null;
		}

		for(int i = 0; i < values.length; i++) {
			if(values[i] != null) {
				values[i] = StringUtil.stripXSS(StringUtil.htmlToCode(values[i]));
			} else {
				values[i] = null;
			}
		}

		return values;
	}

	public String getParameter(String parameter) {
		String value = super.getParameter(parameter);
		if(value == null){
			return null;
		}

		return StringUtil.stripXSS(StringUtil.htmlToCode(value));
	}

}
