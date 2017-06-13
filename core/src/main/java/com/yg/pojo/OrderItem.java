package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class OrderItem implements Serializable{
    private Long id;

    private Long orderId;

    private Long prodId;

    private String prodName;

    private Double price;

    private Double priceY;

    private Integer count;

    private Object imei;

    private Date ctime;

    private Product product;

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getProdId() {
        return prodId;
    }

    public void setProdId(Long prodId) {
        this.prodId = prodId;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName == null ? null : prodName.trim();
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getPriceY() {
        return priceY;
    }

    public void setPriceY(Double priceY) {
        this.priceY = priceY;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Object getImei() {
        return imei;
    }

    public void setImei(Object imei) {
        this.imei = imei;
    }

    public Date getCtime() {
        return ctime;
    }

    public void setCtime(Date ctime) {
        this.ctime = ctime;
    }
}