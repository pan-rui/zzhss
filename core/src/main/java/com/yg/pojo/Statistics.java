package com.yg.pojo;

import java.util.Date;

public class Statistics {
    private Long id;

    private String name;

    private String sqlString;

    private String columnList;

    private String description;

    private Date cteime;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSqlString() {
        return sqlString;
    }

    public void setSqlString(String sqlString) {
        this.sqlString = sqlString == null ? null : sqlString.trim();
    }

    public String getColumnList() {
        return columnList;
    }

    public void setColumnList(String columnList) {
        this.columnList = columnList == null ? null : columnList.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public Date getCteime() {
        return cteime;
    }

    public void setCteime(Date cteime) {
        this.cteime = cteime;
    }
}