package com.huoli.flight.operator.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.huoli.flight.operator.domain.BaseResult;
import com.huoli.flight.operator.domain.po.PackageInfo;
import com.huoli.flight.operator.service.PackageInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/package")
public class PackageController {

    @Autowired
    private PackageInfoService packageInfoService;

    /**
     * 套餐列表查询
     */
    @RequestMapping("/list")
    public String list(Model model, Integer pageNumber, Integer pageSize) {
        pageNumber = pageNumber == null ? 1 : pageNumber;
        pageSize = pageSize == null ? 5 : pageSize;
        PageHelper.startPage(pageNumber, pageSize);
        List<PackageInfo> list = packageInfoService.queryByCondition();
        // 取分页信息
        PageInfo<PackageInfo> pageInfo = new PageInfo<PackageInfo>(list);
        model.addAttribute("list", list);
        model.addAttribute("page", pageInfo);
        return "package/list";
    }

    /**
     * 更新套餐跳转
     */
    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
    public String toUpdate(Model model, @PathVariable Integer id) {
        model.addAttribute("pkg", packageInfoService.queryById(id));
        return "package/update";
    }

    /**
     * 更新套餐
     */
    @ResponseBody
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public BaseResult update(PackageInfo packageInfo) {
        BaseResult result = BaseResult.builder().build(() -> {
            packageInfoService.doUpdate(packageInfo);
            return null;
        });
        return result;
    }
}
