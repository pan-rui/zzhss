package com.study;

import com.util.ipParse.IPByteArray;
import com.util.ipParse.IPLocation;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.spi.CalendarDataProvider;

/**
 * Created by panrui on 2016/8/8.
 */
public class Test1 {
    private Map<String, Object> map = new ConcurrentHashMap<>();
    private Map<String, Object> hashMap = new HashMap<>();
    private List<Object> linked = new LinkedList<>();

    public static void main(String[] args) {
        Test1 test1 = new Test1();
        test1.hashMap.put("abc", null);
//        test1.map.put("abc", null);     //抛出异常"java.lang.NullPointerException"
        test1.linked.add(new IPLocation());
        test1.linked.add(new IPLocation());
        test1.linked.add(new IPLocation());
//        TreeSet<Object> treeSet = new TreeSet<>(test1.linked);      //抛出异常"java.lang.ClassCastException: com.util.ipParse.IPLocation cannot be cast to java.lang.Comparable"
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MINUTE, 59);
        calendar.set(Calendar.SECOND, 50);
        long currentTime=System.currentTimeMillis(),calendarMill=calendar.getTimeInMillis(),calendarTimeTime=calendar.getTime().getTime();
        System.out.println("calendar.getTimeInMill---->"+calendarMill);
        System.out.println("calendar.getTime().getTime()----->"+calendarTimeTime);
        System.out.println("System.currentMill---->"+currentTime);
        System.out.println("getTimeInMill-currentMill----->"+(calendarMill-currentTime));
        System.out.println("getTimeTime-currentMill----->"+(calendarTimeTime-currentTime));
        List<String> syncList = Collections.synchronizedList(new ArrayList<String>());
        syncList.remove(0);

    }
}
