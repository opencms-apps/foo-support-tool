<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="org.opencms.mail.CmsSimpleMail" %>
<%@ page import="org.opencms.main.OpenCms" %>
<%@ page import="org.opencms.util.CmsStringUtil" %>
<cms:secureparams/>

<%
    final String email = request.getParameter("email");
    final String subject = request.getParameter("subject");
    final String content = request.getParameter("content");

    if (email == null || subject == null || content == null ||
            email.trim() == "" || subject.trim() == "" || content.trim() == "") {
        out.print("Missing email, subject vs content");
        return;
    }

    OpenCms.getExecutor().execute(new Runnable() {
        @Override
        public void run() {
            try {
                CmsSimpleMail sm = new CmsSimpleMail();
                sm.setSubject(subject);
                sm.setMsg(content);
                sm.addTo(email);
                sm.setFrom("onggiatuoi9x@gmail.com");
                sm.send();
            }catch (Exception ex) {
                System.out.printf("eeee" + ex.getMessage());
            }

        }
    });
%>
<h1>Send email to <%=email%> success, please check your inbox</h1>
