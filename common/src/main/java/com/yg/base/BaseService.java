package com.yg.base;

import com.yg.core.Constants;
import com.yg.core.ParamsMap;
import com.yg.dao.impl.AdminDao;
import com.yg.dao.impl.BaseDao;
import com.yg.pojo.SystemDict;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.validator.HibernateValidator;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.Cache;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.interceptor.CacheOperation;
import org.springframework.cache.interceptor.CacheOperationInvocationContext;
import org.springframework.cache.interceptor.CacheResolver;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.serializer.JdkSerializationRedisSerializer;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.function.Consumer;

/**
 * Created by lenovo on 2014/12/6.
 */
@Service
public class BaseService implements Base, ApplicationContextAware, InitializingBean, CacheResolver {
//    protected javax.validation.Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
    protected javax.validation.Validator validator = Validation.byProvider(HibernateValidator.class).configure().buildValidatorFactory().getValidator();
    private Logger logger = LogManager.getLogger(BaseService.class);
    public Map<String, List<String>> initDataMap = new HashMap<>();
//    public SpelExpressionParser expressionParser = new SpelExpressionParser();
    protected ApplicationContext applicationContext;
    @Autowired
    protected RedisCacheManager cacheManager;
    @Autowired
    protected JedisPool jedisPool;
    @Value("#{initData['systemData']}")
    private String systemData;
    @Value("#{initData['frontData']}")
    private String frontData;
    @Value("#{initData['backstageData']}")
    private String backstageData;
    @Value("#{config['serverIp']}")
    private String serverIp;
    @Value("#{config['serverPort']}")
    private String serverPort;
    @Autowired
    public JdkSerializationRedisSerializer jdkRedisSerializer;
    @Autowired
    public AdminDao adminDao;

    public BaseService() {
//        super(sqlSessionFactory);
//        Class clazz = ((ParameterizedType)getClass().getGenericSuperclass()).getActualTypeArguments()
/*        Type type = getClass().getGenericSuperclass();
        Class clazz = null;
        if (type instanceof ParameterizedType) {
            clazz = (Class) ((ParameterizedType) type).getActualTypeArguments()[0];
            className = clazz.getSimpleName();
        } else {
            String namee = ((Class) type).getSimpleName();
            className = namee.substring(0, namee.indexOf("Service")==-1?namee.length():namee.indexOf("Service"));
        }*/
//           System.out.println("***********\t"+className);
    }

    public <E> BaseResult validAndReturn(E t) {
        Set<ConstraintViolation<E>> errs = validator.validate(t);
        if (errs.size() > 0) {
            StringBuffer sb = new StringBuffer();
            for (ConstraintViolation<E> cons : errs)
                sb.append(cons.getPropertyPath() + ":" + cons.getInvalidValue() + "===>" + cons.getMessage() + "\r\n");
            return new BaseResult(1,sb.toString());
        } else return new BaseResult(ReturnCode.OK);
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        Constants.cacheManager = this.cacheManager;
        Constants.jedisPool = this.jedisPool;
        Constants.applicationContext = this.applicationContext;
        Constants.serverIp = serverIp;
        Constants.serverPort = Integer.parseInt(serverPort);
//        if(jdkRedisSerializer==null) jdkRedisSerializer = new JdkSerializationRedisSerializer();
        //TODO:将系统数据初始化到缓存
        //t_system_paramet
        //t_system_front
        initSystemData();
    }

    public Jedis getJedis() {
        return this.jedisPool.getResource();
    }

    public Object getCacheOfValue(String cacheName, Object key) {
        return cacheManager.getCache(cacheName).get(key).get();
    }

    public <T> T getCacheOfValue(String cacheName, Object key, Class<T> clazz) {
        return cacheManager.getCache(cacheName).get(key, clazz);
    }

    public void setCacheOfValue(String cacheName, Object key, Object value) {
        cacheManager.getCache(cacheName).put(key, value);
    }

