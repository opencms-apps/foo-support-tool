<%@ page import="vn.foo.core.product.service.FooService" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="vn.foo.core.utils.JsonSerializer" %><%
    FooService fooService = new FooService(request, response);
    fooService.getItems();
    try {
        PrintWriter outx = response.getWriter();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        outx.print(JsonSerializer.object2Json(fooService.getItems()));
        outx.flush();
    } catch (Exception ex) {
        ex.printStackTrace();
        response.setStatus(500);
    }
%>