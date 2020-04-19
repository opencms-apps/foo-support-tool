package vn.foo.core.product.domain;

import org.apache.commons.lang3.StringUtils;
import vn.foo.core.product.service.FooCmsObject;

import javax.servlet.http.HttpServletRequest;

public class ProductDetail {
    public String resourceId;
    public String resourcePath;
    public String productName;
    public String sku;
    public Double price;

    public ProductDetail() {}

    public ProductDetail(HttpServletRequest req) {
        resourceId = req.getParameter("id");
        resourcePath = FooCmsObject.getInstance().getResourcePath(resourceId);
        productName = req.getParameter("productName");
        try {
            price = Double.parseDouble(req.getParameter("price"));
        } catch (Exception ex) {}
        productName = req.getParameter("productName");
        sku = req.getParameter("sku");
    }

    public boolean invalid() {
        return StringUtils.isAnyBlank(resourceId, productName, sku) || price < 1;
    }

    public String getResourcePath() {
        return resourcePath;
    }

    public String getResourceId() {
        return resourceId;
    }

    public String getProductName() {
        return productName;
    }

    public String getSku() {
        return sku;
    }

    public Double getPrice() {
        return price;
    }
}
