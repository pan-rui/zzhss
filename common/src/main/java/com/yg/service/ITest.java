package com.yg.service;

import com.yg.base.BaseResult;

import java.io.Serializable;

/**
 * Created by panrui on 2015/9/13.
 */
public interface ITest extends Serializable{

    public BaseResult getAdmin();
    public BaseResult getAdmin(Long id, String name);
}
