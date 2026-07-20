package com.sunsheen.hearken.Sunsheen_system.login.controller;

import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.jfids.hearken.component.login.dto.RoleDTO;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.sunsheen.hearken.Sunsheen_system.login.common.constant.Const.SERVER_API_PATH;

@RestController
@RequiredArgsConstructor
@RequestMapping(SERVER_API_PATH + "/role")
public class RoleController {
    private final SystemManagerStrategyFactory strategyFactory;

    @GetMapping("/page")
    public R<List<RoleDTO>> getRolePageList() {
        return R.success(strategyFactory.getRoleManager().list());
    }
}
