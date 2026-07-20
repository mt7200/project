package com.sunsheen.hearken.Sunsheen_system.tcm.model.dto.response;

public class LoginResponse {
    private String token;
    private UserInfo user;

    public String getToken() { return token; }
    public void setToken(String token) { this.token = token; }
    public UserInfo getUser() { return user; }
    public void setUser(UserInfo user) { this.user = user; }
}
