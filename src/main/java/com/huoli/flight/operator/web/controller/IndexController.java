package com.huoli.flight.operator.web.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

    @Value("${spring.profiles.active}")
    private String active;

    @RequestMapping(value = {"/index", "/"})
    public String index(Model model) {
        model.addAttribute("active", active);
        return "index";
    }

    @RequestMapping(value = "/main")
    public String main() {
        return "/main";
    }

    @RequestMapping(value = "/404")
    public String four04() {
        return "error/404";
    }

    @RequestMapping(value = "/500")
    public String five00() {
        return "error/500";
    }
}
