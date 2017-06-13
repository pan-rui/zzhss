
package com.yanguan.server;

import org.apache.commons.lang.StringUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.apache.hadoop.hbase.client.Result;
import org.apache.hadoop.hbase.client.ResultScanner;
import org.apache.hadoop.hbase.client.Scan;
import org.apache.hadoop.hbase.client.Table;
import org.apache.hadoop.hbase.filter.PageFilter;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import java.io.IOException;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author [*田园间*]   liaoxuqian@hotmail.com
 * @since version 1.0
 * @datetime 2015-8-3  18:27:59
 */
@Repository
public class HbaseRepository {

    /***********************************************
    |             C O N S T A N T S             |
    ***********************************************/
    private static final Logger logger = LogManager.getLogger(HbaseRepository.class);
    
    /**
     * gps history table description
     */
    private static final String TABLE_NAME_GPS = "YG_GPS";
    private static final byte[] FAMILY_NAME_GPS = Bytes.toBytes("GPS");
    private static final byte[] QUALIFIER_DEV_ID = Bytes.toBytes("DEV_ID");
    private static final byte[] QUALIFIER_GPS_LNG = Bytes.toBytes("GPS_LNG");
    private static final byte[] QUALIFIER_GPS_LAT = Bytes.toBytes("GPS_LAT");
    private static final byte[] QUALIFIER_SPEED = Bytes.toBytes("SPEED");
    private static final byte[] QUALIFIER_DIRECTION = Bytes.toBytes("DIRECTION");
    private static final byte[] QUALIFIER_TIME = Bytes.toBytes("TIME");
    
    /**
     * remind history table description
     */
    private static final String TABLE_NAME_RMD = "YG_RMD";
    private static final byte[] FAMILY_NAME_RMD = Bytes.toBytes("RMD");
    private static final byte[] QUALIFIER_RMD_CODE = Bytes.toBytes("RMD_CODE");
    private static final byte[] QUALIFIER_RMD_GPS_LNG = Bytes.toBytes("RMD_GPS_LNG");
    private static final byte[] QUALIFIER_RMD_GPS_LAT = Bytes.toBytes("RMD_GPS_LAT");
    private static final byte[] QUALIFIER_RMD_TIME = Bytes.toBytes("RMD_TIME");
    
    private static final String ROW_FORMAT = "%0" + 8 + "d";

    /***********************************************
    |    I N S T A N C E   V A R I A B L E S    |
    ***********************************************/
    private Connection hbaseConnection;
    private String quorum;
    private String clientPort;
    private String dfsHost;
    private String dfsPort;
    private String homeDir;

    /***********************************************
    |         C O N S T R U C T O R S           |
     ***********************************************/

    /***********************************************
    |  A C C E S S O R S / M O D I F I E R S    |
     ***********************************************/
    public void setHbaseConnection(Connection hbaseConnection) {
        this.hbaseConnection = hbaseConnection;
    }

    public void setQuorum(String quorum) {
        this.quorum = quorum;
    }

    public void setClientPort(String clientPort) {
        this.clientPort = clientPort;
    }

    public void setDfsHost(String dfsHost) {
        this.dfsHost = dfsHost;
    }

    public void setDfsPort(String dfsPort) {
        this.dfsPort = dfsPort;
    }

    public void setHomeDir(String homeDir) {
        this.homeDir = homeDir;
    }

    /***********************************************
    |               M E T H O D S               |
    ***********************************************/
    /**
     * initialize the hbase connection
     * 
     * @throws Exception 
     */
    public void initialize() throws Exception {
        logger.info("Initializing hbase service...");
        Configuration configuration = HBaseConfiguration.create();
        configuration.set("hbase.zookeeper.quorum", quorum);
        configuration.set("hbase.zookeeper.property.clientPort", clientPort);
        configuration.set("fs.defaultFS", "hdfs://" + dfsHost + ":" + dfsPort);
        configuration.set("hadoop.home.dir", homeDir);
        
        try {
            hbaseConnection = ConnectionFactory.createConnection(configuration);
        } catch (Exception e) {
            logger.error("Initialize hbase connection failed!", e);
            throw e;
        }
        
        logger.info("Initialized hbase service.");
    }
    
    public void desctroy() {
        if (hbaseConnection != null) {
            try {
                hbaseConnection.close();
            } catch (Exception e) {
                logger.error("Close hbase connection failed!", e);
            }
        }
    }
    
