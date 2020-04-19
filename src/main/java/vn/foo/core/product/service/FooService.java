package vn.foo.core.product.service;

import org.apache.commons.logging.Log;
import org.opencms.main.CmsLog;
import vn.foo.core.common.Constants;
import vn.foo.core.product.domain.Item;
import vn.foo.core.product.domain.context.FooContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class FooService {
    private static Log log = CmsLog.getLog(FooService.class);
    private FooContext fooContext;

    public FooService(HttpServletRequest request, HttpServletResponse response) {
        fooContext = new FooContext(request, response);
    }

    public boolean addItem(Item item) {
        if (item == null) {
            log.debug("item is null");
            return false;
        }
        List<Item> items = getItems();
        if (items.contains(item)) {
            log.debug("item contain in list");
            items.forEach(item1 -> {
                if (item1.equals(item)) {
                    item1.quantity += item.quantity;
                }
            });
        } else {
            items.add(item);
        }
        log.debug(String.format("current has %s items", items.size()));
        saveItems(items);
        return true;
    }

    @SuppressWarnings("unchecked")
    public List<Item> getItems() {
        List<Item> items = (List<Item>) fooContext.findItem(Constants.CART);
        if (items == null) {
            log.debug(String.format("can't find items in %s", Constants.CART));
            items = new ArrayList<>();
            fooContext.updateItem(Constants.CART, items);
        }
        return items;
    }

    public void saveItems(List<Item> items) {
        fooContext.updateItem(Constants.CART, items);
    }
}
