package com.yg.dao;

import com.yg.core.Page;
import com.yg.core.ParamsMap;

import java.util.List;

/**
 * Created by lenovo on 2014/12/8.
 */
public interface IBaseDao<T> {
    //频繁更新的表不建议使用Cache
/*    @Caching(evict = {
            @CacheEvict(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)+'_'+#id"),
            @CacheEvict(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)"),
            @CacheEvict(value = "common",key = "T(com.yg.core.Constants).getPOName(targetClass)+'_page_'+#page.pageNo")
    })*/
    int deleteById(Long id);

/*@Caching(evict = {
    @CacheEvict(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)"),
        @CacheEvict(value = "common",key = "T(com.yg.core.Constants).getPOName(targetClass)+'_page_'+#page.pageNo")
})*/
    int deleteByPO(T t);

    List<T> queryAll();

//    @Cacheable(value = "T(com.yg.core.Constants).getCacheName(targetClass)", key = "T(com.yg.core.Constants).getPOName(targetClass)")
    default List<T> queryAllForCache() {
        return queryAll();
    }

//    @Cacheable(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)+'_'+#id")
    T queryById(Long id);


    List<T> queryByPO(T t);

    List<T> queryByPros(ParamsMap<String, Object> params);

//    @Cacheable(value = "common",key = "T(com.yg.core.Constants).getPOName(targetClass)+'_page_'+#page.pageNo")
    List<T> queryAllForPage(Page<T> page);

    int save(T t);


    int updateById(T t);
//更新的对象可能属性不全，不建议缓存
/*    @Caching(evict = {
            @CacheEvict(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)+'_'+#t.id"),
            @CacheEvict(value = "common",key = "T(com.yg.core.Constants).getPOName(targetClass)+'_page_'+#page.pageNo"),
            @CacheEvict(value = "common", key = "T(com.yg.core.Constants).getPOName(targetClass)")
    })*/
/*    default T updateByIdForCache(T t) {
        updateById(t);
        return t;
    }*/


}
