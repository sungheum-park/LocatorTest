<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/common/admin/include.jsp"%>
<tiles:insertAttribute name="modal"/>

<script type="text/javascript">
    function jsImagePreview(o) {
        $('.common_image').show();
        if(src=="") return;
        var src = $(o).find("img").attr("src");
        $(".pdt_big_image img").attr('src','');
        $(".pdt_big_image img").attr("src",src);
    }
</script>