package vn.foo.core.product.api;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.opencms.mail.CmsHtmlMail;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.main.OpenCmsServlet;
import vn.foo.core.utils.JsonSerializer;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/opencms/email")
public class EmailServlet extends OpenCmsServlet {
    private static Log log = CmsLog.getLog(EmailServlet.class);

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        if (req == null || res == null) {
            log.debug("can't run it now");
            return;
        }
        final String email = req.getParameter("email");
        final String subject = req.getParameter("subject");
        final String content = req.getParameter("content");
        res.setContentType("application/json;charset=UTF-8");
        if (StringUtils.isAnyBlank(email, subject, content)) {
            res.setStatus(403);
            res.getWriter().println("Loi 403");
            return;
        }

        OpenCms.getExecutor().execute(new Runnable() {
            @Override
            public void run() {
                List<InternetAddress> emails = Arrays.stream(email.split(","))
                        .filter(s -> StringUtils.isNotBlank(s))
                        .map(s -> {
                            try {
                                return new InternetAddress(s.trim());
                            } catch (AddressException e) {
                            }
                            return null;
                        })
                        .filter(email -> email != null)
                        .collect(Collectors.toList());
                if (emails.isEmpty()) {
                    log.error(String.format("no valid email in %s", email));
                    return;
                }
                try {
                    CmsHtmlMail sm = new CmsHtmlMail();
                    sm.setSubject(subject);
                    sm.setHtmlMsg(content);
                    sm.setTo(emails);
                    sm.setFrom("onggiatuoi9x@gmail.com");
                    sm.send();
                } catch (Exception ex) {
                    log.error(String.format("error when send email %s, %s", email, ex));
                }
            }
        });

        res.setStatus(200);
        res.getOutputStream().print(JsonSerializer.object2Json(new Response().success("Gui email thanh cong")));
    }

    public static class Response {
        public Type type;
        public String msg;

        public enum Type {
            success, error, denied
        }

        public Response() {
            type = Type.denied;
            msg = "";
        }

        public Response success(String msg) {
            type = Type.success;
            this.msg = msg;
            return this;
        }

        public Response error(String msg) {
            type = Type.error;
            this.msg = msg;
            return this;
        }
    }
}
