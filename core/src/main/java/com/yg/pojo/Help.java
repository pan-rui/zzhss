package com.yg.pojo;

import java.io.Serializable;
import java.util.Date;

public class Help implements Serializable {
    private Long id;

    private String questionName;

    private Date createTime;

    private Long helpTypeId;

    private String answer;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQuestionName() {
        return questionName;
    }

    public void setQuestionName(String questionName) {
        this.questionName = questionName == null ? null : questionName.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getHelpTypeId() {
        return helpTypeId;
    }

    public void setHelpTypeId(Long helpTypeId) {
        this.helpTypeId = helpTypeId;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer == null ? null : answer.trim();
    }
}