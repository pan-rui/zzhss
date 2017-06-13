package com.yg.pojo;

import java.io.Serializable;

public class Menu implements Serializable {
    private Long id;
    private String menuName;
    private String url;
    private String menuLevel;
    private String isIntercept;
    private Long parentId;
    private String icon;
    private Integer sort;
    private String fixedly;
    private String active;
    private String search;
    private String operate;
    private String cMenu;
    private String help;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName == null ? null : menuName.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getMenuLevel() {
        return menuLevel;
    }

    public void setMenuLevel(String menuLevel) {
        this.menuLevel = menuLevel;
    }

    public String getIsIntercept() {
        return isIntercept;
    }

    public void setIsIntercept(String isIntercept) {
        this.isIntercept = isIntercept;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getFixedly() {
        return fixedly;
    }

    public void setFixedly(String fixedly) {
        this.fixedly = fixedly;
    }

    public String getActive() {
        return active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getSearch() {
        return search;
    }

    public void setSearch(String search) {
        this.search = search;
    }

    public String getOperate() {
        return operate;
    }

    public void setOperate(String operate) {
        this.operate = operate;
    }

    public String getHelp() {
        return help;
    }

    public void setHelp(String help) {
        this.help = help;
    }

    public String getcMenu() {
        return cMenu;
    }

    public void setcMenu(String cMenu) {
        this.cMenu = cMenu;
    }
}