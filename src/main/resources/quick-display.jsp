<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <div class="card">
        <img class="card-img-top" src="https://dummyimage.com/600x400/55595c/fff" alt="Card image cap">
        <div class="card-body">
            <h4 class="card-title"><a href="<cms:link>${content.filename}</cms:link>" title="View Product">Product title</a></h4>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
            <div class="row">
                <div class="col">
                    <p class="btn btn-danger btn-block">99.00 $</p>
                </div>
                <div class="col">
                    <a href="#" class="btn btn-success btn-block">Add to cart</a>
                </div>
            </div>
        </div>
    </div>
</cms:formatter>