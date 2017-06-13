package util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.yg.base.ReturnCode;
import com.yg.core.Constants;
import com.yg.function.JoinFunction;
import com.yg.pojo.Admin;
import org.apache.commons.codec.digest.DigestUtils;

import java.lang.reflect.Array;
import java.net.URLDecoder;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2015/9/1.
 */
public class Test {
    public <T> T[] mergeArray(T[] src, T[] src2) {
        T[] newB = (T[]) Array.newInstance(src[0].getClass(), src.length + src2.length);
        System.arraycopy(src, 0, newB, 0, src.length);
        System.arraycopy(src2, 0, newB, src.length, src2.length);
        return newB;
    }

    @org.junit.Test
    public void testMergeArray() {
        String[] str1 = {"a", "b", "c"};
        String[] str2 = {"f", "g"};
        System.out.println(mergeArray(str1, str2));
        for (String str : mergeArray(str1, str2))
            System.out.println(str);
    }

    @org.junit.Test
    public void testReturnCode() {

        System.out.println("".toString());
    }

    @org.junit.Test
    public void testStream() {
        List<String> strs = Arrays.asList("aaa", "bbb", "ccc", "ddd");
        List<Integer> list = strs.stream().map((String str) -> {
            if (str.equals("aaa"))
                return 111;
            else return 222;
        }).collect(Collectors.toList());
        System.out.println(JSONArray.toJSONString(list));
        JoinFunction<String, List<String>> join = (String str, List<String> list1, String s1, String s2) -> {
            return "fdfd";
        };
        System.out.println(join instanceof Function);
    }

    @org.junit.Test
    public void testReduce() {
        List<Integer> list = Arrays.<Integer>asList(1, 5, 7, 2);
        Integer admins = list.stream().map(i -> {
            Admin admin = new Admin();
            admin.setId(i + 0l);
            return admin;
        }).reduce(0, (result, sc) -> {
            return result += Integer.parseInt(sc.getId() + "");
        }, (fd, ma) -> fd - ma);
        System.out.println(admins);
    }

    public static String toHTMLString(String in) {
        StringBuffer out = new StringBuffer();
        for (int i = 0; in != null && i < in.length(); i++) {
            char c = in.charAt(i);
            if (c == '\'')
                out.append("'");
            else if (c == '"')
                out.append("\"");
            else if (c == '<')
                out.append("&lt;");
            else if (c == '>')
                out.append("&gt;");
            else if (c == '&')
                out.append("&amp;");
            else if (c == ' ')
                out.append("");
            else if (c == '\n')
                out.append("<br>");
            else
                out.append(c);
        }
        return out.toString();
    }
    @org.junit.Test
    public void testV() throws  Exception{
        Map<String, String> map = new HashMap<>();
        map.put("abc", "Tabc");
        System.out.println(System.getProperty("file.encoding"));
        System.out.println(ReturnCode.IMAGE_CODE_ERROR.getMsg());
        System.out.println(Constants.ReflectUtil.getFieldValue(map, "abc"));
    }

    public static void main(String[] args) {
        System.out.println(DigestUtils.md5Hex("123456"));
        System.out.println(213d/100);
        DecimalFormat decimalFormat = new DecimalFormat("#.00");
        System.out.println(Double.parseDouble(decimalFormat.format(223.5454 / 100d)));
        Map<String, Object> testMap = new HashMap<>();
        testMap.put("mileage", 32.57d);
        testMap.put("mileage",(double)testMap.get("mileage")+3.28d);
        testMap.put("mileage",(double)testMap.get("mileage")+5.32d);
        System.out.println(JSON.toJSONString(testMap));
        System.out.println(Math.round(6523.987543644*100)/100d);
        System.out.println(URLDecoder.decode("%2F1006_3ed367ec4dbc4a0fad705a9426ca7044"));
        System.out.println(new StringBuffer().toString().contains("a"));

    }
}
