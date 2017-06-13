package com.yg.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by panrui on 2015/8/30.
 */
public class MybatisXml {
    private String poPackage;
    private String pagePackage;
    private String tableName;
    private String daoPackage;
    private String xmlPath;
    private String javaPath;
    private Pattern pattern = Pattern.compile("[a-zA-Z0-9]*(_[a-z]{1})\\w*");

    public MybatisXml(String pagePackage, String tableName) {
        this.pagePackage=pagePackage;
        this.tableName=tableName;
    }

    public MybatisXml(String daoPackage, String pagePackage, String tableName) {
        this.daoPackage = daoPackage;
        this.pagePackage = pagePackage;
        this.tableName = tableName;
    }

    public MybatisXml(String poPackage,String pagePackage, String tableName, String daoPackage, String xmlPath,String javaPath) {
        this.poPackage = poPackage;
        this.pagePackage = pagePackage;
        this.tableName = tableName;
        this.daoPackage = daoPackage;
        this.xmlPath = xmlPath;
        this.javaPath=javaPath;
    }

    public String getJavaPath() {
        return javaPath;
    }

    public void setJavaPath(String javaPath) {
        this.javaPath = javaPath;
    }

    public String getPoPackage() {
        return poPackage;
    }

    public void setPoPackage(String poPackage) {
        this.poPackage = poPackage;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getDaoPackage() {
        return daoPackage;
    }

    public void setDaoPackage(String daoPackage) {
        this.daoPackage = daoPackage;
    }

    public String getXmlPath() {
        return xmlPath;
    }

    public void setXmlPath(String xmlPath) {
        this.xmlPath = xmlPath;
    }

    /**
     * 获取类名
     * @param tableName
     * @return
     */
    public String getClassName(final String tableName) {
        String tableN = new String(tableName);
        Matcher matcher = pattern.matcher(tableN);
        while (matcher.find()) {
            String str = matcher.group(1);
            tableN = tableN.replaceFirst(str, str.substring(1).toUpperCase());
            matcher = pattern.matcher(tableN);
        }
        return tableN.substring(0, 1).toUpperCase() + tableN.substring(1);
    }

    /**
     * 获取 namespace
     * @param tableName
     * @return
     */
    public String getNameSpace(String tableName) {
        String nameSpace=getClassName(tableName);
        return daoPackage + ".I" + nameSpace + "Dao";
    }

    public String getColumnName(String column) {
        String colName = getClassName(column);
        return colName.substring(0,1).toLowerCase()+colName.substring(1);
    }

    public String getSave(String table,String tableName, String keyProperty) {
        StringBuffer sb = new StringBuffer(" \r\n   <insert id=\"save\" parameterType=\""+poPackage+"."+getClassName(tableName)+"\" keyProperty=\""+getColumnName(keyProperty)+"\"\n" +
                "            useGeneratedKeys=\"true\">");
        sb.append("        insert into\n" +table+
                "        (\n" +
                "        <include refid=\""+tableName+"_K\"/>\n" +
                "        ) values(\n" +
                "        <include refid=\""+tableName+"_V\"/>\n" +
                "        )\n" +
                "    </insert>");
        return sb.toString();
    }

    public String getUpdateById(String table, String tableName, String keyProperty) {
        StringBuffer sb=new StringBuffer(" \r\n   <update id=\"updateById\" parameterType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        update "+table+"\n" +
                "        <include refid=\""+tableName+"_U\"></include>\n" +
                "        where "+keyProperty+"=#{"+getColumnName(keyProperty)+"}\n" +
                "    </update>");
        return sb.toString();
    }

    public String getQueryById(String table,String tableName,String keyProperty) {
        StringBuffer sb=new StringBuffer("  \r\n  <select id=\"queryById\" parameterType=\"long\" resultType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        select * from "+table+" where "+keyProperty+"=#{"+getColumnName(keyProperty)+"}\n" +
                "    </select>");
        return sb.toString();
    }

    public String getQueryByPO(String table, String tableName) {
        StringBuffer sb = new StringBuffer();
        sb.append(" \r\n   <select id=\"queryByPO\" parameterType=\""+poPackage+"."+getClassName(tableName)+"\" resultType=\""+poPackage+"."+getClassName(tableName)+"\">");
        sb.append("\r\n select * from ").append(table);
        sb.append("\r\n  <include refid=\"" + tableName + "_C\"></include>").append("\r\n</select>");
        return sb.toString();
    }

    public String getQueryByPros(String table, String tableName) {
        StringBuffer sb = new StringBuffer("    <select id=\"queryByPros\" parameterType=\"map\" resultType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        select * FROM "+table+"\n" +
                "        <trim prefix=\"where\" prefixOverrides=\"or | and\">\n" +
                "            <foreach collection=\"params\" item=\"item\" index=\"key\" separator=\" and \">\n" +
                "                <if test=\"null != item\">${key}=#{item}</if>\n" +
                "            </foreach>\n" +
                "        </trim>\n" +
                "    </select>");
        return sb.toString();
    }

    public String getQueryAll(String table, String tableName) {
        StringBuffer sb=new StringBuffer("  \r\n  <select id=\"queryAll\" resultType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        select * from "+table +
                "   \r\n </select>");
        return sb.toString();
    }
    public String getDelById(String table, String tableName,String keyProperty) {
        StringBuffer sb=new StringBuffer("    <delete id=\"deleteById\" parameterType=\"long\">\n" +
                "        delete from "+table+" where "+keyProperty+"=#{"+getColumnName(keyProperty)+"}\n" +
                "    </delete>");
        return sb.toString();
    }

    public String getDelByPO(String table,String tableName) {
        StringBuffer sb=new StringBuffer("    <delete id=\"deleteByPO\" parameterType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        delete from "+table).append("\r\n  <include refid=\"" + tableName + "_C\"></include>");
                sb.append(" \r\n   </delete>");
        return sb.toString();
    }

    public String getQueryForPage(String table, String tableName) {
        StringBuffer sb = new StringBuffer();
        sb.append("<select id=\"queryForPage\" parameterType=\""+pagePackage+"\" resultType=\"" + poPackage + "." + getClassName(tableName) + "\">");
        sb.append("\r\n select * from ").append(table);
        sb.append("\r\n <include refid=\"" + tableName + "_C\"></include>").append("\r\n</select>");
        return sb.toString();
    }

    public String getQueryForPageM(String table, String tableName) {
        return "    <select id=\"queryForPage\" parameterType=\"map\" resultType=\""+poPackage+"."+getClassName(tableName)+"\">\n" +
                "        select * FROM "+table+"\n" +
                "        <trim prefix=\"where\" prefixOverrides=\"or | and\">\n" +
                "            <foreach collection=\"params\" item=\"item\" index=\"key\" separator=\" and \">\n" +
                "                <if test=\"null != item\">\n" +
                "                    <choose>\n" +
                "                        <when test='key == \"createTime\" or key == \"ctime\"'>\n" +
                "                            ${key} LIKE '${item}%'\n" +
                "                        </when>\n" +
                "                        <otherwise>\n" +
                "                            ${key}='${item}' or ${key} IN (${item})\n" +
                "                        </otherwise>\n" +
                "                    </choose>\n" +
                "                </if>\n" +
                "            </foreach>\n" +
                "        </trim>\n" +
            "           <if test=\"orderMap != null\">\n"+
                "        <trim prefix=\"order by\" prefixOverrides=\",\">\n" +
                "            <foreach collection=\"orderMap\" item=\"item\" index=\"key\" separator=\",\">\n" +
                "                <if test=\"null != item\">${key} ${item}</if>\n" +
                "            </foreach>\n" +
                "        </trim>\n"+
                "       </if>\n"+
                "    </select>";
    }
    public static void main(String[] args) {
        //TODO:待添加参数
        String driverClass = "com.mysql.jdbc.Driver";
        String schema = "yg";
//        String jdbcUrl = "jdbc:mysql://120.25.65.82:3306/"+schema+"?useUnicode=true&characterEncoding=UTF-8";
        String jdbcUrl = "jdbc:mysql://121.201.35.183:3306/"+schema+"?useUnicode=true&characterEncoding=UTF-8&useSSL=false";
        String userId="zhihusan";
        String password = "yg_zhs_Web~!@2013";
        MybatisXml mybatisXml = new MybatisXml("com.yg.pojo","com.yg.core.Page", "t_sale", "com.yg.dao", "mapping","dao");//TODO:可指定单个Table
        StringBuffer sbTab = new StringBuffer();
        try {
            Class.forName(driverClass);
            Connection conn = DriverManager.getConnection(jdbcUrl, userId, password);
            DatabaseMetaData metaData=conn.getMetaData();
            ResultSet rs=null;
            if(mybatisXml.tableName==null)
             rs= metaData.getTables(conn.getCatalog(), "root", null, new String[]{"TABLE"});
            else
                rs= metaData.getTables(conn.getCatalog(), "root", mybatisXml.tableName, new String[]{"TABLE"});
            int tableCount=0;
            while (rs.next()) {
                String table = rs.getString("TABLE_NAME");
                System.out.println("第" + ++tableCount + "张表,表名为" + table);
//                System.out.println(rs.getString("TABLE_TYPE"));

//                ResultSet tableRs = metaData.getTables(conn.getCatalog(), "root", table, new String[]{"TABLE"});
                ResultSet tableRs = metaData.getColumns(conn.getCatalog(), "root", table, null);
//                ResultSetMetaData rsm = tableRs.getMetaData();
/*                for (int i = 1; i <= rsm.getColumnCount(); i++) {
                    String columnName = MybatisXml.getColumnName(rsm.getColumnName(i));
                    System.out.println("列名"+rsm.getColumnName(i));
                }*/
                String tableName=table;
                if(table.indexOf("_")<2)
                    tableName = table.substring(table.indexOf("_") + 1);
                String poName=mybatisXml.getClassName(tableName);
                sbTab.append("\r\n<table tableName=\""+table+"\" schema=\""+schema+"\" domainObjectName=\""+poName+"\">\n" +
                        "        <property name=\"useActualColumnNames\" value=\"true\"/>\r\n</table>");//TODO:驼峰命名

                StringBuffer ksb = new StringBuffer("<sql id=\""+tableName+"_K\">"+"\r\n<trim suffix=\"\" suffixOverrides=\",\">");
                StringBuffer vsb = new StringBuffer("<sql id=\""+tableName+"_V\">"+" \r\n  <trim suffix=\"\" suffixOverrides=\",\">");
                StringBuffer usb = new StringBuffer("<sql id=\""+tableName+"_U\">"+" \r\n  <trim prefix=\"SET\" suffixOverrides=\",\">");
                StringBuffer csb = new StringBuffer("<sql id=\""+tableName+"_C\">"+" \r\n  <trim prefix=\"WHERE\" prefixOverrides=\"or | and\">");
                String suffix="    \r\n    </trim>\r\n    </sql>";
                String id="";
                for (int i = 1; tableRs.next(); i++) {
                    String column=tableRs.getString("COLUMN_NAME");

//                    System.out.println(tableRs.getString("TYPE_NAME")+"\t"+tableRs.getInt("COLUMN_SIZE")+"\t"+tableRs.getInt("DATA_TYPE"));

                    if(i==1)
                        id=column;
                    String pColumn=mybatisXml.getColumnName(column);
                    ksb.append("\r\n<if test=\""+pColumn+" != null\">"+column+",</if>");
                    vsb.append("\r\n<if test=\""+pColumn+" != null\">#{"+pColumn+"},</if>");
                    csb.append("\r\n<if test=\""+pColumn+" != null\">and "+column+"=#{"+pColumn+"} </if>");

                    if(i!=1){
                        usb.append("\r\n<if test=\""+pColumn+" != null\">"+column+"=#{"+pColumn+"},</if>");
                    }
                }
                ksb.append(suffix);
                vsb.append(suffix);
                usb.append(suffix);
                csb.append(suffix);
//                File file = new File("./src/" + mybatisXml.xmlPath.replace(".", "/") + "/" + poName+".xml");
                File xmlFile = new File("./core/src/main/resources/" + mybatisXml.xmlPath.replace(".", "/") + "/" + poName+".xml");
//                File javaFile = new File("./core/src/main/resources/" + mybatisXml.javaPath.replace(".", "/") + "/I" + poName+"Dao.java");
                File javaImplFile = new File("./core/src/main/resources/" + mybatisXml.javaPath.replace(".", "/") + "/impl/" + poName+"Dao.java");
                if(!xmlFile.getParentFile().exists()) xmlFile.getParentFile().mkdirs();
//                if(!javaFile.getParentFile().exists()) javaFile.getParentFile().mkdirs();
                if(!javaImplFile.getParentFile().exists()) javaImplFile.getParentFile().mkdirs();

                FileWriter fos=new FileWriter(xmlFile);//XML文件生成
                fos.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                        "<!DOCTYPE mapper PUBLIC \"-//mybatis.org//DTD Mapper 3.0//EN\"\n" +
                        "        \"http://mybatis.org/dtd/mybatis-3-mapper.dtd\">\n" +
//                        "<mapper namespace=\""+mybatisXml.getNameSpace(tableName)+"\">");
                        "<mapper namespace=\""+poName+"\">");
                fos.write("\r\n"+ksb.toString());
                fos.write("\r\n"+vsb.toString());
                fos.write("\r\n"+usb.toString());
                fos.write("\r\n"+csb.toString());
                fos.write("\r\n"+mybatisXml.getSave(table, tableName, id));
                fos.write("\r\n"+mybatisXml.getQueryById(table, tableName, id));
                fos.write("\r\n"+mybatisXml.getQueryAll(table, tableName));
                fos.write("\r\n"+mybatisXml.getQueryByPO(table, tableName));
                fos.write("\r\n"+mybatisXml.getQueryByPros(table, tableName));
                fos.write("\r\n"+mybatisXml.getQueryForPageM(table, tableName));
                fos.write("\r\n"+mybatisXml.getUpdateById(table, tableName, id));
                fos.write("\r\n"+mybatisXml.getDelById(table, tableName, id));
                fos.write("\r\n"+mybatisXml.getDelByPO(table, tableName));
                fos.write("\r\n</mapper>");
                fos.flush();
                fos.close();

//                FileWriter javaOS = new FileWriter(javaFile);//DAO接口生成
/*                javaOS.write("\r\npackage " + mybatisXml.daoPackage + ";");//package com.yg.dao;
                javaOS.write("\r\nimport " + mybatisXml.poPackage + "." + poName + ";");//import com.yg.pojo.Banner;
                javaOS.write("\r\npublic interface I" + poName + "Dao extends IBaseDao<" + poName + "> {");//public interface IBannerDao extends IBaseDao<Banner> {
                javaOS.write("\r\n}");//}
                javaOS.flush();
                javaOS.close();*/

                FileWriter javaImplOS = new FileWriter(javaImplFile);//DAO接口实现生成
                javaImplOS.write("\r\npackage " + mybatisXml.daoPackage + ".impl;");//package com.yg.dao.impl;
//                javaImplOS.write("\r\nimport " + mybatisXml.daoPackage + ".I" + poName + "Dao;");//import com.yg.dao.IBannerDao;
                javaImplOS.write("\r\nimport " + mybatisXml.poPackage + "."+poName+";");//import com.yg.pojo.Banner;
//                javaImplOS.write("\r\nimport org.apache.ibatis.session.SqlSessionFactory;");//import org.apache.ibatis.session.SqlSessionFactory;
                javaImplOS.write("\r\nimport org.mybatis.spring.SqlSessionTemplate;");//import org.mybatis.spring.SqlSessionTemplate;;
                javaImplOS.write("\r\nimport org.springframework.beans.factory.annotation.Autowired;");//import org.springframework.beans.factory.annotation.Autowired;
                javaImplOS.write("\r\nimport org.springframework.stereotype.Repository;");//import org.springframework.stereotype.Repository;
                javaImplOS.write("\r\n@Repository");//@Repository
//                javaImplOS.write("\r\npublic class "+poName+"DaoImpl extends BaseDao<"+poName+"> implements I"+poName+"Dao {");//public class BannerDaoImpl extends BaseDao<Banner> implements IBannerDao{
                javaImplOS.write("\r\npublic class "+poName+"Dao extends BaseDao<"+poName+">{");//public class BannerDao extends BaseDao<Banner> implements IBannerDao{
                javaImplOS.write("\r\n    @Autowired");//    @Autowired
//                javaImplOS.write("\r\n    public "+poName+"DaoImpl(SqlSessionFactory sqlSessionFactory) {");//    public BannerDaoImpl(SqlSessionFactory sqlSessionFactory) {
                javaImplOS.write("\r\n    public "+poName+"Dao(SqlSessionTemplate sqlSessionTemplate) {");//    public BannerDaoImpl(SqlSessionTemplate sqlSessionTemplate) {
//                javaImplOS.write("\r\n        super(sqlSessionFactory);");//        super(sqlSessionFactory);
                javaImplOS.write("\r\n        this.sqlSessionTemplate=sqlSessionTemplate;");//        this.sqlSessionTemplate=sqlSessionTemplate;
                javaImplOS.write("\r\n    }");//    }
                javaImplOS.write("\r\n}");//}
                javaImplOS.flush();
                javaImplOS.close();

            }
            System.out.println(sbTab.toString());

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("加载驱动失败。。。..");
        }
    }
}
