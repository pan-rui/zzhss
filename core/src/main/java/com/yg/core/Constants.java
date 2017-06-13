package com.yg.core;

import org.springframework.cache.CacheManager;
import org.springframework.context.ApplicationContext;
import redis.clients.jedis.JedisPool;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by lenovo on 2014/12/3.
 */
public class Constants {
    public static CacheManager cacheManager;
    public static JedisPool jedisPool;
    public static ApplicationContext applicationContext;
    public static String serverIp;
    public static int serverPort;
    private static Pattern pattern = Pattern.compile("[a-zA-Z0-9]*(_[a-z]{1})\\w*");
    public static String publicKey = "Crypt_Pub_Key";


    //根据身份证号截取出生日期
    public static Date getBirthday(String cardID) throws Exception {
        StringBuffer tempStr = null;
        Date birthday = null;
        if (cardID != null && cardID.trim().length() > 0) {
            if (cardID.trim().length() == 15) {
                tempStr = new StringBuffer(cardID.substring(6, 12));
                tempStr.insert(4, '-');
                tempStr.insert(2, '-');
                tempStr.insert(0, "19");
            } else if (cardID.trim().length() == 18) {
                tempStr = new StringBuffer(cardID.substring(6, 14));
                tempStr.insert(6, '-');
                tempStr.insert(4, '-');
            }
            if (tempStr != null && tempStr.length() > 0) {
//                birthday = DateUtil.convertStringToDate(tempStr.toString(),DateUtil.PATTERN_DATE);
                birthday = new SimpleDateFormat("yyyy-MM-dd").parse(tempStr.toString());
                ;
            }
        }
        return birthday;
    }



    //TODO:缓存
//    public static String UPLOAD_FILE_ROOT_PATH;
//    public static String DOWNLOAD_FILE_ROOT_URL;
//    public static String IMG_WIDTH;

    public static String getPOName(String className) {
        return className.substring(className.lastIndexOf(".") + 2, className.length() - 3);
    }

    public static String getCacheName(String className) {
//        String poName=className.substring(className.lastIndexOf(".")+2,className.length()-3);

        return "common";
    }

    public static Object getSystemValue(String key) {
        return getCacheValue("system", key);
    }

    public static String getSystemStringValue(String key) {
        return getCacheStringValue("system", key);
    }

    public static String getFrontValue(String key) {
        return getCacheStringValue("front", key);
    }

    public static String getCacheStringValue(String cacheName, String key) {
        return cacheManager.getCache(cacheName).get(key, String.class);
    }

    public static <T> T getCacheValue(String cacheName, String key, Class<T> clazz) {
        return cacheManager.getCache(cacheName).get(key, clazz);
    }

    public static Object getCacheValue(String cacheName, Object key) {
        return cacheManager.getCache(cacheName).get(key);
    }

/*    public static <T> T getCacheValue(String cacheName, Object key,Class<T> clazz) {
        return cacheManager.getCache(cacheName).get(key, clazz);
    }*/

    public static void setCacheValue(String cacheName, Object key, Object value) {
        cacheManager.getCache(cacheName).put(key, value);
    }


    /**
     * 利用反射进行操作的一个工具类
     */
    public static class ReflectUtil {
        /**
         * 利用反射获取指定对象的指定属性
         *
         * @param obj       目标对象
         * @param fieldName 目标属性
         * @return 目标属性的值
         */
        public static Object getFieldValue(Object obj, String fieldName) {
            Object result = null;
            if (obj instanceof Map)
                return ((Map) obj).get(fieldName);
            Field field = ReflectUtil.getField(obj, fieldName);
            if (field != null) {
                field.setAccessible(true);
                try {
                    result = field.get(obj);
                } catch (IllegalArgumentException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            return result;
        }

        /**
         * 利用反射获取指定对象里面的指定属性
         *
         * @param obj       目标对象
         * @param fieldName 目标属性
         * @return 目标字段
         */
        public static Field getField(Object obj, String fieldName) {
            Field field = null;
            for (Class<?> clazz = obj.getClass(); clazz != Object.class; clazz = clazz.getSuperclass()) {
                try {
                    field = clazz.getDeclaredField(fieldName);
                    break;
                } catch (NoSuchFieldException e) {
                    //这里不用做处理，子类没有该字段可能对应的父类有，都没有就返回null。
                }
            }
            return field;
        }

        /**
         * 利用反射设置指定对象的指定属性为指定的值
         *
         * @param obj        目标对象
         * @param fieldName  目标属性
         * @param fieldValue 目标值
         */
        public static void setFieldValue(Object obj, String fieldName,
                                         Object fieldValue) {
            Field field = ReflectUtil.getField(obj, fieldName);
            if (field != null) {
                try {
                    field.setAccessible(true);
                    field.set(obj, fieldValue);
                } catch (IllegalArgumentException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                } catch (IllegalAccessException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }

    }

    public static Map<String, Object> poToMap(Object PO) {
        Map<String, Object> resultMap = new LinkedHashMap<>();
        Field[] fields = PO.getClass().getFields();
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                resultMap.put(field.getName(), field.get(PO));
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return resultMap;
    }

    public static Map<String, String> poToMapString(Object PO) {
        Map<String, String> resultMap = new LinkedHashMap<>();
        Field[] fields = PO.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
            try {
                if(field.get(PO)!=null)
                resultMap.put(field.getName(), String.valueOf(field.get(PO)));
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        return resultMap;
    }

    /**
     * 获取类名
     *
     * @param tableName
     * @return
     */
    public static String getClassName(final String tableName) {
        String tableN = new String(tableName.indexOf("_") < 2 ? tableName.substring(tableName.indexOf("_") + 1) : tableName);
        Matcher matcher = pattern.matcher(tableN);
        while (matcher.find()) {
            String str = matcher.group(1);
            tableN = tableN.replaceFirst(str, str.substring(1).toUpperCase());
            matcher = pattern.matcher(tableN);
        }
        return tableN;
//        return tableN.substring(0, 1).toUpperCase() + tableN.substring(1);
    }
    public static int byteArrayToInt(byte[] b) {
        return   b[3] & 0xFF |
                (b[2] & 0xFF) << 8 |
                (b[1] & 0xFF) << 16 |
                (b[0] & 0xFF) << 24;
    }

    public static byte[] intToByteArray(int a) {
        return new byte[] {
                (byte) ((a >> 24) & 0xFF),
                (byte) ((a >> 16) & 0xFF),
                (byte) ((a >> 8) & 0xFF),
                (byte) (a & 0xFF)
        };
    }

    public static void mapToPO(Map map,Object po) {
        Field[] fields = po.getClass().getDeclaredFields();
        for (Field field : fields) {
            field.setAccessible(true);
                map.forEach((k,v)->{
                    if(field.getName().equalsIgnoreCase(String.valueOf(k))) try {
                        Constructor fieldConstructor = field.getType().getConstructor(String.class);
                        field.set(po, fieldConstructor.newInstance(v));
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                        System.err.println("Map转换为对象失败:\t"+po.getClass().getName());
                    } catch (NoSuchMethodException e) {
                        e.printStackTrace();
                    } catch (InstantiationException e) {
                        e.printStackTrace();
                    } catch (InvocationTargetException e) {
                        e.printStackTrace();
                    }
                });
        }
    }

}
