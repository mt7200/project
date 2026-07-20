/*
 * Proprietary Software License
 *
 * Copyright (c) 2025 iboot
 *
 * This software and its associated documentation ("Software") are proprietary property of iboot.
 * Without explicit written permission from iboot, no individual or entity may:
 *
 * 1. Copy, modify, merge, publish, distribute, sublicense, or sell copies of the Software;
 * 2. Reverse engineer, decompile, or disassemble the Software;
 * 3. Remove or alter any copyright notices or other proprietary markings in the Software;
 * 4. Use the Software for any commercial purposes.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * IBOOT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * The Software may not be used without explicit written permission from iboot.
 * Author: tangsc.
 */

package com.sunsheen.hearken.Sunsheen_system.login.service.impl;

import com.sunsheen.hearken.Sunsheen_system.login.service.AuthService;
import com.sunsheen.hearken.dev.api.bean.SysUser;
import com.sunsheen.jfids.hearken.component.login.dto.ResourceDTO;
import com.sunsheen.jfids.hearken.component.login.dto.UserMenu;
import com.sunsheen.jfids.hearken.component.login.exception.NotFoundException;
import com.sunsheen.jfids.hearken.component.login.handler.SystemAdapterHandler;
import com.sunsheen.jfids.hearken.component.login.strategy.SystemManagerStrategyFactory;
import com.sunsheen.jfids.hearken.component.login.utils.MenuUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {
  @Autowired
  private SystemAdapterHandler systemAdapterHandler;
  @Autowired
  private SystemManagerStrategyFactory strategyFactory;

  @Override
  public List<UserMenu> getUserMenus() {
    SysUser sysUser = systemAdapterHandler.getCurrentUser();
    Assert.notNull(sysUser, "用户不存在");
    // 获取用户所拥有的角色
    List<String> currentRoles = systemAdapterHandler.getUserRole();
    List<String> roleList = new ArrayList<>(currentRoles == null ? List.of() : currentRoles);
    //没有角色获取普通用户菜单
    if (roleList.isEmpty()) {
      roleList.add("R_USER");
    }
    List<ResourceDTO> resources1 = strategyFactory.getResourceManager()
            .getUserResourceByAccount(sysUser.getAccount());
    // 根据角色获取角色所拥有的菜单
    List<ResourceDTO> resources = strategyFactory.getResourceManager().listByRoleList(roleList);
    List<ResourceDTO> unionList = Stream.concat(resources1.stream(), resources.stream())
            .distinct()
            .collect(Collectors.toList());
    if (unionList.isEmpty()) {
      throw new NotFoundException("用户未分配菜单");
    }
    return MenuUtil.generateUserMenus(unionList);
  }
}
