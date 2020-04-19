package vn.foo.core.product.api;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.opencms.mail.CmsSimpleMail;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCms;
import org.opencms.main.OpenCmsServlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/opencms/email")
public class EmailServlet extends OpenCmsServlet {
    private static Log log = CmsLog.getLog(EmailServlet.class);
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        final String email = req.getParameter("email");
        final String subject = req.getParameter("subject");
        final String content = req.getParameter("content");

        if (StringUtils.isAnyBlank(email, subject, content)) {
            res.setStatus(403);
            res.getWriter().println("Loi 403");
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

        res.setStatus(404);
        res.getWriter().println("Gui email thanh cong");
    }
}
