package com.yg.util;

import com.yg.core.ParamsMap;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

/**
 * @Description: 生成设备IMIE
 * @Created: 潘锐 (2015-12-17 11:53)
 * $Rev: 759 $
 * $Author: panrui $
 * $Date: 2016-08-15 12:27:43 +0800 (周一, 15 八月 2016) $
 */
public class GenerateIMIE {
    private static Random random = new Random();
    /**
     * IMEI号=【3位固定前缀】+【4位预留号】+【8位随机无重复数字】
     例：618000043256437
     【3位固定前缀】= 618
     【4位预留号】= 0000
     【8位随机无重复数字】= xxxxxxxx （x为随机生成的数字，无重复）
     *注：原则上180000都是预留号。6开头的数字不建议在任何其他同类产品使用，避免出现问题。

     */
    public static void main(String[] args) throws Exception{
        String vender = args[0];    //设备厂家
        int size = Integer.parseInt(args[1]);      //IMIE个数
        String sn_1 = "619";
        String sn_2 = args.length > 2 ? args[2] : "0000";

        String driverClass = "com.mysql.jdbc.Driver";
//        String schema = "mysql";
        String jdbcUrl = "jdbc:mysql://121.201.35.183:3306/yanguan?useUnicode=true&characterEncoding=UTF-8";
        String userId="zhihusan";
        String password = "yg_zhs_Web~!@2013";
        Class.forName(driverClass);
        Connection conn = DriverManager.getConnection(jdbcUrl, userId, password);
        PreparedStatement pstmt=conn.prepareStatement("select Device_Imei FROM YG_DEVICE_INFO");
        ResultSet rs=pstmt.executeQuery();
        Set<String> imesSet = new HashSet<>();
        int count=0;
        int[] result=null;
        while (rs.next()) {
            String imie=rs.getString("Device_Imei");
            imesSet.add(imie);
            count++;
        }
        rs.close();pstmt.close();
        Statement statement=conn.createStatement();
        System.out.println("当前数据库记录数为："+imesSet.size());
        List<Device> deviceList = new ArrayList<>();
        StringBuffer sql = new StringBuffer("insert ignore YG_DEVICE_INFO(Device_Imei,Device_Register,Device_Version,Device_Vender,Install_Code) values ");
        for(int i=0;i<size;i++) {
//            String imie=randomImie(imesSet);
            String imie = String.format("%08d", random.nextInt(99999999));
            if(!imesSet.add(imie)){
                i--;continue;
            }
            Device device = new Device();
            System.out.println("第"+i+"个IMIE号为： "+sn_1+sn_2+imie);
            sql.append("('" + sn_1+sn_2+imie + "','0',"+sn_1+",'" + vender + "','"+sn_1+vender+imie+"')");
            if(i<size-1) sql.append(",");
//            String sql = "insert ignore YG_DEVICE_INFO(Device_Imei,Device_Register,Device_Version,Device_Vender) values('" + sn_1+sn_2+imie + "','0' ,618,'" + vender + "')";
//            pstmt = conn.prepareStatement(sql);
            device.setImei(sn_1+sn_2+imie);
            device.setInstallCode(sn_1+vender+imie);
            device.setVender(vender);
            device.setVersion(sn_1);
            deviceList.add(device);
//            if(l>0) imesSet.add(imie);
//            else i--;
        }
            statement.addBatch(sql.toString());
             result=statement.executeBatch();
        ExportExcelUtil.createExcel(deviceList,"D:\\619Device_Imei.xls",null, ParamsMap.newMap("imei","IMEI").addParams("installCode","安装码").addParams("version","项目名").addParams("vender","设备厂家"),"619IMEI");
            System.out.println("一共插入了 "+result.length+" 条数据！");
        System.out.println("插入后应有记录数："+imesSet.size());
        pstmt=conn.prepareStatement("select count(1) FROM YG_DEVICE_INFO");
        rs=pstmt.executeQuery();
        if(rs.next())
        System.out.println("插入后实际存在记录数：" + rs.getInt(1));
         int res=pstmt.executeUpdate("INSERT IGNORE YG_DEVICE_REF (Device_ID) SELECT Device_ID  FROM YG_DEVICE_INFO WHERE Device_Vender = '"+vender+"'");
        System.out.println("插入到REF表的记录数:\t"+res);
        pstmt.close();
        conn.close();
    }

    public static String randomImie(final Set<String> imieSet) {
        String val = String.format("%08d",random.nextInt(99999999));
        return imieSet.contains(val)?randomImie(imieSet):val;
    }

    static class Device implements Serializable{
        private String imei;
        private String version;
        private String vender;
        private String installCode;

        public String getImei() {
            return imei;
        }

        public void setImei(String imei) {
            this.imei = imei;
        }

        public String getVersion() {
            return version;
        }

        public void setVersion(String version) {
            this.version = version;
        }

        public String getVender() {
            return vender;
        }

        public void setVender(String vender) {
            this.vender = vender;
        }

        public String getInstallCode() {
            return installCode;
        }

        public void setInstallCode(String installCode) {
            this.installCode = installCode;
        }
    }
}
