package com.atguigu.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;

/**
 * @author: tang_su
 * @createTime: 2023/09/24 11:13
 * @company: https://www.ts.com
 * @description:
 */
@SpringBootApplication
@ComponentScan("com.atguigu")
@EnableDiscoveryClient
public class GatewayMainStarterApp {

  public static void main(String[] args) {
    try {
      SpringApplication.run(GatewayMainStarterApp.class, args);
    } catch (Exception ex){
      ex.printStackTrace();
    }
  }

}
