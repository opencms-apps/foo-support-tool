<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <c:set var="folder">${cms.requestContext.siteRoot}/.content/</c:set>
    <c:set var="resType">foo-product-info</c:set>

    <c:set var="queryFolder">parent-folders:\"${folder}\"</c:set>
    <c:set var="queryType">type:${resType}</c:set>
    <c:set var="queryCategory">category:\"${content.readCategories.leafItems[0].path}\"</c:set>
    <c:set var="querySort">lastmodified desc</c:set>
    <c:set var="queryvalue">fq=${queryFolder}&fq=${queryType}&fq=${queryCategory}&sort=${querySort}</c:set>

    <c:if test="${content.value.ItemPerPage.exists and not empty content.value.ItemPerPage.stringValue}">
        <c:set var="itemsPerPage" value="${content.value.ItemPerPage.toInteger}" />
    </c:if>

    <c:set var="resultSize" value="${0}" />
    <c:set var="itemsPerPage" value="${12}" />

    <%-- Define a create path --%>
    <c:set var="searchconfig">
        {
        "ignorequery" : true,
        "extrasolrparams" : "${queryvalue}",
        "sortoptions" : [
            { "label" : "M\u1edbi nh\u1ea5t", "paramvalue" : "desc", "solrvalue" : "lastmodified desc" },
            { "label" : "C\u0169 nh\u1ea5t", "paramvalue" : "asc", "solrvalue" : "lastmodified asc" }
        ],
        "pagesize" : ${itemsPerPage}
        }
    </c:set>
    <cms:search configString="${searchconfig}" var="search" addContentInfo="true" />
    <c:set var="sortController" value="${search.controller.sorting}" />



    <div class="container-fluid">
        <c:out value="${searchconfig}" />
        <h2>${value.Title}</h2>
        <c:if test="${search.numFound > 0}">
            <c:set var="resultSize" value="${search.numFound}" />

            <div class="row">
                <c:forEach var="result" items="${search.searchResults}">
                    <div class="col-12 col-md-4 col-lg-3">
                        <cms:display value='${result.xmlContent.filename}'
                                     displayFormatters="${content.value.OrtherTypesToCollect}"
                                     editable="true" create="true" delete="true" />
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${resultSize gt itemsPerPage}">
            <c:set var="pagination" value="${search.controller.pagination}" />
            <c:if test="${not empty pagination && search.numPages > 1}">
                <div class="paging text-center">
                    <ul class="pagination">
                        <!-- Phan trang -->
                        <c:if test="${pagination.state.currentPage != 1}">
                            <c:set var="firstPage">1</c:set>
                            <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                                <a href='?${search.stateParameters.setPage[firstPage]}'
                                   title='First'
                                >
                                    <span class="fa fa-${singleStep ? 'fast' : 'step'}-backward" aria-hidden="true"></span>
                                </a>
                            </li>
                            <c:if test="${singleStep}">
                                <c:set var="previousPage">${pagination.state.currentPage > 1 ? pagination.state.currentPage - 1 : 1}</c:set>
                                <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                                    <a href='?${search.stateParameters.setPage[previousPage]}'
                                       title='Previous' >
                                        <span class="fa fa-step-backward" aria-hidden="true"></span>
                                    </a>
                                </li>
                            </c:if>
                        </c:if>
                        <c:forEach var="page" begin="${search.pageNavFirst}" end="${search.pageNavLast}">
                            <c:set var="pageNr">${page}</c:set>
                            <li ${pagination.state.currentPage eq page ? "class='active'" : ""}>
                                <a href='?${search.stateParameters.setPage[pageNr]}'
                                   title='Page ${pageNr}' >
                                    <span class="number">${pageNr}</span>
                                </a>
                            </li>
                        </c:forEach>
                        <c:set var="pages">${search.numPages}</c:set>
                        <c:set var="next">${pagination.state.currentPage < search.numPages ? pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
                        <c:if test="${pagination.state.currentPage < search.numPages}">
                            <c:if test="${singleStep}">
                                <li ${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
                                    <a href='?${search.stateParameters.setPage[next]}'
                                       title='Next' >
                                        <span class="fa fa-step-forward" aria-hidden="true"></span>
                                    </a>
                                </li>
                            </c:if>
                            <li ${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
                                <a href='?${search.stateParameters.setPage[pages]}'
                                   title='Last' >
                                    <span class="fa fa-${singleStep ? 'fast' : 'step'}-forward" aria-hidden="true"></span>
                                </a>
                            </li>
                        </c:if>
                        <!-- Ket Thuc : Phan trang -->
                    </ul>
                </div>
            </c:if>
        </c:if>
    </div>
</cms:formatter>