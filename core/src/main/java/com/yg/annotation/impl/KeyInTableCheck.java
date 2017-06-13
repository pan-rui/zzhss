package com.yg.annotation.impl;

import com.yg.annotation.KeyInTable;
import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.IBaseDao;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.io.Serializable;

/**
 * Created by lenovo on 2014/12/8.
 */
public class KeyInTableCheck implements ConstraintValidator<KeyInTable, Serializable> {
    private KeyInTable keyInTable;
    private IBaseDao baseDao;
    private String column;

    @Override
    public void initialize(KeyInTable keyInTable) {
        this.keyInTable = keyInTable;
//        System.out.println("application========================>"+applicationContext);
        this.baseDao = (IBaseDao) Constants.applicationContext.getBean(keyInTable.value());
        this.column = keyInTable.column();
    }

    @Override
    public boolean isValid(Serializable serializable, ConstraintValidatorContext constraintValidatorContext) {
        if (serializable == null) return false;
        if (StringUtils.isEmpty(column))
            return baseDao.queryById((long) serializable) != null;
        else
            return baseDao.queryByPros(new ParamsMap().addParams(column, serializable)).size() > 0;
    }
}
