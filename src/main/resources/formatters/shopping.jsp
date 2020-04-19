<%@ page import="vn.foo.core.product.service.FooService" %>
<%@ page import="vn.foo.core.product.domain.Item" %>
<%@ page import="java.util.List" %>
<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value">
    <div class="container">
        <%
            FooService fooService = new FooService(request, response);
            List<Item> items = fooService.getItems();
            pageContext.setAttribute("items", items);
        %>

        <div class="cart-info">
            <table id="cart" class="table table-hover table-condensed">
                <thead>
                <tr>
                    <th style="width:50%">Product</th>
                    <th style="width:10%">Price</th>
                    <th style="width:8%">Quantity</th>
                    <th style="width:22%" class="text-center">Subtotal</th>
                    <th style="width:10%"></th>
                </tr>
                </thead>
                <tbody>
                    <c:set var="total" value="${0}" />
                    <c:forEach var="item" items="${items}">
                        <c:set var="subTotal" value="${item.quantity * item.product.price}" />
                        <c:set var="total" value="${total + subTotal}" />

                        <c:set var="resourcePath" value="${cms.requestContext.removeSiteRoot(item.product.resourcePath)}" />
                        <cms:contentload collector="singleFile" param="${resourcePath}" >
                            <cms:contentaccess var="xcontent" />
                            <tr>
                                <td data-th="Product">
                                    <div class="row">
                                        <div class="col-sm-2 hidden-xs">
                                            <cms:img style="width: 100px" src="${xcontent.value.Thumbnail}" alt="${xcontent.value.ProductName}" cssclass="img-responsive" noDim="true" />
                                        </div>
                                        <div class="col-sm-10">
                                            <h4 class="nomargin">${xcontent.value.ProductName}</h4>
                                            <p>${xcontent.value.ShortDesc}</p>
                                        </div>
                                    </div>
                                </td>
                                <td data-th="Price">${item.product.price} VND</td>
                                <td data-th="Quantity">
                                    <input type="number" class="form-control text-center" value="${item.quantity}">
                                </td>
                                <td data-th="Subtotal" class="text-center">${subTotal} VND</td>
                                <td class="actions" data-th="">
                                    <button class="btn btn-info btn-sm"><i class="fa fa-refresh"></i></button>
                                    <button class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i></button>
                                </td>
                            </tr>
                        </cms:contentload>

                    </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <td><a href="#" class="btn btn-warning"><i class="fa fa-angle-left"></i> Continue Shopping</a></td>
                    <td colspan="2" class="hidden-xs"></td>
                    <td class="hidden-xs text-center"><strong>Total: ${total} VND</strong></td>
                    <td><a href="#" class="btn btn-success btn-block">Checkout <i class="fa fa-angle-right"></i></a></td>
                </tr>
                </tfoot>
            </table>
        </div>
    </div>
</cms:formatter>