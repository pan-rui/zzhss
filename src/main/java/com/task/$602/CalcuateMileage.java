package com.task.$602;

import com.alibaba.fastjson.JSON;
import com.util.ExportExcelUtil;
import com.vo.DayShow;
import com.vo.DynamicTime;
import org.springframework.util.StringUtils;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 统计602设备骑行时间,骑行里程,活跃时间
 * Created by panrui on 2016/4/23.
 */
public class CalcuateMileage {

    private static String tablePrefix = "tb_aut_gps_";
    private static SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    private static SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
    private static String driverClass = "com.mysql.jdbc.Driver";
    private static String schema = "yggps";
    //        String jdbcUrl = "jdbc:mysql://120.25.65.82:3306/"+schema+"?useUnicode=true&characterEncoding=UTF-8";
    private static String jdbcUrl = "jdbc:mysql://116.204.68.126:3306/" + schema + "?useUnicode=true&characterEncoding=UTF-8&useCursorFetch=true&autoReconnect=true";
    private static String userId = "root";
    private static String password = "yanguanserver@2014";
    private static CopyOnWriteArraySet validOnMonth=null;//一个月的总有效用户
    private static ConcurrentMap<String,Set<String>> validOnDays=null; //一个月每天的有效用户
    private static AtomicLong ridingOnMonth =new AtomicLong(); //一个月总骑行时间,单位:秒
    private static ConcurrentMap<String,Long> ridingOnDays = null;//一个月每天的骑行时间,单位:秒
    private static AtomicLong ridingMileageOnMonth = new AtomicLong();//一个月的总骑行里程;
    private static ConcurrentMap<String,Double> ridingMileageOnDays = null;//一个月每天的骑行里程
    private static ConcurrentMap<Long,Integer> activeOnDaysMap =null;//活跃度(按上线一定天数的用户数量比计算)
    private static ConcurrentMap<Double,Long> activeGpsMap = null;//活跃时间,48段
    private static ConcurrentMap<Double,Long> activeUserMap = null;//活跃时间,48段
    private static ConcurrentMap<String,ConcurrentMap<String,Object>> devInfos=null;//每个活跃设备的信息
    private static CalcuateMileage calcuateMileage=null;
    private static CountDownLatch latch = new CountDownLatch(1);
    private static String format = "%02d";
    private static CopyOnWriteArrayList<DayShow> dataList = null;
//    private static DecimalFormat df = new DecimalFormat("#.00");;


    private CalcuateMileage() {
        validOnMonth=new CopyOnWriteArraySet<String>();
        validOnDays=new ConcurrentHashMap();
        ridingOnDays = new ConcurrentHashMap();
        ridingMileageOnDays = new ConcurrentHashMap();
        activeGpsMap=new ConcurrentHashMap<Double,Long>();
        activeUserMap=new ConcurrentHashMap<Double,Long>();
        activeOnDaysMap = new ConcurrentHashMap();
        devInfos = new ConcurrentHashMap();
        dataList = new CopyOnWriteArrayList();
/*        for(int i=0;i<31;i++){
            validOnDays.putIfAbsent(i, new ArrayList());
            ridingOnDays.putIfAbsent(i,new ArrayList<Long>());
            ridingMileageOnDays.putIfAbsent(i, new ArrayList<Long>());
            activeOnDaysMap.putIfAbsent(i, 0);
        }*/
/*        for (int i = 0; i < 48; i++)
            activeMap.putIfAbsent(i, 0);*/
    }

    public static synchronized CalcuateMileage getInstanse(){
        return calcuateMileage==null?calcuateMileage=new CalcuateMileage():calcuateMileage;
    }

