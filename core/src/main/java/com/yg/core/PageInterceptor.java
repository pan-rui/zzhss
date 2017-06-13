package com.yg.core;

import org.apache.ibatis.executor.parameter.ParameterHandler;
import org.apache.ibatis.executor.statement.BaseStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.util.StringUtils;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.function.Consumer;

/**
 * Created by Administrator on 2015/8/31.
 */
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})})
public class PageInterceptor implements Interceptor{
    private Logger logger = LogManager.getLogger(PageInterceptor.class);
/*    @Autowired
    private RedisCacheManager cacheManager;    //TODO:读取系统配置*/
    private String dialect; //数据库类型
//    private String cacheSql; //缓存SQL
    private String pageSqlId;
//    private @Value("#{config['daoPackage']}") String daoPackage;

  /*  @Autowired
    public PageInterceptor(SqlSessionFactory sqlSessionFactory) {
        super(sqlSessionFactory);
    }*/

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        RoutingStatementHandler handler = (RoutingStatementHandler) invocation.getTarget();
        BaseStatementHandler delegate = (BaseStatementHandler) Constants.ReflectUtil.getFieldValue(handler, "delegate");
        BoundSql boundSql = delegate.getBoundSql();
        Object obj = boundSql.getParameterObject();
            logger.info(boundSql.getSql());
            logger.info(DataSourceHolder.getLocalDataSource());
        if (obj instanceof Page<?>) {
            Page<?> page = (Page<?>) obj;
//            fillParams(page, boundSql);
            MappedStatement mappedStatement = (MappedStatement) Constants.ReflectUtil.getFieldValue(delegate, "mappedStatement");
            Connection connection = (Connection) invocation.getArgs()[0];
            //获取当前要执行的sql语句
            String sql = boundSql.getSql();
            this.setTotalRecord(page, mappedStatement, connection);
            String pageSql = this.getPageSql(page, sql);
            Constants.ReflectUtil.setFieldValue(boundSql, "sql", pageSql);
//            Constants.ReflectUtil.setFieldValue(boundSql, "parameterObject", page.getParams());
        }
        return invocation.proceed();
    }

    @Override
    public Object plugin(Object o) {
        return Plugin.wrap(o, this);
    }

    @Override
    public void setProperties(Properties properties) {
        this.dialect = properties.getProperty("dialect");
        this.pageSqlId = properties.getProperty("pageSqlId");
//        this.cacheSql = properties.getProperty("cacheSql");
    }

    private void setTotalRecord(Page<?> page, MappedStatement mappedStatement, Connection connection) {
        BoundSql boundSql = mappedStatement.getBoundSql(page);
        String sql = boundSql.getSql();
        String countSql = "select count(1) from (" + sql + ") as total";
        List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
//        BoundSql countBoundSql = new BoundSql(mappedStatement.getConfiguration(), countSql, parameterMappings, page.getParams());
        BoundSql countBoundSql = new BoundSql(mappedStatement.getConfiguration(), countSql, parameterMappings, page);
        ParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, page, countBoundSql);
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            pstmt = connection.prepareStatement(countSql);
            parameterHandler.setParameters(pstmt);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int totalRecord = rs.getInt(1);
                int pageSize=page.getPageSize();
                if(pageSize==0){
                    Integer size = Constants.getCacheValue("system","pageSize", Integer.class);
                    pageSize =size==null?30:size;
                }
                if (page.getPageSize() == 0) page.setPageSize(pageSize);
                page.setTotalRecord(totalRecord);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (pstmt != null)
                    pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 根据page对象获取对应的分页查询Sql语句，这里只做了两种数据库类型，Mysql和Oracle
     * 其它的数据库都 没有进行分页
     *
     * @param page 分页对象
     * @param sql  原sql语句
     * @return
     */
    private String getPageSql(Page<?> page, String sql) {
        StringBuffer sqlBuffer = new StringBuffer(sql);
        if ("mysql".equalsIgnoreCase(dialect)) {
            return getMysqlPageSql(page, sqlBuffer);
        } else if ("oracle".equalsIgnoreCase(dialect)) {
            return getOraclePageSql(page, sqlBuffer);
        }
        return sqlBuffer.toString();
    }

    /**
     * 获取Mysql数据库的分页查询语句
     *
     * @param page      分页对象
     * @param sqlBuffer 包含原sql语句的StringBuffer对象
     * @return Mysql数据库分页语句
     */
    private String getMysqlPageSql(Page<?> page, StringBuffer sqlBuffer) {
        //计算第一条记录的位置，Mysql中记录的位置是从0开始的。
        int offset = (page.getPageNo() - 1) * page.getPageSize();
        sqlBuffer.append(" limit ").append(offset).append(",").append(page.getPageSize());
        return sqlBuffer.toString();
    }

    /**
     * 获取Oracle数据库的分页查询语句
     *
     * @param page      分页对象
     * @param sqlBuffer 包含原sql语句的StringBuffer对象
     * @return Oracle数据库的分页查询语句
     */
    private String getOraclePageSql(Page<?> page, StringBuffer sqlBuffer) {
        //计算第一条记录的位置，Oracle分页是通过rownum进行的，而rownum是从1开始的
        int offset = (page.getPageNo() - 1) * page.getPageSize() + 1;
        sqlBuffer.insert(0, "select u.*, rownum r from (").append(") u where rownum < ").append(offset + page.getPageSize());
        sqlBuffer.insert(0, "select * from (").append(") where r >= ").append(offset);
        //上面的Sql语句拼接之后大概是这个样子：
        //select * from (select u.*, rownum r from (select * from t_user) u where rownum < 31) where r >= 16
        return sqlBuffer.toString();
    }

    private void fillParams(Page page,BoundSql boundSql) {
        Object obj = page.getParams();
        StringBuffer sqlSB = new StringBuffer(boundSql.getSql() + " where 1=1 ");
        Consumer<Field> fillSql=field ->{
            field.setAccessible(true);
            try {
                Object val=field.get(obj);
                if(!StringUtils.isEmpty(val))
                    sqlSB.append(" and "+field.getName() + "=" + String.valueOf(val));
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        };
        Arrays.<Field>asList(obj.getClass().getDeclaredFields()).forEach(fillSql);
            String sql=sqlSB.toString();
//        if(sql.endsWith("and"))
//            sql = sql.substring(0,sql.length() - 3);
        Constants.ReflectUtil.setFieldValue(boundSql,"sql",sql);
    }

}