    /**
     * query the device identified by {@code did} latest gps
     * 
     * @param did device's id
     * @return
     * @throws
     */
    public Map<String,Object> queryLatestGps(final int did) {
        // DEVICE_ID为1，则在HBase里面的rowkey前缀为00000001，
        // 日期为2015-07-29 22:22:22这一条GPS数据的rowkey则为00000001 + “” + 秒
//        int tableIndex = did / 20000 + 1; // 1--YG_GPS_1   1--YG_GPS_2 ... N--YG_GPS_N
//        final String tableName = TABLE_NAME_GPS + tableIndex;
        final String tableName = TABLE_NAME_GPS;
        
        String rowPrefix = String.format(ROW_FORMAT, did);
        String startRow = rowPrefix + (System.currentTimeMillis() / 1000);
        String stopRow = rowPrefix + (System.currentTimeMillis() / 1000 - 15 * 24 * 60 * 60);
        
        Table table = null;
        ResultScanner scanner = null;
        
        try {
            table = hbaseConnection.getTable(TableName.valueOf(tableName));
            if (table == null) {
                logger.error("Query device's latest gps failed: Hbase table is not exists!");
                return null;
            }
                
            Scan scan = new Scan(Bytes.toBytes(startRow), Bytes.toBytes(stopRow));
            scan.setFilter(new PageFilter(1));
            scan.setReversed(true);
            
            scanner = table.getScanner(scan);
            if (scanner == null) {
                logger.error("Query device's latest gps failed: Hbase table create scanner failed!");
                return null;
            }

            for (Result row = scanner.next(); row != null; row = scanner.next()) {
                Map gps = new HashMap<>();
                byte[] byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_GPS_LNG);
                if (byteVal != null) {
                    gps.put("gpsLng",Bytes.toDouble(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_GPS_LAT);
                if (byteVal != null) {
                    gps.put("gpsLat",Bytes.toDouble(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_SPEED);
                if (byteVal != null) {
                    gps.put("speed",Bytes.toFloat(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_DIRECTION);
                if (byteVal != null) {
                    gps.put("azimuth",Bytes.toFloat(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_TIME);
                if (byteVal != null) {
                    gps.put("gpsTime",getSystime(Bytes.toLong(byteVal)));
                }
                
                return gps;
            }
            
        } catch (Exception e) {
            logger.error("Query device's latest gps failed!device: " + did, e);
        } finally {
            // close ResultScanner 
            if (scanner != null) {
                scanner.close();
            }
            
            // close table
            if (table != null) {
                try {
                    table.close();
                } catch (IOException ex) {
                    logger.error("Close hbase table failed! table name: " + tableName, ex);
                }
            }
        }
        
        return null;
    }
    
    /**
     * query the device identified by {@code did} gps track
     * 
     * @param did device's id
     * @param stTime
     * @param endTime
     * @return
     */
    public List<Map<String,Object>> queryDeviceTrack(final int did, final long stTime, final long endTime)  {
        // DEVICE_ID为1，则在HBase里面的rowkey前缀为00000001，
        // 日期为2015-07-29 22:22:22这一条GPS数据的rowkey则为00000001 + “” + 秒
//        int tableIndex = did / 20000 + 1; // 1--YG_GPS_1   1--YG_GPS_2 ... N--YG_GPS_N
//        String tableName = TABLE_NAME_GPS + tableIndex;
        final String tableName = TABLE_NAME_GPS;
        // if need to check table exists
        String rowPrefix = String.format(ROW_FORMAT, did);
        String startRow = rowPrefix + stTime;
        String stopRow = rowPrefix + endTime;
        List<Map<String,Object>> track = new ArrayList<Map<String,Object>>();
        
        Table table = null;
        ResultScanner scanner = null;
        
        try {
            table = hbaseConnection.getTable(TableName.valueOf(tableName));
            if (table == null) {
                logger.error("Query device's track failed: Hbase table is not exists!");
                return track;
            }
                
            Scan scan = new Scan(Bytes.toBytes(startRow), Bytes.toBytes(stopRow));
//            scan.setReversed(true);
            
            scanner = table.getScanner(scan);

            if (scanner == null) {
                logger.error("Query device's track failed: Hbase table create scanner failed!");
                return track;
            }

            for (Result row = scanner.next(); row != null; row = scanner.next()) {
                Map<String,Object> gps = new HashMap<String,Object>();
                byte[] byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_GPS_LNG);
                if (byteVal != null) {
                    gps.put("gpsLng",Bytes.toDouble(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_GPS_LAT);
                if (byteVal != null) {
                    gps.put("gpsLat",Bytes.toDouble(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_SPEED);
                if (byteVal != null) {
                    gps.put("speed",Bytes.toFloat(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_DIRECTION);
                if (byteVal != null) {
                    gps.put("azimuth",Bytes.toFloat(byteVal));
                }
                
                byteVal = row.getValue(FAMILY_NAME_GPS, QUALIFIER_TIME);
                if (byteVal != null) {
                    gps.put("gpsTime",getSystime(Bytes.toLong(byteVal)));
                }
                
                track.add(gps);
            }
            
        } catch (Exception e) {
            logger.error("Query device's track failed!device: " + did, e);
        } finally {
            // close ResultScanner 
            if (scanner != null) {
                scanner.close();
            }
            
            // close table
            if (table != null) {
                try {
                    table.close();
                } catch (IOException ex) {
                    logger.error("Close hbase table failed! table name: " + tableName, ex);
                }
            }
        }
        
        return track;
    }
    
    /**
     * query the device identified by {@code did} remind history
     *
     * @param did
     * @param stTime
     * @param endTime
     * @return
     */
    public List<Map<String,Object>> queryRmdHistory(final int did, final long stTime, final long endTime) {
        // DEVICE_ID为1，则在HBase里面的rowkey前缀为00000001，
        // 日期为2015-07-29 22:22:22这一条GPS数据的rowkey则为00000001 + “” + 秒
//        int tableIndex = did / 50000 + 1; // 1--YG_RMD_1   1--YG_RMD_2 ... N--YG_RMD_N
        String tableName = TABLE_NAME_RMD;
        // if need to check table exists
        String rowPrefix = String.format(ROW_FORMAT, did);
        // reverse the time
        String startRow = rowPrefix + endTime;
        String stopRow = rowPrefix + stTime;
        List<Map<String,Object>> history = new ArrayList<Map<String,Object>>();

        Table table = null;
        ResultScanner scanner = null;

        try {
            table = hbaseConnection.getTable(TableName.valueOf(tableName));
            if (table == null) {
                logger.error("Query device's remind history failed: Hbase table is not exists!");
                return history;
            }

            Scan scan = new Scan(Bytes.toBytes(startRow), Bytes.toBytes(stopRow));
//            scan.setFilter(new PageFilter(20));
            scan.setReversed(true);

            scanner = table.getScanner(scan);
            if (scanner == null) {
                logger.error("Query device's remind history failed: Hbase table create scanner failed!");
                return history;
            }

            for (Result row = scanner.next(); row != null; row = scanner.next()) {
                Map<String,Object> rmd = new HashMap<String,Object>();
                byte[] byteVal = row.getValue(FAMILY_NAME_RMD, QUALIFIER_DEV_ID);
                if (byteVal != null && !StringUtils.isEmpty(Bytes.toString(byteVal))) {
                    rmd.put("devId",Bytes.toString(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_RMD, QUALIFIER_RMD_CODE);
                if (byteVal != null && !StringUtils.isEmpty(Bytes.toString(byteVal))) {
                    rmd.put("rmdType",Bytes.toString(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_RMD, QUALIFIER_RMD_GPS_LNG);
                if (byteVal != null && !StringUtils.isEmpty(Bytes.toString(byteVal))) {
                    rmd.put("lng",Bytes.toString(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_RMD, QUALIFIER_RMD_GPS_LAT);
                if (byteVal != null && !StringUtils.isEmpty(Bytes.toString(byteVal))) {
                    rmd.put("lat",Bytes.toString(byteVal));
                }

                byteVal = row.getValue(FAMILY_NAME_RMD, QUALIFIER_RMD_TIME);
                if (byteVal != null && !StringUtils.isEmpty(Bytes.toString(byteVal))) {
                    rmd.put("rmdTime",Bytes.toLong(byteVal) + "");
                }

                history.add(rmd);
            }

        } catch (Exception e) {
            logger.error("Query device's remind history failed!device: " + did, e);
        } finally {
            // close ResultScanner 
            if (scanner != null) {
                scanner.close();
            }

            // close table
            if (table != null) {
                try {
                    table.close();
                } catch (IOException ex) {
                    logger.error("Close hbase table failed! table name: " + tableName, ex);
                }
            }
        }

        return history;
    }
    public static String getSystime(long time){
//		long time = System.currentTimeMillis();
		GregorianCalendar gc = new GregorianCalendar();
        gc.setTimeInMillis(time);
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String str1 = format.format(gc.getTime());	
		return str1;
	}
}