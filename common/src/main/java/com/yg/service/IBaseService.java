package com.yg.service;

import java.util.List;

/**
 * Created by panrui on 2015/10/4.
 */
public interface IBaseService<T> {

    T queryById(long id);

    int deleteById(long id);

    List<T> queryAll();

    int save(T t);


    int updateById(T t);
}
