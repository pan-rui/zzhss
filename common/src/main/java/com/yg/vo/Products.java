package com.yg.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @Description: 商品VO对象
 * @Created: 潘锐 (2016-01-17 15:53)
 * $Rev: 487 $
 * $Author: panrui $
 * $Date: 2016-01-18 17:19:36 +0800 (周一, 18 一月 2016) $
 */
public class Products implements Serializable{
    private List<Map<String,Object>> products;

    public List<Map<String, Object>> getProducts() {
        return products;
    }

    public void setProducts(List<Map<String, Object>> products) {
        this.products = products;
    }
}
