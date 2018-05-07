package com.huoli.flight.operator.domain;

import com.huoli.flight.operator.util.MessageContext;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;

import java.lang.reflect.Field;
import java.util.concurrent.Callable;

@Slf4j
@Data
public class BaseResult<T> {

    /* 是否成功 1：成功 */
    private boolean success = true;
    /* 错误码 1：成功 */
    private int code = 1;
    /* 信息 */
    private String msg = "success";
    /* 结果 */
    private T data;

    public static BaseResultBuilder builder() {
        return new BaseResultBuilder();
    }

    public static class BaseResultBuilder<T> {
        private String scm;
        private T data;
        private Exception ex;

        BaseResultBuilder() {
        }

        public BaseResultBuilder scm(String scm) {
            this.scm = scm;
            return this;
        }

        public BaseResultBuilder data(T data) {
            this.data = data;
            return this;
        }

        public BaseResultBuilder ex(Exception ex) {
            this.ex = ex;
            return this;
        }

        /**
         * 只适用于无返回值
         */
        public BaseResult build(Callable<?> callable) {
            BaseResult result = getInstance(scm);
            try {
                callable.call();
                handleResult(result);
            } catch (Exception e) {
                result.setCode(GatewayResult.ERR_CODE + GatewayResult.ERR_CODE);
                result.setMsg(HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase() + ", " + e.getMessage());
                log.error("", e);
            }
            return result;
        }

        public BaseResult build() {
            BaseResult result = getInstance(scm);
            result.setData(data);
            handleResult(result);
            handleException(result);
            if (result.getCode() != 1) {
                result.setData(null);
                if (result instanceof GatewayResult) {
                    // 处理code
                    result.setCode(GatewayResult.ERR_CODE + GatewayResult.ERR_CODE + result.getCode());
                    // 处理success
                    try {
                        Field success = result.getClass().getDeclaredField("success");
                        success.setAccessible(true);
                        success.set(result, "false");
                    } catch (Exception e) {
                        log.error("", e);
                    }
                }
            }
            return result;
        }

        private BaseResult getInstance(String scm) {
            BaseResult result = null;
            if ("gateway".equals(scm)) {
                result = new GatewayResult();
            } else {
                result = new BaseResult();
            }
            return result;
        }

        private void handleException(BaseResult result) {
            if (ex != null) {
                result.setCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
                result.setMsg(HttpStatus.INTERNAL_SERVER_ERROR.getReasonPhrase() + ", " + ex.getMessage());
            }
        }

        private void handleResult(BaseResult result) {
            if (MessageContext.hasErrors()) {
                MessageContext.MessageInfo error = MessageContext.getErrors().get(0);
                result.setCode(error.getCode());
                result.setMsg(error.getMessage());
            }
            if (MessageContext.hasMessages()) {
                MessageContext.MessageInfo message = MessageContext.getMessages().get(MessageContext.getMessages().size() - 1);
                result.setCode(message.getCode());
                result.setMsg(message.getMessage());
            }
        }
    }
}
