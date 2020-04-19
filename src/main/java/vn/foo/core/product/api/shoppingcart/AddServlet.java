package vn.foo.core.product.api.shoppingcart;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.opencms.main.CmsLog;
import org.opencms.main.OpenCmsServlet;
import vn.foo.core.product.domain.Item;
import vn.foo.core.product.domain.ProductDetail;
import vn.foo.core.product.service.FooCmsObject;
import vn.foo.core.product.service.FooService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/opencms/items/add")
public class AddServlet extends OpenCmsServlet {
    private static Log log = CmsLog.getLog(AddServlet.class);

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        log.debug("AddItemServlet: ok ok ok ok");
        if (FooCmsObject.getInstance().getCmsObject() == null) {
            leaveNow(req, res);
            return;
        }
        ProductDetail productDetail = new ProductDetail(req);

        if (productDetail.invalid()) {
            leaveNow(req, res);
            return;
        }

        log.debug(String.format("found %s, %s, %s", productDetail.resourceId, productDetail.sku, productDetail.price));
        FooService fooService = new FooService(req, res);
        fooService.addItem(new Item(productDetail, 1));
        leaveNow(req, res);
    }

    private void leaveNow(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String referer = req.getHeader("referer");
        if (StringUtils.isBlank(referer)) {
            referer = "/";
        }
        res.setStatus(403);
        res.sendRedirect(referer);
    }
}
