package com.atguigu.config;

import io.swagger.annotations.ApiOperation;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.oas.annotations.EnableOpenApi;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;

/*====================================================
                时间: 2022-05-18
                讲师: 刘  辉
                出品: 尚硅谷教学团队
======================================================*/
@SpringBootConfiguration
@EnableOpenApi // 开启Swagger支持
@ConfigurationProperties("swagger")
public class SwaggerConfig {

  /**
   * 是否开启swagger，生产环境一般关闭，所以这里定义一个变量
   */
  private Boolean enable;

  /**
   * 项目应用名
   */
  private String applicationName;

  /**
   * 项目版本信息
   */
  private String applicationVersion;

  /**
   * 项目描述信息
   */
  private String applicationDescription;

  @Bean
  public Docket getAdminDocket() {
    return new Docket(DocumentationType.OAS_30)
        .pathMapping("/")
        // 定义是否开启swagger，false为关闭，可以通过变量控制，线上关闭
        .enable(enable)
        // 配置api文档元信息
        .apiInfo(getAdminApiInfo())
        // 选择哪些接口作为swagger的doc发布
        .select()
        // apis() 控制哪些接口暴露给swagger，
        // RequestHandlerSelectors.any() 所有都暴露
        // RequestHandlerSelectors.basePackage("net.xdclass.*")  指定包位置
        // withMethodAnnotation(ApiOperation.class)标记有这个注解 ApiOperation
        .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
        .paths(PathSelectors.any())
        .build();
  }

  public ApiInfo getAdminApiInfo() {
    return new ApiInfoBuilder()
        .title("springCloud微服务实战")
        .description("Gradle构建微服务实战")
        .contact(new Contact("作者名", "", ""))
        .version("1.0")
        //.contact(new Contact("LH","http://www.atguigu.com","xxx@163.com"))
        .build();
  }


}
