<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />

<!DOCTYPE html>
<html lang="${cms.locale}">

<head>
    <meta charset="${cms.requestContext.encoding}">
    <title><cms:info property="opencms.title" /></title>

    <meta name="description" content="<cms:property name="Description" file="search" default="" />">
    <meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />">
    <meta name="robots" content="index, follow">
    <meta name="revisit-after" content="7 days">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">

    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link href="<cms:link>/system/modules/vn.foo.core.product/resources/css/main.css</cms:link>" rel="stylesheet">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">

    <cms:enable-ade />
    <cms:headincludes type="css" />
    <script src='https://www.google.com/recaptcha/api.js?hl=${cms.locale}'></script>
</head>

<body>
<c:if test="${cms.isEditMode}">
    === Placeholder for OpenCms toolbar in edit mode ===
    <div id="toolbar-placeholder" style="height: 22px"></div>
</c:if>
<!-- Header Start -->
<cms:container name="siteTop"
               tagClass="foo-site-top"
               editableby=""
               type="foo-header" maxElements="2">
    <div>
        <h3>Header component</h3>
        <p>Just allow header footer component</p>
    </div>
</cms:container>
<!-- Header End -->

<cms:container name="siteMain" tagClass="foo-site-main" type="foo-main">
    <div>
        <div class="gap-40"></div>
        <h3>Main Container</h3>
        <p>Allow all </p>
        <div class="gap-60"></div>
    </div>
</cms:container>

<!-- Footer start-->
<cms:container name="siteFoot" tagClass="foo-site-foot" type="foo-footer" maxElements="2">
    <div>
        <h3>Footer component</h3>
        <p>Just allow header footer component</p>
    </div>
</cms:container>
<!-- Footer end-->
</body>

</html>