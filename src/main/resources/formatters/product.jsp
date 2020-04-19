<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <div>
        <h3>${content.value.ProductName}</h3>
        <h5>SKU: ${content.value.SKU}</h5>
        <h5>Price: ${content.value.Price}</h5>
        <div>${content.value.Content}</div>
    </div>
</cms:formatter>