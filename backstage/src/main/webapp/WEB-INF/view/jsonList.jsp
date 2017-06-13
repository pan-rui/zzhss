<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="y" uri="http://www.yg.com/y" %>
{
"total":${page.totalRecord}, "rows": [
<c:forEach items="${page.results}" var="bean" varStatus="s">
	{
	<c:forEach items="${columnsInfo}" var="column" varStatus="c">
		<c:choose>
			<c:when test="${fn:startsWith(column.data_type,'date')}">
				"${column.column_name}": "${fn:replace(bean[column.column_name],'\"','\\\"')}"${c.last?"":","}
			</c:when>
			<c:otherwise>
				"${column.column_name}": "<y:toHtml text="${bean[column.column_name]}"/>"${c.last?"":","}
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${not empty menuInfo.operate}">
		,"controler":"<y:toHtml text="${menuInfo.operate}"/>"
	</c:if>
	}
	${s.last?"":","}
</c:forEach>
], "error": "false", "msg": "处理出错！"
}