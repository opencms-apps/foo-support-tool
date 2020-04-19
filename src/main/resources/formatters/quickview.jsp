<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <div class="card">
        <c:choose>
            <c:when test="${content.value.Thumbnail.isSet}">
                <cms:img cssclass="card-img-top" src="${content.value.Thumbnail}" alt="${content.value.ProductName}" noDim="true" />
            </c:when>
            <c:otherwise>
                <img class="card-img-top" src="http://placehold.it/600x400/fff?text=${content.value.ProductName}" alt="${content.value.ProductName}" />
            </c:otherwise>
        </c:choose>
        <div class="card-body">
            <h4 class="card-title"><a href="<cms:link>${content.filename}</cms:link>" title="${content.value.ProductName}">${content.value.ProductName}</a></h4>
            <div class="card-text">${content.value.ShortDesc}</div>
            <div class="row">
                <div class="col">
                    <div>SKU: ${content.value.SKU}</div>
                    <div>Price: ${content.value.Price} VND</div>
                </div>
                <div class="col">
                    <form action="/items/add" method="post">
                        <input type="hidden" value="${content.id}" name="id" />
                        <input type="hidden" value="${content.value.ProductName}" name="productName" />
                        <input type="hidden" value="${content.value.Price}" name="price" />
                        <input type="hidden" value="${content.value.SKU}" name="sku" />
                        <button type="submit" class="btn btn-success btn-block">Add to cart</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</cms:formatter>