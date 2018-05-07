package com.huoli.flight.operator.config;

import com.huoli.flight.operator.util.MessageContext;
import com.huoli.flight.operator.util.RequestContext;
import com.huoli.flight.operator.util.WebUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.web.servlet.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Configuration
public class WebMvcConfigurer extends WebMvcConfigurerAdapter {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/assets/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new HandlerInterceptorAdapter() {
            @Override
            public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
                RequestContext.init(request, response);
                String ip = request.getRemoteAddr();
                String url = request.getRequestURI();
                String method = request.getMethod();
                String params = WebUtil.getParams(request);
                log.info("request >> {} {} {}", ip, method, url);
                log.info(" params >> {}", params);
                return true;
            }

            @Override
            public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
                RequestContext.remove();
                MessageContext.remove();
            }
        }).addPathPatterns("/**");
        super.addInterceptors(registry);
    }

    @Bean
    public EmbeddedServletContainerCustomizer containerCustomizer() {
        return (ConfigurableEmbeddedServletContainer container) -> {
            container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/404"));
            container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/500"));
            container.addErrorPages(new ErrorPage(Throwable.class, "/500"));
        };
    }
}