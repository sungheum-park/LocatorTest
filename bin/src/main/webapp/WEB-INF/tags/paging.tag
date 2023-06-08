<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageInfoHolder" required="true" type="kr.co.msync.web.module.common.model.PageMaker" %>
<%@ attribute name="jsList" required="false"%>
<c:if test="${pageMaker.totalCount > 0}">
	<div class="page_num">
		<c:if test="${pageMaker.prev}">
			<div class="prev" onclick="jsList('${pageMaker.startPage-1}')"></div>
		</c:if>
		<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
			<div class="page<c:out value="${pageMaker.page == idx ? ' on' : ''}"/>">
				<a href="javascript:;" onclick="jsList('${idx}')">${idx}</a>
			</div>
		</c:forEach>
		<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<div class="next" onclick="jsList('${pageMaker.endPage+1}')"></div>
		</c:if>
	</div>
</c:if>
