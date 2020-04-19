package vn.foo.core.product.api.shoppingcart;

import org.apache.commons.logging.Log;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCmsServlet;
import vn.foo.core.product.service.FooService;
import vn.foo.core.utils.JsonSerializer;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet("/opencms/items/all")
public class ListServlet extends OpenCmsServlet {
    private static Log log = CmsLog.getLog(ListServlet.class);

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) {
        FooService fooService = new FooService(req, res);
        fooService.getItems();
        try {
            PrintWriter out = res.getWriter();
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            out.print(JsonSerializer.object2Json(fooService.getItems()));
            out.flush();
        } catch (Exception ex) {
            log.error(ex);
            res.setStatus(500);
        }
    }
}
