// package com.sunsheen.hearken.Sunsheen_system.login.config;
// import java.io.IOException;
// import java.util.Map;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.core.annotation.Order;
// import org.springframework.stereotype.Component;
// import com.sunsheen.hearken.Sunsheen_system.login.common.util.InsertLogUtil;
// import com.sunsheen.hearken.Sunsheen_system.login.infrastructure.persistence.entity.User;
// import com.sunsheen.hearken.Sunsheen_system.login.service.UserService;
// import cn.dev33.satoken.stp.StpUtil;
// import jakarta.servlet.Filter;
// import jakarta.servlet.FilterChain;
// import jakarta.servlet.ServletException;
// import jakarta.servlet.ServletRequest;
// import jakarta.servlet.ServletResponse;
// import jakarta.servlet.http.HttpServletRequest;

// @Component
// @Order(1)  // 优先级最高，最先执行
// public class GlobalExceptionFilter implements Filter {
    
//     @Autowired
//     private UserService userService;
    
//     @Autowired
//     private InsertLogUtil insertLogUtil;
    
//     @Override
//     public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//             throws IOException, ServletException {
//         HttpServletRequest httpRequest = (HttpServletRequest) request;
//         try {
//             // 执行后续的过滤器链（包括Sa-Token拦截器）
//             chain.doFilter(request, response);
//         } catch (Exception e) {
//             // 记录异常日志
//             recordExceptionLog(e, httpRequest);
//         }
//     }
//     private void recordExceptionLog(Exception e, HttpServletRequest request) {
//         try {
//             String account = "unknown";
//             // 注意：这里可能获取不到用户信息，因为还没登录
//             try {
//                 String userId = StpUtil.getLoginIdAsString();
//                 if (userId != null) {
//                     User user = userService.getById(userId);
//                     if (user != null) {
//                         account = user.getAccount();
//                     }
//                 }
//             } catch (Exception ex) {
//                 // 未登录，忽略
//             }
//             Map<String, Object> logParams = insertLogUtil.buildLoginLogParams(account, 2);
//             insertLogUtil.saveLoginLog(logParams, e.getMessage());
//         } catch (Exception logEx) {
         
//         }
//     }
// }