    public <T> T getSystemValue(String key, Class<T> clazz) {
        T obj = Constants.getCacheValue("system", key, clazz);
        if (Objects.isNull(obj)) {
//            initSystemData();
            BaseDao dao = (BaseDao) applicationContext.getBean(StringUtils.uncapitalize(key) + "Dao");
          obj= (T) dao.queryAllForCache();
//            obj = Constants.getCacheValue("system", key, clazz);
        }
        return obj;
    }

    @CacheEvict(value = {"front","system","backstage","common"},cacheNames = {"front","system","backstage","common"},allEntries = true)
    public void clearAllCache() {
        logger.info("清除所有缓存....");
    }

    public void initSystemData() {
/*        initDataMap.put("system", Collections.<String>emptyList());
        initDataMap.put("common", Collections.<String>emptyList());
        initDataMap.put("backstage", Collections.<String>emptyList());
        initDataMap.put("front", Collections.<String>emptyList());*/
        if (!StringUtils.isEmpty(systemData)) {
            String[] initDatas = systemData.split(",");
            List<String> inits = Arrays.asList(initDatas);
            initDataMap.put("system", inits);
            Consumer<String> in = poName -> {
                BaseDao dao = (BaseDao) applicationContext.getBean(StringUtils.uncapitalize(poName) + "Dao");
                List list = dao.queryAll();//
                if ("SystemDict".equals(poName)) {
                    ((List<SystemDict>) list).forEach((sd) -> setCacheOfValue("system", sd.getCode(), sd.getValue()));
                } else if ("Para".equals(poName)) {
//                    ((List<Para>) list).forEach((sd) -> setCacheOfValue("system", sd.getParaKey(), sd.getParaValue()));
                }
            };
            inits.forEach(in);
        }
        if (!StringUtils.isEmpty(frontData))
            initDataMap.put("front", Arrays.asList(frontData.split(",")));
        if (!StringUtils.isEmpty(backstageData))
            initDataMap.put("backstage", Arrays.asList(backstageData.split(",")));
    }

    @Override
    public Collection<? extends Cache> resolveCaches(CacheOperationInvocationContext<?> cacheOperationInvocationContext) {
//        List<String> cacheNames = new ArrayList<>(cacheManager.getCacheNames());
        CacheOperation operation = (CacheOperation) cacheOperationInvocationContext.getOperation();
        Object target = cacheOperationInvocationContext.getTarget();
        String className = (String) Constants.ReflectUtil.getFieldValue(target, "className");
//        String key = String.valueOf(expressionParser.parseExpression(operation.getKey()).getValue());
//        if(key.matches(className+"_page\\d+"))
        String methodName = cacheOperationInvocationContext.getMethod().getName();
        Jedis jedis = getJedis();
        if (methodName.matches("(^update\\w+Cache$)|(^delete\\w+)|(saveOnCache)"))
            jedis.keys("*" + className + "_page_*").forEach(str ->cacheManager.getCache("front").evict(className + "_page" + str.substring(str.lastIndexOf("_"))));
        jedis.close();
//        jedis.keys(className + "_page*").stream().forEachOrdered();
        for (String cacheName : initDataMap.keySet()) {
            if (initDataMap.get(cacheName).contains(className))
                return Arrays.<Cache>asList(cacheManager.getCache(cacheName));
        }
//        cacheManager.getCache("system").evict();
        Set<String> cacheNames = operation.getCacheNames();
        return Arrays.<Cache>asList(cacheManager.getCache(cacheNames.stream().findFirst().get()));
    }

//    @Cacheable(value = "system")
    public String getPoName(final String tableName){
        return Constants.getClassName(tableName);
    }

    public String queryColumnInfo(ParamsMap paramsMap) {
        Map<String, String> commentMap=(Map<String,String>)adminDao.queryColumnInfo(paramsMap).get(0);
        String comment=commentMap.get("column_comment");
        return comment.substring(comment.indexOf("{"));
    }
}
