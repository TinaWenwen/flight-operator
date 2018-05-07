package com.huoli.flight.operator.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RequestContext {

    private final static ThreadLocal<HttpServletRequest> requestThreadLocal = new ThreadLocal<>();
    private final static ThreadLocal<HttpServletResponse> responseThreadLocal = new ThreadLocal<>();

    public static void init(HttpServletRequest req, HttpServletResponse res) {
        requestThreadLocal.set(req);
        responseThreadLocal.set(res);
    }

    public static void remove() {
        requestThreadLocal.remove();
        responseThreadLocal.remove();
    }

    public static HttpServletRequest getRequest() {
        return requestThreadLocal.get();
    }

    public static HttpServletResponse getResponse() {
        return responseThreadLocal.get();
    }

}
