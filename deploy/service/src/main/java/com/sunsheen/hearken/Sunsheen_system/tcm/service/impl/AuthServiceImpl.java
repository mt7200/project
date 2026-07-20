package com.sunsheen.hearken.Sunsheen_system.tcm.service.impl;

import cn.dev33.satoken.secure.BCrypt;
import cn.dev33.satoken.stp.StpUtil;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.request.LoginRequest;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.LoginResponse;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response.UserInfo;
import com.sunsheen.hearken.Sunsheen_system.tcm.model.entity.User;
import com.sunsheen.hearken.Sunsheen_system.tcm.repository.UserRepository;
import com.sunsheen.hearken.Sunsheen_system.tcm.service.AuthService;
import org.springframework.stereotype.Service;

@Service("tcmAuthServiceImpl")
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;

    public AuthServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public LoginResponse login(LoginRequest request) {
        User user = userRepository.findByUsernameAndIsActive(request.getUsername(), true)
                .orElseThrow(() -> new RuntimeException("用户名或密码错误"));

        if (!BCrypt.checkpw(request.getPassword(), user.getPasswordHash())) {
            throw new RuntimeException("用户名或密码错误");
        }

        StpUtil.login(user.getId());
        String token = StpUtil.getTokenValue();

        UserInfo userInfo = new UserInfo();
        userInfo.setId(user.getId());
        userInfo.setUsername(user.getUsername());
        userInfo.setRealName(user.getRealName());
        userInfo.setRole(user.getRole());

        LoginResponse resp = new LoginResponse();
        resp.setToken(token);
        resp.setUser(userInfo);
        return resp;
    }

    @Override
    public void logout() {
        StpUtil.logout();
    }

    @Override
    public UserInfo getCurrentUserInfo() {
        long loginId = StpUtil.getLoginIdAsLong();
        User user = userRepository.findById(loginId)
                .orElseThrow(() -> new RuntimeException("用户不存在"));

        UserInfo info = new UserInfo();
        info.setId(user.getId());
        info.setUsername(user.getUsername());
        info.setRealName(user.getRealName());
        info.setRole(user.getRole());
        return info;
    }
}
