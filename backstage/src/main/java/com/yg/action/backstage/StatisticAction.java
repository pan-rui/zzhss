package com.yg.action.backstage;

import com.yg.base.BaseAction;
import com.yg.base.BaseResult;
import com.yg.base.ReturnCode;
import com.yg.util.UploadFile;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * Created by Administrator on 2015/11/11.
 */
@Controller
@RequestMapping("/statistic")
public class StatisticAction extends BaseAction {

    @RequestMapping(value = "export/{tableName}", method = RequestMethod.POST)
    @ResponseBody
    public Object export(HttpServletRequest request, @PathVariable String tableName,String data) {
        File file=null;
        try {
            file=File.createTempFile(tableName+System.currentTimeMillis(),".xls");
            UploadFile.writerFile(data,file.getAbsolutePath());
            return new BaseResult(0, file.getAbsolutePath());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return ReturnCode.FAIL.toString();
    }

    @RequestMapping(value = "download/{tableName}.xls", method = RequestMethod.GET)
    public String download(HttpServletRequest request, HttpServletResponse response, @PathVariable String tableName,String filePath) {
        response.setContentType("application/octet-stream;charset=utf-8");
        Assert.notNull(filePath);
        File file = new File(filePath);
        response.addHeader("Content-Length", file.length()+"");
        response.addHeader("Content-Transfer-Encoding", "binary");
        try {
            if(request.getHeader("user-agent").contains("Trident/"))
                response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filePath, "utf-8"));
            response.getWriter().write(FileUtils.readFileToString(file,"utf-8"));
            file.delete();
            response.getWriter().close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
