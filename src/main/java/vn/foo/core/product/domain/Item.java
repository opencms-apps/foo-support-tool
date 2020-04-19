package vn.foo.core.product.domain;

import java.util.Objects;

public class Item {
    public ProductDetail product;
    public Integer quantity = 0;

    public Item() {}

    public Item(ProductDetail productDetail, Integer quantity) {
        product = productDetail;
        this.quantity = quantity;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Item item = (Item) o;
        return Objects.equals(product.sku, item.product.sku);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(product.sku);
    }

    public ProductDetail getProduct() {
        return product;
    }

    public Integer getQuantity() {
        return quantity;
    }
}
