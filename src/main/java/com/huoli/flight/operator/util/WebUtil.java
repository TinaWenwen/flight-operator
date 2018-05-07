package com.huoli.flight.operator.util;

import com.alibaba.fastjson.JSON;
import org.springframework.util.CollectionUtils;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.charset.Charset;
import java.util.Iterator;
import java.util.Map;

/**
 * Web工具类
 *
 * @author xuyaguang
 * @dateTime 2015年11月3日 下午2:49
 */
public class WebUtil {

    public static void outPutResult(ServletResponse response, Charset charset, String ContentType, String result) throws IOException {
        response.setContentType(ContentType);
        OutputStream os = response.getOutputStream();
        Writer out = new OutputStreamWriter(os, charset.toString());
        out.write(result);
        out.flush();
        out.close();
        os.flush();
        os.close();
    }

    public static void setCharacterEncoding(ServletRequest request, Charset charset) throws UnsupportedEncodingException {
        request.setCharacterEncoding(charset.toString());
    }

    public static void setCharacterEncoding(ServletResponse response, Charset charset) throws UnsupportedEncodingException {
        response.setCharacterEncoding(charset.toString());
    }

    public static void setCharacterEncoding(ServletRequest request, ServletResponse response, Charset charset) throws UnsupportedEncodingException {
        setCharacterEncoding(request, charset);
        setCharacterEncoding(response, charset);
    }

    public static void outPutJsonResult(ServletResponse response, Charset charset, Object result) throws IOException {
        setCharacterEncoding(response, charset);
        String jsonStr = JSON.toJSONString(result);
        outPutResult(response, charset, "application/json", jsonStr);
    }

    public static String getRemoteHost(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip.equals("0:0:0:0:0:0:0:1") ? "127.0.0.1" : ip;
    }

    public static String getParams(HttpServletRequest request) {
        StringBuilder params = new StringBuilder();
        Map<String, String[]> parameterMap = request.getParameterMap();
        if (!CollectionUtils.isEmpty(parameterMap)) {
            Iterator iterator = parameterMap.entrySet().iterator();
            boolean first = true;
            while (iterator.hasNext()) {
                Map.Entry<String, String[]> entry = (Map.Entry) iterator.next();
                String key = entry.getKey();
                String value = entry.getValue().length > 1 ? entry.getValue().toString() : entry.getValue()[0];
                if (!first) {
                    params.append(",");
                } else {
                    first = false;
                }
                params.append(key).append("=").append(value);
            }
        }
        return params.toString();
    }
}
