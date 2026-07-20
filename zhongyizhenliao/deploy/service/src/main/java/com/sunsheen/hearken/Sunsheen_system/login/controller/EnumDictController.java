package com.sunsheen.hearken.Sunsheen_system.login.controller;


import cn.hutool.core.util.StrUtil;
import com.sunsheen.hearken.Sunsheen_system.login.common.constant.R;
import com.sunsheen.jfids.hearken.component.login.enumdict.EnumDictCollector;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Objects;

import static com.sunsheen.hearken.Sunsheen_system.login.common.constant.Const.SERVER_API_PATH;


@RestController
@RequestMapping(SERVER_API_PATH + "/enums")
public class EnumDictController {
  private final EnumDictCollector enumDictCollector;

  public EnumDictController(EnumDictCollector enumDictCollector) {
    this.enumDictCollector = enumDictCollector;
  }

  @GetMapping("/options")
  public R<List<EnumDictCollector.EnumDictInfo>> getEnumDicts(
      @RequestParam(value = "name", required = false) String name) {
    List<EnumDictCollector.EnumDictInfo> allEnumDicts = enumDictCollector.getAllEnumDicts();
    if (StrUtil.isEmpty(name)) {
      return R.success(allEnumDicts);
    }
    return R.success(allEnumDicts.stream().filter(e -> Objects.equals(e.getName(), name)).toList());
  }
}