    /**
     *
     * @param isStored 是否储存到数据库
     * @param days 计算的表名
     */
    public static void calcuateDay(boolean isStored,String... days) {
/*        new Thread() {
            @Override
            public void run() {*/
                try {
                    Connection conn=getConnection();
//                    conn.setAutoCommit(false);
                    PreparedStatement pstmt = null;
                    for (String table : days) {

                        pstmt = conn.prepareStatement("select DEV_IMEI imei,DEV_AUT_TIME gpsTime,DEV_AUT_LAT lat,DEV_AUT_LNG lng FROM " + table + " ORDER BY DEV_IMEI",ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
//                        pstmt = conn.prepareStatement("select DEV_IMEI imei,DEV_AUT_TIME gpsTime,DEV_AUT_LAT lat,DEV_AUT_LNG lng FROM " + table + " ORDER BY DEV_IMEI");
                        pstmt.setFetchSize(Integer.MIN_VALUE);
                        pstmt.setFetchDirection(ResultSet.FETCH_REVERSE);
//                        pstmt.setQueryTimeout(80);
                        long satrtTime=System.currentTimeMillis()/1000;
                        System.out.println(table+":start\t"+sdfTime.format(satrtTime*1000));
                        ResultSet rs = pstmt.executeQuery();
                        long endTime=System.currentTimeMillis()/1000;
                        System.out.println(table+":end\t查询用时(秒)"+(endTime-satrtTime));
//                        conn.commit();
//                        TimeUnit.MILLISECONDS.sleep(10000);
                        String firstImei="";
                        long sTime=0l;
                        String date = table.substring(table.lastIndexOf("_")+1);
                        Set<String> validOnDaysSet=new HashSet<String>();
                        long ridingDays=0l;//骑行时间
                        Double ridingMileage=0d;//骑行里程
                        double sLat=0d;
                        double sLng=0d;
                        String day=table.substring(table.length() - 2);
                        while (rs.next()) {
                            String imei=rs.getString("imei");
                            long timeLong=rs.getTimestamp("gpsTime").getTime();
//                            Date time = new Date(timeLong);
//                            System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(time));
                            double lat = Double.parseDouble(rs.getString("lat"));
                            double lng = Double.parseDouble(rs.getString("lng"));
                            Double distance=0d;//每个间隔的距离;单位:米
                            boolean isSame=imei.equals(firstImei);
/*                            if(!isSame)
                                devInfos.putIfAbsent("imei",new ConcurrentHashMap<String, Object>());*/
                            ConcurrentMap<String, Object> deviceMap=null;
                            ConcurrentMap<String, Object> devMap=null;
                            if(isStored){
                                deviceMap = devInfos.getOrDefault(imei, new ConcurrentHashMap<String, Object>());
                                devMap = (ConcurrentMap<String, Object>) deviceMap.getOrDefault(day, new ConcurrentHashMap<String,Object>());
                            }
                            if(isSame&&sLat>0&&sLng>0)
                                distance=CalcuateRange.GetDistance(sLat,sLng,lat,lng);//单位:米
                            if(distance>300) //超出正常行驶速度,点有误
                                distance=100.0;
                            sLng=lng;
                            sLat=lat;
                            //TODO:每月总骑行里程
                            ridingMileageOnMonth.set((long)(ridingMileageOnMonth.doubleValue()+distance));
                            long riding=0l;
                            double actimeTime = calcuateTimeT(timeLong);
                            if(isSame&&sTime>0){
                                if(Math.abs(timeLong-sTime)>600000l){
                                    //TODO;活跃时间段
                                    activeGpsMap.put(actimeTime,activeGpsMap.getOrDefault(actimeTime,0l)+1);
                                }else{
                                  riding=Math.abs(timeLong-sTime)/1000;
                                //TODO:每月总骑行时间
                                ridingOnMonth.set(ridingOnMonth.longValue()+riding);//单位:秒
                                }
                            }
                            sTime=timeLong;
                            if(isSame) {
                                ridingDays+=riding;
                                ridingMileage+=distance;
                                if(isStored){
                                    devMap.put("time", (Long) devMap.getOrDefault("time", 0l) + riding);
                                    devMap.put("mileage", Math.round(((double) devMap.getOrDefault("mileage", 0d) + distance)*100)/100d);
                                    HashSet<Double> activeSet = (HashSet<Double>) devMap.getOrDefault("timeI", new HashSet<Double>());
                                    boolean isAdded=activeSet.add(actimeTime);
                                    if(isAdded) activeUserMap.put(actimeTime, activeUserMap.getOrDefault(actimeTime, 0l) + 1);
                                    devMap.put("timeI", activeSet);
                                    deviceMap.put(day, devMap);
                                }
                            }else{
                                if(isStored){
                                deviceMap.put("onLineCount",(long)deviceMap.getOrDefault("onLineCount",0l)+1);
                                devInfos.putIfAbsent(imei, deviceMap);
                                }
                                //TODO:每月总有效用户
                                validOnMonth.add(imei);
                                validOnDaysSet.add(imei);
                            }
                            firstImei=imei;
//                            if(sdf.format(time).equals(date))
                        }
                        //处理每天所有用户数据
                        //TODO:每天的有效用户
                        validOnDays.put(date, validOnDaysSet);
                        //TODO:每天的骑行时间
                        ridingOnDays.put(date, ridingDays);
                        //TODO:每天的骑行里程
                        ridingMileageOnDays.put(date,ridingMileage);
                        DayShow dayShow = new DayShow();
                        dayShow.setDate(day);
                        dayShow.setMileage(ridingMileage);
                        dayShow.setRidingTime(ridingDays);
                        dayShow.setValidUser(validOnDaysSet.size());
                        dataList.add(dayShow);
                        rs.close();
                        pstmt.close();
                         System.out.println(days[0]+"处理完成\t用时(秒)"+(System.currentTimeMillis()/1000-endTime));
                    }
                        conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
/*                latch.countDown();
            }
        }.start();*/
    }

    /**
     *
     * @param month     计算的月份(eg:month=201605)
     * @param isStored  是否储存到数据库
     * @param days      计算的表名(eg:tb_aut_gps_20160306)
     */
    public static void calcuateMonth(String month,boolean isStored,String... days) {
            int size=0;
        boolean isDay=days!=null&&days.length>0;
        try {
            if(isDay){
//                String[] tables=new String[]{tablePrefix+"20160306",tablePrefix+"20160313",tablePrefix+"20160327"};
                for(String table:days)
                    calcuateDay(isStored,table);
                size=days.length;
            }else {
                Connection conn = getConnection();
                DatabaseMetaData metaData = null;
                ResultSet rs = null;
                String monthPatten = tablePrefix + (StringUtils.isEmpty(month) ? sdf.format(new Date()).substring(0, 6) : month);
                metaData = conn.getMetaData();
                rs = metaData.getTables(conn.getCatalog(), "root", null, new String[]{"TABLE"});
//                int size = 0;
                while (rs.next()) {
                    String table = rs.getString("TABLE_NAME");
                    if (table.startsWith(monthPatten)) {
                        calcuateDay(isStored,table);
//                    TimeUnit.MILLISECONDS.sleep(5000);
                        size++;
                    }
                }
                rs.close();
                conn.close();
            }
//        try{
//        String[] tables=new String[]{tablePrefix+"20160306",tablePrefix+"20160313",tablePrefix+"20160327"};
//            int size=tables.length;
//            for(int i=0;i<size;i++)
//                calcuateDay(tables[i]);

/*            latch = new CountDownLatch(size);
           boolean success=latch.await(600,TimeUnit.MINUTES);*/
            //处理每月数据
//            if(success&&isStored)
            if(isStored)
                processData(isDay?days[0].substring(days[0].lastIndexOf("_")+1,days[0].length()-2):month);
            //导出到Excel
            exportExcel(isDay?days[0]:month);

        } catch (SQLException e) {
            e.printStackTrace();
/*        } catch (InterruptedException e) {
            e.printStackTrace();*/
        }
    }

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(jdbcUrl, userId, password);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void processData(String month){
        Connection conn = getConnection();
        final Statement[] statements = new Statement[2];
        PreparedStatement pstmt=null;
        ResultSet[] rs=new ResultSet[1];
        ArrayList<String> sqlList = new ArrayList();
        devInfos.forEach((k,v)->{
            //每个设备
            Map<String, Map<String, List>> yearData = new HashMap<String, Map<String, List>>();
            try {
                statements[0] = conn.prepareStatement("");
                rs[0]=statements[0].executeQuery("SELECT d"+month.substring(0,4)+" FROM tb_deviceinfo WHERE Dev_IMEI='"+k+"'");
                if(rs[0].next())
                    yearData= JSON.parseObject(rs[0].getString(1),Map.class);
                rs[0].close();
            statements[0].close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
//                final Map<String, List> monthData = yearData.containsKey(month)?yearData.get(month):new HashMap<String, List>();
                Map<String, List> map= yearData.get(month);
                final Map<String, List> monthData =map==null?new HashMap<String, List>():map ;
            long onLineCount = (long) v.remove("onLineCount");
            activeOnDaysMap.put(onLineCount, activeOnDaysMap.getOrDefault(onLineCount, 0) + 1);
            v.forEach((kk,vvv)->{
                Map<String, Object> vv = (Map<String, Object>) vvv;
                //每天
                ArrayList dayData = monthData.containsKey(kk) ? (ArrayList)monthData.get(kk) : new ArrayList();
                dayData.add(vv.get("time"));
                dayData.add(vv.get("mileage"));
                dayData.add(vv.get("timeI"));
                monthData.put(kk,dayData);
            });
            yearData.put(month, monthData);
            sqlList.add("update tb_deviceinfo set d" + month.substring(0, 4) + "='" + JSON.toJSONString(yearData) + "',onLineDays=" + onLineCount + " where Dev_IMEI='" + k + "'");
//            sql.append("('"+JSON.toJSONString(yearData)+"','"+onLineCount+"'),");
        });
        try {
            statements[1] = conn.createStatement();
            sqlList.forEach(sql -> {
                try { statements[1].addBatch(sql);
                } catch (SQLException e) { e.printStackTrace();   }
            });
            int[] results = statements[1].executeBatch();
            int exSuccess=0;
            for(int ex:results) exSuccess+=ex;
            System.out.println("执行条数为:\t"+exSuccess);
            statements[1].close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void exportExcel(String month) {
        //月总数据
            activeOnDaysMap.forEach((da,cou)->{
                dataList.stream().filter(dayShow -> dayShow.getDate().equals(String.format(format,da))).forEach(dayShow1 -> dayShow1.setActiveUser(cou));
            });
        ExportExcelUtil.createExcel(dataList,"D:\\602设备"+month+"数据统计.xls",null,DayShow.fields(),"602设备"+month+"日常数据统计");
//        ExportExcelUtil.createExcel(dataList,"/opt/data/602设备"+month+"数据统计.xls",null,DayShow.fields(),"602设备"+month+"日常数据统计");
        ArrayList arrayList = new ArrayList();
        activeGpsMap.forEach((k,v)->{
            DynamicTime dynamicTime = new DynamicTime();
            dynamicTime.setTimeI(k);
            dynamicTime.setGpss(v);
            dynamicTime.setUsers(activeUserMap.get(k));
            arrayList.add(dynamicTime);
        });
        ExportExcelUtil.createExcel(arrayList,"D:\\602设备"+month+"活跃时间段统计.xls",null,DynamicTime.fields(),"602设备"+month+"活跃时间段统计");
//        ExportExcelUtil.createExcel(arrayList,"/opt/data/602设备"+month+"活跃时间段统计.xls",null,DynamicTime.fields(),"602设备"+month+"活跃时间段统计");

        System.out.println(month+"-602设备总有效用户数:\t"+validOnMonth.size());
        System.out.println(month+"-602设备总骑行时间(单位:秒):\t"+ridingOnMonth.longValue());
        System.out.println(month+"-602设备总骑行里程(单位:米):\t"+ridingMileageOnMonth.longValue());
    }

    public static double calcuateTimeT(long time) {
        String[] timeArr = sdfTime.format(new Date(time)).split(":");
        double dec=Integer.parseInt(timeArr[1])/30d;
        return Integer.parseInt(timeArr[0])+(dec>1?0.5d:0d);
    }

    static class CalcuateRange {
        private static double EARTH_RADIUS = 6378137;

        private static double rad(double d) {
            return d * Math.PI / 180.0;
        }

        public static double GetDistance(double lat1, double lng1, double lat2, double lng2) {
            double radLat1 = rad(lat1);
            double radLat2 = rad(lat2);
            double a = radLat1 - radLat2;
            double b = rad(lng1) - rad(lng2);
            double s = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(a / 2), 2) +
                    Math.cos(radLat1) * Math.cos(radLat2) * Math.pow(Math.sin(b / 2), 2)));
            s = s * EARTH_RADIUS;
            s = Math.round(s*100)/100d;
            return s;
        }
    }
    public static void main(String[] args) {
        CalcuateMileage calcuateMileage = CalcuateMileage.getInstanse();
//        System.out.println(calcuateMileage.sdf.format(new Date()).substring(0, 6));
//        CalcuateMileage.calcuateMonth("201603",false,"tb_aut_gps_20160306","tb_aut_gps_20160313","tb_aut_gps_20160327");
//        CalcuateMileage.calcuateMonth("201603",true,"tb_aut_gps_20160320");
        CalcuateMileage.calcuateMonth("201603",true);

    }
}
