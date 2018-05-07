package com.huoli.flight.operator.util;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Map;

public class MessageContext {

    private static ThreadLocal<Map<Integer, List<MessageInfo>>> messages = ThreadLocal.withInitial(() -> Maps.newHashMap());

    public static void remove() {
        messages.remove();
    }

    public static boolean hasErrors() {
        return !CollectionUtils.isEmpty(getErrors());
    }

    public static boolean hasMessages() {
        return !CollectionUtils.isEmpty(getMessages());
    }

    public static List<MessageInfo> getErrors() {
        return messages.get().get(Constants.RESULT_CODE_FAILED);
    }

    public static List<MessageInfo> getMessages() {
        return messages.get().get(Constants.RESULT_CODE_SUCCEED);
    }

    private static void addMessage(Integer code, String message) {
        MessageInfo info = new MessageInfo(code, message);
        List<MessageInfo> _messages = messages.get().get(code);
        if (_messages == null) {
            _messages = Lists.newArrayList();
        }
        _messages.add(info);
        messages.get().put(code, _messages);
    }

    public static void addError(String message) {
        addMessage(Constants.RESULT_CODE_FAILED, message);
    }

    public static void addError(int code, String message) {
        addMessage(code, message);
    }

    public static void addMessage(String message) {
        addMessage(Constants.RESULT_CODE_SUCCEED, message);
    }

    @Data
    @AllArgsConstructor
    public static class MessageInfo {
        private Integer code = 0;
        private String message;
    }

}
