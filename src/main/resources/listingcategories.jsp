<%@ page import="org.opencms.file.CmsObject" %>
<%@ page import="org.opencms.jsp.CmsJspActionElement" %>
<%@ page import="org.opencms.relations.CmsCategory" %>
<%@ page import="org.opencms.relations.CmsCategoryService" %>
<%@ page import="java.util.List" %>
<%
    CmsCategoryService categoryService = CmsCategoryService.getInstance();
    CmsJspActionElement actionElement = new CmsJspActionElement(pageContext, request, response);
    CmsObject cmso = actionElement.getCmsObject();

    List<CmsCategory> categories = categoryService.readCategories(cmso,
            "/",
            true,
            CmsCategoryService.REPOSITORY_BASE_FOLDER);
    for(CmsCategory category: categories) {
        out.print(category.getPath() + "<br/>");
    }



%>
<h1>dfsdfdsfdsfdfdf</h1>