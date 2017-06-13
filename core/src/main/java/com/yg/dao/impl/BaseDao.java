package com.yg.dao.impl;

import com.yg.core.DataSource;
import com.yg.core.DataSourceHolder;
import com.yg.core.Page;
import com.yg.core.ParamsMap;
import com.yg.dao.IBaseDao;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/9/6.
 */
@CacheConfig(cacheNames = "front", cacheResolver = "baseService")
public class BaseDao<T> implements IBaseDao<T> {
    protected String className = "";
    public SqlSessionTemplate sqlSessionTemplate;
    public String getClassName() {
        return className;
    }
    public BaseDao() {
//        sqlSessionTemplate(sqlSessionFactory);
//        Class clazz = ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments();
        Type type = getClass().getGenericSuperclass();
        Class clazz = null;
        if (type instanceof ParameterizedType) {
            clazz = (Class) ((ParameterizedType) type).getActualTypeArguments()[0];
            className = clazz.getSimpleName();
        } else {
            String namee = ((Class) type).getSimpleName();
            className = namee.substring(0, namee.indexOf("Dao") == -1 ? namee.length() : namee.indexOf("Dao"));
            System.out.println("*****************************************\t" + className);
        }

/*        Annotation annotation = getClass().getSuperclass().getAnnotation(CacheConfig.class);
        System.out.println(annotation);
        try {
            System.out.println(((String [])annotation.getClass().getMethod("cacheNames", null).invoke(annotation,null))[0]);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }*/
//        System.out.println("*****************************************\t" + className);
    }

    public Connection getConnection() {
        return sqlSessionTemplate.getConnection();
    }


    @Override
    @Caching(evict = {
            @CacheEvict(key = "target.className+'_'+T(java.lang.String).valueOf(#id)"),
            @CacheEvict(key = "target.className")
//            @CacheEvict(key = "target.className+'_page_'+#page.pageNo")
    })
    @DataSource(DataSourceHolder.DBType.slave1)
    public int deleteById(Long id) {
        return sqlSessionTemplate.delete(className + ".deleteById", id);
    }

    @Override
    @Caching(evict = {
            @CacheEvict(key = "target.className")
//            @CacheEvict(key = "target.className+'_page_'+#page.pageNo")
    })
    @DataSource(DataSourceHolder.DBType.slave1)
    public int deleteByPO(T t) {
        return sqlSessionTemplate.delete(className + ".deleteByPO", t);
    }

    @Override
    @DataSource
    @CachePut(key = "target.className")
    public List<T> queryAll() {
        return sqlSessionTemplate.selectList(className + ".queryAll");
    }

    @Override
    @Cacheable(key = "target.className+'_'+T(java.lang.String).valueOf(#id)")
    @DataSource
    public T queryById(Long id) {
        return sqlSessionTemplate.selectOne(className + ".queryById", id);
    }

    @Override
    @DataSource
    public List<T> queryByPO(T t) {
        return sqlSessionTemplate.selectList(className + ".queryByPO", t);
    }

    @Override
    @DataSource
    public List<T> queryByPros(ParamsMap<String, Object> params) {
        HashMap<String, Object> para = new HashMap();
        para.put("params", params);
        return sqlSessionTemplate.selectList(className + ".queryByPros", para);
    }

    @Override
    @Cacheable(value = "front",key = "target.className+'_page_'+#page.pageNo")
    @DataSource
    public List<T> queryAllForPage(Page<T> page) {
        return queryForPage(page);
    }
    @DataSource
    public List<T> queryForPage(Page<T> page) {
        return sqlSessionTemplate.selectList(className + ".queryForPage", page);
    }


    @Override
    @CacheEvict(key = "target.className")
    @DataSource(DataSourceHolder.DBType.slave1)
    public int save(T t) {
        return sqlSessionTemplate.insert(className + ".save",t);
    }

    @Override
    @CacheEvict(key = "target.className+'_'+#t.id")
    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateById(T t) {
        return sqlSessionTemplate.update(className + ".updateById", t);
    }

    @Caching(evict = {
            //            @CacheEvict(key = "target.className+'_page_'+#page.pageNo")
            @CacheEvict(key = "target.className+'_'+#t.id"),
            @CacheEvict(key = "target.className")
    })
    @DataSource(DataSourceHolder.DBType.slave1)
    public int updateByIdForCache(T t) {
        return updateById(t);
    }

    @Cacheable(key = "target.className")
    @DataSource
    public List<T> queryAllForCache() {
        return queryAll();
    }

    @CacheEvict(key = "target.className")
    @CachePut(key="target.className+'_'+#t.id")
    @DataSource(DataSourceHolder.DBType.slave1)
    public T saveOnCache(T t) {
        save(t);
        return t;
    }

    @Cacheable(value = "backstage")
    @DataSource
    public List<Map<String, String>> queryColumnInfo(ParamsMap<String,Object> params) {
        return sqlSessionTemplate.selectList("Admin.columnInfo", params);
    }

}
