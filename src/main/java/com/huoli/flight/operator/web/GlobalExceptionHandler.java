package com.huoli.flight.operator.web;

import com.huoli.flight.operator.domain.BaseResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Slf4j
@ControllerAdvice(annotations = RestController.class)
public class GlobalExceptionHandler {

    @ExceptionHandler
    @ResponseBody
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public BaseResult<?> jsonErrorHandler(HttpServletRequest req, Exception e) {
        log.error("", e);
        return BaseResult.builder().scm(req.getParameter("scm")).ex(e).build();
    }
}