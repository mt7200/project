package com.sunsheen.hearken.Sunsheen_system;

//import com.sunsheen.jfids.das.spring.registry.client.annotation.EnableRegistryClient;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;



//执行包就放开，依赖包就注释
@SpringBootApplication(scanBasePackages = {"com.sunsheen"})
@EnableTransactionManagement//开始注解版事务
public class Sunsheen_systemApplication {

    public static void main(String[] args) { 
        SpringApplication.run(Sunsheen_systemApplication.class, args);
    }

}
