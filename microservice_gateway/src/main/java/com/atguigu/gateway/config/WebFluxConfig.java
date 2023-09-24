package com.atguigu.gateway.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.codec.ServerCodecConfigurer;

/**
 * @author: tang_su
 * @createTime: 2023/09/24 11:52
 * @company: https://www.ts.com
 * @description:
 */

@Configuration
public class WebFluxConfig {

  @Bean
  public ServerCodecConfigurer serverCodecConfigurer() {
    return ServerCodecConfigurer.create();
  }
}

