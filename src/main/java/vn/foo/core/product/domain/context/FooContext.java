package vn.foo.core.product.domain.context;

import vn.foo.core.product.domain.Item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class FooContext {
    private HttpSession session;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public FooContext(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        this.session = request.getSession(true);
    }

    public Object findItem(String name) {
        return session.getAttribute(name);
    }

    public void updateItem(String name, List<Item> items) {
        session.setAttribute(name, items);
    }
}
