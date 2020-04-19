<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
<div>
    <c:choose>
        <c:when test="${cms.isDetailRequest()}">
            <cms:container name="detailfornews"
                           tagClass="col-lg-12" detailview="true"
                           type="foo-product-info">
                <div class="list">
                    Detail of news
                </div>
            </cms:container>
        </c:when>
        <c:otherwise>
            <cms:include file="../elements/product-list.jsp" />
        </c:otherwise>
    </c:choose>
</div>
</cms:formatter>