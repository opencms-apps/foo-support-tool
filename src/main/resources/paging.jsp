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