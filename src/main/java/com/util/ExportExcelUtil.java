/**
 * @author xuy
 */


package com.util;

import jxl.Cell;
import jxl.Sheet;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.*;
import jxl.format.VerticalAlignment;
import jxl.read.biff.BiffException;
import jxl.write.*;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.function.Consumer;

public class ExportExcelUtil {

    /**
     * 导出Excel
     * @param list：结果集合
     * @param filePath：指定的路径名
     * @param out：输出流对象 通过response.getOutputStream()传入
     * @param mapFields：导出字段 key:对应实体类字段    value：对应导出表中显示的中文名
     * @param sheetName：工作表名称
     */
    public static void createExcel(List list, String filePath, OutputStream out, Map<String, String> mapFields, String sheetName) {
        sheetName = sheetName != null && !"".equals(sheetName) ? sheetName : "sheet1";
        WritableWorkbook wook = null;//可写的工作薄对象
        Object objClass = null;
        try {
            if (filePath != null && !filePath.equals("")) {
                wook = Workbook.createWorkbook(new File(filePath));//指定导出的目录和文件名 如：D:\\test.xls
            } else {
                wook = Workbook.createWorkbook(out);//jsp页面导出用
            }

            //设置头部字体格式
            WritableFont font = new WritableFont(WritableFont.TIMES, 10, WritableFont.BOLD,
                    false, UnderlineStyle.NO_UNDERLINE, Colour.RED);
            //应用字体
            WritableCellFormat wcfh = new WritableCellFormat(font);
            //设置其他样式
            wcfh.setAlignment(Alignment.CENTRE);//水平对齐
            wcfh.setVerticalAlignment(VerticalAlignment.CENTRE);//垂直对齐
            wcfh.setBorder(Border.ALL, BorderLineStyle.THIN);//边框
            wcfh.setBackground(Colour.YELLOW);//背景色
            wcfh.setWrap(false);//不自动换行

            //设置内容日期格式
            DateFormat df = new DateFormat("yyyy-MM-dd HH:mm:ss");
            //应用日期格式
            WritableCellFormat wcfc = new WritableCellFormat(df);

            wcfc.setAlignment(Alignment.CENTRE);
            wcfc.setVerticalAlignment(VerticalAlignment.CENTRE);//垂直对齐
            wcfc.setBorder(Border.ALL, BorderLineStyle.THIN);//边框
            wcfc.setWrap(false);//不自动换行

            //创建工作表
            WritableSheet sheet = wook.createSheet(sheetName, 0);
            SheetSettings setting = sheet.getSettings();
            setting.setVerticalFreeze(1);//冻结窗口头部

            int columnIndex = 0;  //列索引
            List<String> methodNameList = new ArrayList<String>();
            if (mapFields != null) {
                String key = "";
                Map<String, Method> getMap = null;
                Method method = null;
                //开始导出表格头部
                for (Iterator<String> i = mapFields.keySet().iterator(); i.hasNext(); ) {
                    key = i.next();
                    // 应用wcfh样式创建单元格
                    sheet.addCell(new Label(columnIndex, 0, mapFields.get(key), wcfh));
                    //记录字段的顺序，以便于导出的内容与字段不出现偏移
                    methodNameList.add(key);
                    columnIndex++;
                }
                if (list != null && list.size() > 0) {
                    //导出表格内容
                    for (int i = 0, len = list.size(); i < len; i++) {
                        objClass = list.get(i);
                        getMap = getAllMethod(objClass);//获得对象所有的get方法
                        //按保存的字段顺序导出内容
                        for (int j = 0; j < methodNameList.size(); j++) {
                            //根据key获取对应方法
                            method = getMap.get("GET" + methodNameList.get(j).toString().toUpperCase());
                            if (method != null && method.invoke(objClass, null) != null) {
                                //从对应的get方法得到返回值
                                String value = method.invoke(objClass, null).toString();
                                //应用wcfc样式创建单元格
                                sheet.addCell(new Label(j, i + 1, value, wcfc));
                            } else {
                                //如果没有对应的get方法，则默认将内容设为""
                                sheet.addCell(new Label(j, i + 1, "", wcfc));
                            }

                        }
                    }
                }
                wook.write();
                System.out.println("导出Excel成功！");
            } else {
                throw new Exception("传入参数不合法");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (wook != null) {
                    wook.close();
                }
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    /**
     * 获取类的所有get方法
     * @param obj
     * @return
     */
    public static HashMap<String, Method> getAllMethod(Object obj) throws Exception {
        HashMap<String, Method> map = new HashMap<String, Method>();
        Method[] methods = obj.getClass().getMethods();//得到所有方法
        String methodName = "";
        for (int i = 0; i < methods.length; i++) {
            methodName = methods[i].getName().toUpperCase();//方法名
            if (methodName.startsWith("GET")) {
                map.put(methodName, methods[i]);//添加get方法至map中
            }
        }
        return map;
    }

    public void parseExcelFirst(String filePath, Consumer<jxl.Cell[]> consum) {
        Workbook book = null;
        try {
            File file=new File(filePath);
            if(file.isDirectory()){
                File[] files = file.listFiles();
                for(File file1:files){
                    parseExcelFirst(file1.getAbsolutePath(),consum);
                }
                return;
            }
            book = Workbook.getWorkbook(file);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (BiffException e) {
            e.printStackTrace();
        }
        Sheet sheet = book.getSheet(0);
        if (sheet != null) {
            int lastRowNum = sheet.getRows();
            for (int i = 1; i < lastRowNum; i++) {  //首行行号为0
                jxl.Cell[] cells = sheet.getRow(i);
                try {
                    consum.accept(cells);
                } catch (Exception e) {
                    e.printStackTrace();
                    continue;
                }
/*                if (cells != null && cells.length > 0) {

                    try {
                    } catch (Exception e) {
                        e.printStackTrace();
                        continue;
                    }
                }*/
            }
        }
    }

    public void ExcelPersistent(String jdbcURL,String username,String password,String filePath){
        Connection conn=null;
      final Statement[] stmts=new Statement[1];
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn= DriverManager.getConnection(jdbcURL, username, password);
            stmts[0]=conn.createStatement();
            Consumer<Cell[]> consumer=cells -> {
                try {
//                    System.out.println(cells[0]+"\t"+cells[1]);
                    String sql="INSERT ignore YG_IoT_Card(sim,iccid) VALUES ('"+cells[0].getContents()+"','"+cells[1].getContents()+"')";
//                    String sql="UPDATE YG_DEVICE_INFO SET Device_Sim='"+cells[0]+"' WHERE ICCID='"+cells[1]+"'";
                    stmts[0].addBatch(sql);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            };
            parseExcelFirst(filePath,consumer);
            int[] results=stmts[0].executeBatch();
            System.out.println("执行条数......."+results.length);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                if (stmts[0] != null) stmts[0].close();
                if(conn!=null) conn.close();
            }catch (Exception e){e.printStackTrace();}
        }
    }

    public static void main(String[] args) {
        ExportExcelUtil exportExcelUtil = new ExportExcelUtil();
        try {
/*            exportExcelUtil.parseExcelFirst("E:\\2016.7.26李亮1000张30M物联卡.xls",cells -> {

            });*/
            exportExcelUtil.ExcelPersistent("jdbc:mysql://121.201.35.183:3306/yanguan?useUnicode=true&characterEncoding=UTF-8&useSSL=false","zhihusan","yg_zhs_Web~!@2013","E:\\IoTs\\懂得通信1000.xls");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


